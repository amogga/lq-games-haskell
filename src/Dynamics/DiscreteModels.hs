module Dynamics.DiscreteModels where

import Type.Basic
import Numeric.LinearAlgebra
import Algorithm.Discretization
import Dynamics.MultiModels

discreteLinearDynamics:: Double -> StateControlData -> LinearMultiSystemDynamics
discreteLinearDynamics sample xu = discreteLinearDynamics' sample (priorState xu) (controlInput xu)

discreteLinearDynamics' :: Double -> Vector R -> Vector R -> LinearMultiSystemDynamics 
discreteLinearDynamics' s x u = LinearDiscreteMultiSystemDynamics {systemMatrix = ad, inputMatrices = bsd, samplingPeriod = s}
  where 
    ad = systemMatrix dlinsys
    bsd = inputMatrices dlinsys
    dlinsys = forwardEulerMulti (linearDynamics x u) s
