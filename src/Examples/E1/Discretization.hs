module Examples.E1.Discretization(forwardEulerMulti) where

import Prelude hiding ((<>))
import Numeric.LinearAlgebra

forwardEulerMulti :: (Matrix R, [Matrix R]) -> Double -> (Matrix R, [Matrix R])
forwardEulerMulti (a, bs) ts = (ad, bd)
  where
    ad = ident (rows a) + scale ts a
    bd = map (scale ts) bs