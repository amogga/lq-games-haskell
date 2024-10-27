{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

module Example.Quadratization where

-- import Data.Matrix
import Numeric.AD
import Numeric.LinearAlgebra
import Type.Basic
import Example.Cost.TotalCost
import Type.Player

quadratizeCosts :: [Player R] -> StateControlData -> LinearMultiSystemCosts
quadratizeCosts players stateControlPair = LinearMultiSystemCosts qs ls rs
  where
    (qs,ls,rs) = unzip3 $ map extractComponents players
    StateControlPair x u = stateControlPair
    extractComponents player =
      let LinearSystemCosts q l r = quadratizeCostsForPlayer x u player
      in (q, l, r)

quadratizeCostsForPlayer :: Vector R -> Vector R -> Player R -> LinearSystemCosts
quadratizeCostsForPlayer x u player = LinearSystemCosts qs ls rs
  where
    qs = stateHessian x u player    
    ls = systemStateGradient x u player
    rs = inputHessian x u player

stateHessian :: Vector R -> Vector R -> Player R -> Matrix R
stateHessian states input player = matrix (size states) $ concat $ hessian totalCost' (toList states)
  where
    totalCost' x = totalCost (fmap auto player) x (map auto (toList input)) 

inputHessian :: Vector R -> Vector R -> Player R -> [Matrix R]
inputHessian states input player = rs
  where
    ar = matrix (size input) $ concat $ hessian totalCost' (toList input)
    totalCost' u = totalCost (fmap auto player) (map auto (toList states)) u 
    rs = map (\(x,y) -> ar ?? (Range x 1 y, Range x 1 y)) [(0,1),(2,3),(4,5)]

systemStateGradient :: Vector R -> Vector R -> Player R -> Vector R
systemStateGradient states input player = vector $ grad totalCost' (toList states)
  where
    totalCost' x = totalCost (fmap auto player) x (map auto (toList input)) 
