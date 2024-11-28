module Type.Quadratization (CostFunctionType) where

import Type.Player
import Numeric.AD

type CostFunctionType = (forall s. (Mode s, Floating s, Ord s) => Player s -> [s] -> [s] -> s)