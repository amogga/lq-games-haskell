{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE RankNTypes #-}
module Type.Quadratization where

import Type.Player
import Numeric.AD.Mode.Sparse.Double

type StateCostFunctionType f = forall s. Player (AD s SparseDouble) -> f (AD s SparseDouble) -> [AD s SparseDouble] -> AD s SparseDouble
type InputCostFunctionType f = forall s. Player (AD s SparseDouble) -> [AD s SparseDouble] -> f (AD s SparseDouble) -> AD s SparseDouble

type GenericCostFunctionType = forall s. Player (AD s SparseDouble) -> [AD s SparseDouble] -> [AD s SparseDouble] -> AD s SparseDouble
