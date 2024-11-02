{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# HLINT ignore "Use newtype instead of data" #-}

module Example.Quadratization where

-- import Data.Matrix
import Numeric.AD
import Numeric.LinearAlgebra
import Type.Basic
import Example.TotalCost
import Type.Player
import Numeric.AD.Mode.Reverse (Reverse)
import Data.Reflection (Reifies)
import Numeric.AD.Internal.Reverse (Tape)
import Type.Reflection (Typeable)
import Numeric.AD.Internal.On
import Numeric.AD.Internal.Sparse

type StateHessianFunctionType f a = forall s. (Reifies s Tape, Typeable s) => Player (On (Reverse s (Sparse a))) -> f (On (Reverse s (Sparse a))) -> [On (Reverse s (Sparse a))] -> On (Reverse s (Sparse a))
type InputHessianFunctionType f a = forall s. (Reifies s Tape, Typeable s) => Player (On (Reverse s (Sparse a))) -> [On (Reverse s (Sparse a))] -> f (On (Reverse s (Sparse a))) -> On (Reverse s (Sparse a))
type StateGradientFunctionType f a = forall s. (Reifies s Tape, Typeable s) => Player (Reverse s a) -> f (Reverse s a) -> [Reverse s a] -> Reverse s a
type GenericGradientFunctionType a = forall s. (Reifies s Tape, Typeable s) => Player (Reverse s a) -> [Reverse s a] -> [Reverse s a] -> Reverse s a
type GenericHessianFunctionType a = forall s. (Reifies s Tape, Typeable s) => Player (On (Reverse s (Sparse a))) -> [On (Reverse s (Sparse a))] -> [On (Reverse s (Sparse a))] -> On (Reverse s (Sparse a))

type ActiveApplyType f a = f a
type InactiveApplyType a = [a]

quadratizeCosts :: [Player R] -> StateControlData -> LinearMultiSystemCosts
quadratizeCosts players stateControlPair = LinearMultiSystemCosts qs ls rs
  where
    (qs,ls,rs) = unzip3 $ map extractComponents players
    x = priorState stateControlPair
    u = controlInput stateControlPair
    extractComponents player =
      let LinearSystemCosts q l r = quadratizeCostsForPlayer player x u
      in (q, l, r)


quadratizeCostsForPlayer :: Player R -> Vector R -> Vector R -> LinearSystemCosts
quadratizeCostsForPlayer player x u = LinearSystemCosts qs ls rs
  where
    qs = matrix (size x) $ concat $ stateHessian totalCost player states inputs
    ls = vector $ stateGradient totalCost player states inputs
    ar = matrix (size u) $ concat $ inputHessian totalCost player states inputs
    rs = map (\(a,b) -> ar ?? (Range a 1 b, Range a 1 b)) [(0,1),(2,3),(4,5)]

    states = toList x
    inputs = toList u

-- Generic Gradient and Hessians (taking `totalcost` as argument)

stateHessian :: (Traversable f, Floating a) => StateHessianFunctionType f a -> Player a -> ActiveApplyType f a -> InactiveApplyType a -> f (f a)
stateHessian totCost player states input = hessian totalCost' states
  where
    totalCost' x = totCost (fmap auto player) x (map auto input)

inputHessian :: (Traversable f, Floating a) => InputHessianFunctionType f a -> Player a -> InactiveApplyType a -> ActiveApplyType f a -> f (f a)
inputHessian totCost player states input = hessian totalCost' input
  where
    totalCost' u = totCost (fmap auto player) (map auto states) u

stateGradient :: (Traversable f, Floating a) => StateGradientFunctionType f a -> Player a -> ActiveApplyType f a -> InactiveApplyType a -> ActiveApplyType f a 
stateGradient totCost player states input = grad totalCost' states
  where 
    totalCost' x = totCost (fmap auto player) x (map auto input)
