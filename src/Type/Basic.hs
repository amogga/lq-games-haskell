module Type.Basic where

import Numeric.LinearAlgebra

type StateResponseSolverState = Vector R

data LinearMultiSystemDynamics = LinearContinuousMultiSystemDynamics {systemMatrix :: Matrix R, inputMatrices :: [Matrix R]} | 
                                 LinearDiscreteMultiSystemDynamics { systemMatrix :: Matrix R, inputMatrices :: [Matrix R], samplingPeriod :: Double } deriving (Show)


data LinearMultiSystemCosts = LinearMultiSystemCosts { statesHessians :: [Matrix R], statesGradients:: [Vector R], inputHessians :: [[Matrix R]] } deriving (Show)

data LinearSystemCosts = LinearSystemCosts { qMatrix :: Matrix R, lMatrix:: Vector R, rMatrices :: [Matrix R] } deriving (Show)



data StateControlData = StateControlPair {  priorState:: Vector R,  controlInput:: Vector R} deriving (Show)

data LQGameState = LQGameState { z::[Matrix R], zeta::[Vector R] } deriving (Show)
data PAndAlpha = PAndAlpha { pMatrix :: Matrix R, alphaMatrix :: Matrix R} deriving (Show)