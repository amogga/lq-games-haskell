{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module Example.Quadratization where

-- import Data.Matrix
import Numeric.AD
import Numeric.LinearAlgebra
import Type.Basic
import Example.Cost.TotalCost
import Type.Player

quadratizeCosts :: StateControlData -> [Player R] -> LinearMultiSystemCosts
quadratizeCosts stateControlPair players = LinearMultiSystemCosts qs ls rs
  where
    (qs,ls,rs) = unzip3 $ map extractComponents players
    StateControlPair x u = stateControlPair
    extractComponents player =
      let LinearSystemCosts q l r = quadratizeCostsForPlayerN x u player
      in (q, l, r)

-- quadratizeCostsForPlayer :: Vector R -> Vector R -> Int -> LinearSystemCosts
-- quadratizeCostsForPlayer x u player = LinearSystemCosts qs ls rs
--   where
--     (qs,rs) = stateInputHessian x u player
--     ls = systemStateGradient x u player

-- -- hessian and gradient for states and inputs
-- stateInputHessian :: Vector R -> Vector R -> Int -> (Matrix R, [Matrix R])
-- stateInputHessian states input player =  (q,rs)
--   where
--     rs = map (\(x,y) -> ar ?? (Range x 1 y, Range x 1 y)) [(0,1),(2,3),(4,5)]
--     ar = stInHess ?? (Drop 12, Drop 12)
--     q = stInHess ?? (Take 12, Take 12)
--     stInHess = matrix (stlen + inlen) (concat (hessian totalCost' (toList $ vjoin [states, input])))
--     (stlen, inlen) = (size states,size input)

--     totalCost' statesinput = uncurry totalCost xu player
--       where xu = splitAt stlen statesinput

-- quadratizeCostsForPlayerN :: Vector R -> Vector R -> Player R -> LinearSystemCosts
-- quadratizeCostsForPlayerN x u player = LinearSystemCosts qs ls rs
--   where
--     (qs,rs) = stateInputHessian x u player
--     ls = systemStateGradient x u player

quadratizeCostsForPlayerN :: Vector R -> Vector R -> Player R -> LinearSystemCosts
quadratizeCostsForPlayerN x u player = LinearSystemCosts qs ls rs
  where
    qs = stateHessianM x u player    
    ls = systemStateGradient x u player
    rs = inputHessianM x u player

stateHessianM :: Vector R -> Vector R -> Player R -> Matrix R
stateHessianM states input player = matrix (size states) $ concat $ hessian totalCost' (toList states)
  where
    totalCost' x = totalCostN x (map auto (toList input)) (fmap auto player)

inputHessianM :: Vector R -> Vector R -> Player R -> [Matrix R]
inputHessianM states input player = rs
  where
    ar = matrix (size input) $ concat $ hessian totalCost' (toList input)
    totalCost' u = totalCostN (map auto (toList states)) u (fmap auto player)
    rs = map (\(x,y) -> ar ?? (Range x 1 y, Range x 1 y)) [(0,1),(2,3),(4,5)]

systemStateGradient :: Vector R -> Vector R -> Player R -> Vector R
systemStateGradient states input player = vector $ grad totalCost' (toList states)
  where
    totalCost' x = totalCostN x (map auto (toList input)) (fmap auto player)
