{-# OPTIONS_GHC -Wno-partial-fields #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Type.Basic where

import Numeric.LinearAlgebra
import GHC.Generics (Generic)
import Control.DeepSeq (NFData)

-- state and control data
type StateResponseSolverState = Vector R
data StateControlData = StateControlPair { priorState:: Vector R,  controlInput:: Vector R } | 
                        StateControlWResponse {  priorState:: Vector R,  controlInput:: Vector R, responseState :: Vector R} deriving (Show, Generic, NFData)

-- linear multi player dynamics
data LinearMultiSystemDynamics = LinearContinuousMultiSystemDynamics {systemMatrix :: Matrix R, inputMatrices :: [Matrix R]} | 
                                 LinearDiscreteMultiSystemDynamics { systemMatrix :: Matrix R, inputMatrices :: [Matrix R], samplingPeriod :: Double } deriving (Show)

-- linear single and multi-player costs
data LinearMultiSystemCosts = LinearMultiSystemCosts { statesHessians :: [Matrix R], statesGradients:: [Vector R], inputHessians :: [[Matrix R]] } deriving (Show)
data LinearSystemCosts = LinearSystemCosts { qMatrix :: Matrix R, lMatrix:: Vector R, rMatrices :: [Matrix R] } deriving (Show)

-- types
data LQGameState = LQGameState { z::[Matrix R], zeta::[Vector R] } deriving (Show)
data PAndAlpha = PAndAlpha { pMatrix :: Matrix R, alphaMatrix :: Matrix R} deriving (Show)