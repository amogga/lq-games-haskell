{-# LANGUAGE RankNTypes #-}
module Dynamics.DiscreteModels (discreteLinearDynamics) where

import Type.Basic
import Algorithm.Discretization
import Dynamics.MultiModels
import Type.Dynamics

discreteLinearDynamics :: Monad m => SystemDynamicsFunctionType -> DiscreteSample -> m StateControlData -> m LinearMultiSystemDynamics 
discreteLinearDynamics dyn sample cspair = forwardEulerMulti sample . linearDynamics dyn <$> cspair