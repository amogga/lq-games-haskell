{-# OPTIONS_GHC -Wno-partial-fields #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# LANGUAGE RankNTypes #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Example.Simulation where 

import Prelude hiding ((<>))
import Numeric.LinearAlgebra
import Solver.LQGame
import Control.Monad.State
import Control.Monad (zipWithM)
import Type.Basic
import Type.Player
import Dynamics.DiscreteModels
import Example.Quadratization
import Example.Utilities
import Algorithm.ODESolver
import Type.Quadratization
import Type.Dynamics
import qualified Type.Simulation as TS

runSimulationWithIterationAndMaxTime :: SystemDynamicsFunctionType -> CostFunctionType -> [Player R] -> TS.SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTime dyn totcost players simParamsMaxT = runSimulationWithIterationAndHorizon dyn totcost players (TS.horizonSimParamsFromMaxTime simParamsMaxT)

runSimulationWithIterationAndHorizon :: SystemDynamicsFunctionType -> CostFunctionType -> [Player R] -> TS.SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizon dyn totcost players (TS.SimulationParametersWithHorizon iterationsCount sample horizon) states input =  take (iterationsCount + 1) $ iterate (overallSolver dyn totcost players sample) stateControlPairs
    where
        stateControlPairs = generateInitialStateControlPairs dyn states input sample horizon

overallSolver :: SystemDynamicsFunctionType -> CostFunctionType -> [Player R] -> DiscreteSample -> [StateControlData] -> [StateControlData]
overallSolver dyn totcost players sample statesInput = controlStateResponseSolver dyn sample initialState statesInput pAndAlpha
    where
        pAndAlpha = lqGameSolverWStateControl dyn totcost players sample statesInput
        initialState = priorState $ head statesInput

lqGameSolverWStateControl :: SystemDynamicsFunctionType -> CostFunctionType -> [Player R] -> DiscreteSample -> [StateControlData] -> [PAndAlpha]
lqGameSolverWStateControl dyn totCost players sample stateControlPair = lqGameSolver dynlist costslist
    where 
        dynlist = reverse $ discreteLinearDynamics dyn sample stateControlPair
        costslist = reverse $ quadratizeCosts totCost players stateControlPair

controlStateResponseSolver :: SystemDynamicsFunctionType -> DiscreteSample -> Vector R -> [StateControlData] -> [PAndAlpha] -> [StateControlData]
controlStateResponseSolver dyn sample initialStates stateControlData pAndAlpha = evalState (zipWithM (computeControlStateStep dyn sample) stateControlData pAndAlpha) initialStates

computeControlStateStep :: SystemDynamicsFunctionType -> DiscreteSample -> StateControlData -> PAndAlpha -> State StateResponseSolverState StateControlData
computeControlStateStep dyn sample cspair (PAndAlpha p alpha) = do
    x <- get
    let xref = priorState cspair
        uref = controlInput cspair
        alphaScale = 0.1

    let u = reshape 1 uref - p <> (reshape 1 x - reshape 1 xref) - scale alphaScale alpha
        xn = rk4Solve dyn sample x (flatten u)

    put xn
    return $ StateControlWResponse x (flatten u) xn

-- simulation maximum iteration returns (maxIter + 1) array length because the array contains the initial value
-- runSimulationWithTermination :: CostFunctionType -> [Player R] -> Vector R -> Vector R -> Double -> Int -> R -> Int -> [[StateControlData]]
-- runSimulationWithTermination totcost players states input tolerance maxIteration sample horizon =  take (maxIteration+1) $ takeWhile condition $ iterate (\xu -> overallSolver totcost players xu sample) stateControlPairs
--     where
--         stateControlPairs = generateInitialStateControlPairs states input sample horizon
--         condition x = norm_2 (responseState (nextVal x) - priorState (nextVal x)) ** 2 > tolerance
--         nextVal x = last $ overallSolver totcost players x sample
