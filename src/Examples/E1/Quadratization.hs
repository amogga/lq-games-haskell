{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module Examples.E1.Quadratization where

-- import Data.Matrix
import Numeric.AD
import Numeric.LinearAlgebra
import Algorithms.Helpers
import Data.List.Split (chunksOf)
import Types.Basic
import Data.List (transpose)
import Examples.E1.Costs.TotalCost

quadratizeCosts :: StateControlData -> LinearMultiSystemCosts
quadratizeCosts stateControlPair = LinearMultiSystemCosts qs ls rs
  where
    (qs,ls,rs) = unzip3 $ map extractComponents [1..3]
    StateControlPair x u = stateControlPair
    extractComponents player = 
      let LinearSystemCosts q l r = quadratizeCostsForPlayer x u player
      in (q, l, r)

quadratizeCostsForPlayer :: Vector R -> Vector R -> Int -> LinearSystemCosts
quadratizeCostsForPlayer x u player = LinearSystemCosts qs ls rs
  where
    (qs,rs) = stateInputHessian x u player
    ls = systemStateGradient x u player

stateInputHessian :: Vector R -> Vector R -> Int -> (Matrix R, [Matrix R])
stateInputHessian states input player =  (q,rs)
  where
    rs = map (\(x,y) -> ar ?? (Range x 1 y, Range x 1 y)) [(0,1),(2,3),(4,5)]
    ar = stInHess ?? (Drop 12, Drop 12)
    q = stInHess ?? (Take 12, Take 12)
    stInHess = matrix (stlen + inlen) (concat (hessian totalCost' (toList $ vjoin [states, input])))
    (stlen, inlen) = (size states,size input)

    totalCost' statesinput = uncurry totalCost xu player
      where xu = splitAt stlen statesinput

systemStateGradient :: Vector R -> Vector R -> Int -> Vector R
systemStateGradient states input player = vector (take stlen (grad totalCost' (toList $ vjoin [states, input])))
  where
    stlen = size states
    totalCost' statesinput = uncurry totalCost xu player
      where xu = splitAt stlen statesinput


