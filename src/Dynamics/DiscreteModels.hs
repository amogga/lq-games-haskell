module Dynamics.DiscreteModels where

import Type.Basic
import Numeric.LinearAlgebra
import Algorithm.Discretization
import Dynamics.MultiModels

discreteLinearDynamicsVS1:: StateControlData -> LinearMultiSystemDynamics
discreteLinearDynamicsVS1 xu = discreteLinearDynamicsS1 (priorState xu) (controlInput xu)

discreteLinearDynamicsS1:: Vector R -> Vector R -> LinearMultiSystemDynamics
discreteLinearDynamicsS1 x u = discreteLinearDynamics x u 0.25

discreteLinearDynamics :: Vector R -> Vector R -> Double -> LinearMultiSystemDynamics 
discreteLinearDynamics x u s = LinearDiscreteMultiSystemDynamics {systemMatrix = ad, inputMatrices = bsd, samplingPeriod = s}
  where 
    ad = systemMatrix dlinsys
    bsd = inputMatrices dlinsys
    dlinsys = forwardEulerMulti (linearDynamics x u) s
