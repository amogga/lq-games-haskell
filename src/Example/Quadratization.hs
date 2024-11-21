{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# LANGUAGE RankNTypes #-}
{-# HLINT ignore "Eta reduce" #-}

module Example.Quadratization where

import Numeric.LinearAlgebra
import Type.Basic
import Type.Quadratization
import Type.Player
import qualified Type.Index as ID
import Numeric.AD

quadratizeCosts :: CostFunctionType -> [Player R] -> StateControlData -> LinearMultiSystemCosts
quadratizeCosts tcost players stateControlPair = LinearMultiSystemCosts qs ls rs
  where
    (qs,ls,rs) = unzip3 $ map extractComponents players
    x = priorState stateControlPair
    u = controlInput stateControlPair
    extractComponents player =
      let LinearSystemCosts q l r = quadratizeCostsForPlayer tcost player x u
      in (q, l, r)

-- FIXME: handle nan values
quadratizeCostsForPlayer :: CostFunctionType -> Player R -> Vector R -> Vector R -> LinearSystemCosts
quadratizeCostsForPlayer tcost player x u = LinearSystemCosts qs ls rs
  where
    qs = matrix (size x) $ map convertNaNZero $ concat $ stateHessian tcost player states inputs
    ls = vector $ map convertNaNZero $ stateGradient tcost player states inputs
    ar = matrix (size u) $ map convertNaNZero $ concat $ inputHessian tcost player states inputs
    rs = map (\l -> ar ?? (Pos $ idxs l, Pos $ idxs l)) allInputs
    
    states = toList x
    inputs = toList u

    allInputs = ID.allInputs $ inputIndex player

    convertNaNZero v = if isNaN v then 0 else v

stateGradient :: CostFunctionType -> Player Double -> [Double] -> [Double] -> [Double]
stateGradient totCost player states input = grad (\x -> totCost (fmap auto player) x (map auto input)) states

stateHessian :: CostFunctionType -> Player Double -> [Double] -> [Double] -> [[Double]]
stateHessian totCost player states input = hessian (\x -> totCost (fmap auto player) x (map auto input)) states

inputHessian :: CostFunctionType -> Player Double -> [Double] -> [Double] -> [[Double]]
inputHessian totCost player states = hessian (totCost (fmap auto player) (map auto states))