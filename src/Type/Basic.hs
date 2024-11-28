module Type.Basic where

import Numeric.LinearAlgebra

type TimeInstant a = a
type DiscreteSample = Double
type Horizon = Int

-- state and control data
type StateResponseSolverState = Vector R
data StateControlData = StateControlPair { priorState:: Vector R,  controlInput:: Vector R } | 
                        StateControlWResponse {  priorState:: Vector R,  controlInput:: Vector R, responseState :: Vector R} deriving (Show)

-- linear multi player dynamics
data LinearMultiSystemDynamics = LinearContinuousMultiSystemDynamics {systemMatrix :: Matrix R, inputMatrices :: [Matrix R]} | 
                                 LinearDiscreteMultiSystemDynamics { systemMatrix :: Matrix R, inputMatrices :: [Matrix R], samplingPeriod :: Double } deriving (Show)

-- linear single and multi-player costs
data LinearMultiSystemCosts = LinearMultiSystemCosts { statesHessians :: [Matrix R], statesGradients:: [Vector R], inputHessians :: [[Matrix R]] } deriving (Show)
data LinearSystemCosts = LinearSystemCosts { qMatrix :: Matrix R, lMatrix:: Vector R, rMatrices :: [Matrix R] } deriving (Show)

lmultiSystemCostsFromlsCosts :: [LinearSystemCosts] -> LinearMultiSystemCosts
lmultiSystemCostsFromlsCosts linearSystemCosts = LinearMultiSystemCosts qs ls rs
    where 
        (qs,ls,rs) = unzip3 $ map extractCosts linearSystemCosts
        extractCosts lc = let LinearSystemCosts qm lv rm = lc in (qm,lv, rm)

-- types
data LQGameState = LQGameState { z::[Matrix R], zeta::[Vector R] }
data PAndAlpha = PAndAlpha { pMatrix :: Matrix R, alphaMatrix :: Matrix R} deriving (Show)