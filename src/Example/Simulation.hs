{-# OPTIONS_GHC -Wno-partial-fields #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# LANGUAGE RankNTypes #-}
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

-- simulation maximum iteration returns (maxIter + 1) array length because the array contains the initial value
runSimulationWithTermination :: CostFunctionType -> [Player R] -> Vector R -> Vector R -> Double -> Int -> [[StateControlData]]
runSimulationWithTermination totcost players states input tolerance maxIteration =  take (maxIteration+1) $ takeWhile condition $ iterate (overallSolver totcost players) stateControlPairs
    where
        horizon = 20
        stateControlPairs = generateInitialStateControlPairs states input horizon
        condition x = norm_2 (responseState (nextVal x) - priorState (nextVal x)) ** 2 > tolerance
        nextVal x = last $ overallSolver totcost players x

runSimulationWithIteration :: CostFunctionType -> [Player R] -> Vector R -> Vector R -> Int -> [[StateControlData]]
runSimulationWithIteration totcost players states input iterationsCount =  take (iterationsCount + 1) $ iterate (overallSolver totcost players) stateControlPairs
    where
        horizon = 20
        stateControlPairs = generateInitialStateControlPairs states input horizon

overallSolver :: CostFunctionType -> [Player R] -> [StateControlData] -> [StateControlData]
overallSolver totcost players statesInput = controlStateResponseSolver initialState statesInput pAndAlpha
    where
        pAndAlpha = lqGameSolverWStateControl totcost players statesInput
        initialState = priorState $ head statesInput

lqGameSolverWStateControl :: CostFunctionType -> [Player R] -> [StateControlData] -> [PAndAlpha]
lqGameSolverWStateControl totCost players stateControlPair = lqGameSolver dynlist costslist
    where 
        dynlist = reverse $ map discreteLinearDynamicsVS1 stateControlPair
        costslist = reverse $ map (quadratizeCosts totCost players) stateControlPair

computeControlStateStep :: StateControlData -> PAndAlpha -> State StateResponseSolverState StateControlData
computeControlStateStep cspair pAndAlpha = do
    x <- get
    let xref = priorState cspair
    let uref = controlInput cspair
    let PAndAlpha p alpha = pAndAlpha
    let alphaScale = 0.1

    let u = reshape 1 uref - p <> (reshape 1 x - reshape 1 xref) - scale alphaScale alpha
    let xn = nonlinearDynamicsSolve x (flatten u)
    put xn
    return $ StateControlWResponse x (flatten u) xn

controlStateResponseSolver :: Vector R -> [StateControlData] -> [PAndAlpha] -> [StateControlData]
controlStateResponseSolver initialStates stateControlData pAndAlpha = evalState (zipWithM computeControlStateStep stateControlData pAndAlpha) initialStates