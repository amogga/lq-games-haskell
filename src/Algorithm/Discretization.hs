module Algorithm.Discretization where

import Prelude hiding ((<>))
import Numeric.LinearAlgebra
import Type.Basic

forwardEulerMulti :: DiscreteSample -> LinearMultiSystemDynamics -> LinearMultiSystemDynamics
forwardEulerMulti ts (LinearContinuousMultiSystemDynamics a bs)  = LinearDiscreteMultiSystemDynamics ad bd ts
  where
    ad = ident (rows a) + scale ts a
    bd = map (scale ts) bs
forwardEulerMulti _ _ = error "Invalid arguments passed to functions"