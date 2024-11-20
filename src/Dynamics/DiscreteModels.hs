{-# LANGUAGE RankNTypes #-}
module Dynamics.DiscreteModels where

import Type.Basic
import Numeric.LinearAlgebra
import Algorithm.Discretization
import Dynamics.MultiModels
import Type.Dynamics

discreteLinearDynamics:: SystemDynamicsFunctionType -> DiscreteSample -> StateControlData -> LinearMultiSystemDynamics
discreteLinearDynamics dyn sample xu = discreteLinearDynamics' dyn sample (priorState xu) (controlInput xu)

discreteLinearDynamics' :: SystemDynamicsFunctionType -> DiscreteSample -> Vector R -> Vector R -> LinearMultiSystemDynamics 
discreteLinearDynamics' dyn s x u = LinearDiscreteMultiSystemDynamics {systemMatrix = ad, inputMatrices = bsd, samplingPeriod = s}
  where 
    ad = systemMatrix dlinsys
    bsd = inputMatrices dlinsys
    dlinsys = forwardEulerMulti (linearDynamics dyn x u) s
