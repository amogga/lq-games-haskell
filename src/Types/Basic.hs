module Types.Basic where

import Numeric.LinearAlgebra

data LinearMultiSystemDynamics = LinearContinuousMultiSystemDynamics {systemMatrix :: Matrix R, inputMatrices :: [Matrix R]} | 
                                 LinearDiscreteMultiSystemDynamics { systemMatrix :: Matrix R, inputMatrices :: [Matrix R], samplingPeriod :: Double } deriving (Show)


data LinearMultiSystemCosts = LinearMultiSystemCosts { statesHessians :: [Matrix R], statesGradients:: [Vector R], inputHessians :: [[Matrix R]] } deriving (Show)

data LinearSystemCosts = LinearSystemCosts { statesHessian :: Matrix R, stateGradient:: Vector R, inputHessian :: [Matrix R] }



data StateControlData = StateControlPair {  priorState:: Vector R,  controlInput:: Vector R} deriving (Show)
