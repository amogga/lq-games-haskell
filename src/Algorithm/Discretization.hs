module Algorithm.Discretization where

import Prelude hiding ((<>))
import Numeric.LinearAlgebra
import Types.Basic

forwardEulerMulti :: LinearMultiSystemDynamics -> Double -> LinearMultiSystemDynamics
forwardEulerMulti (LinearContinuousMultiSystemDynamics a bs) ts = LinearDiscreteMultiSystemDynamics ad bd ts
  where
    ad = ident (rows a) + scale ts a
    bd = map (scale ts) bs
forwardEulerMulti _ _ = error "Invalid arguments passed to functions"