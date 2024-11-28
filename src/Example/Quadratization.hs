module Example.Quadratization (quadratizeCosts) where

import Numeric.LinearAlgebra
import Type.Basic
import Type.Quadratization
import Type.Player
import qualified Type.Index as ID
import Numeric.AD


quadratizeCosts :: Monad m => CostFunctionType -> [Player R] -> m StateControlData -> m LinearMultiSystemCosts
quadratizeCosts tcost players stateControlPair = lmultiSystemCostsFromlsCosts . quadratizeCosts' tcost players <$> stateControlPair

-- FIXME: handle nan values correctly
quadratizeCosts' :: Monad m => CostFunctionType -> m (Player R) -> StateControlData -> m LinearSystemCosts
quadratizeCosts' tcost playerm stateControlPair = do
  player <- playerm

  let states = toList $ priorState stateControlPair
  let inputs = toList $ controlInput stateControlPair

  let allInputs = ID.allInputs $ inputIndex player

  let convertNaNZero v = if isNaN v then 0 else v

  let qs = matrix (length states) $ map convertNaNZero $ concat $ stateHessian tcost player states inputs
  let ls = vector $ map convertNaNZero $ stateGradient tcost player states inputs
  let ar = matrix (length inputs) $ map convertNaNZero $ concat $ inputHessian tcost player states inputs
  let rs = map (\l -> ar ?? (Pos $ idxs l, Pos $ idxs l)) allInputs

  return $ LinearSystemCosts qs ls rs

stateGradient :: (Floating a, Ord a) => CostFunctionType -> Player a -> [a] -> [a] -> [a]
stateGradient totCost player states input = grad (\x -> totCost (fmap auto player) x (map auto input)) states

stateHessian :: (Floating a, Ord a) => CostFunctionType -> Player a -> [a] -> [a] -> [[a]]
stateHessian totCost player states input = hessian (\x -> totCost (fmap auto player) x (map auto input)) states

inputHessian :: (Floating a, Ord a) => CostFunctionType -> Player a -> [a] -> [a] -> [[a]]
inputHessian totCost player states = hessian (totCost (fmap auto player) (map auto states))