{-# OPTIONS_GHC -Wno-partial-fields #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
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
    
runSimulationWithTermination :: [Player R] -> Vector R -> Vector R -> Double -> Int -> [[StateControlData]]
runSimulationWithTermination players states input termination maxIteration =  take maxIteration $ takeWhile condition $ iterate (overallSolver players) stateControlPairs
    where
        horizon = 20
        stateControlPairs = generateInitialStateControlPairs states input horizon
        condition x = norm_2 (responseState (nextVal x) - priorState (nextVal x)) ** 2 > termination
        nextVal x = last $ overallSolver players x

runSimulationWithIteration :: [Player R] -> Vector R -> Vector R -> Int -> [[StateControlData]]
runSimulationWithIteration players states input iterationsCount =  take iterationsCount $ iterate (overallSolver players) stateControlPairs
    where
        horizon = 20
        stateControlPairs = generateInitialStateControlPairs states input horizon

overallSolver :: [Player R] -> [StateControlData] -> [StateControlData]
overallSolver players statesInput = controlStateResponseSolver initialState statesInput pAndAlpha
    where
        pAndAlpha = lqGameSolverWStateControl players statesInput
        initialState = priorState $ head statesInput

lqGameSolverWStateControl :: [Player R] -> [StateControlData] -> [PAndAlpha]
lqGameSolverWStateControl players stateControlPair = lqGameSolver dynlist costslist
    where 
        dynlist = reverse $ map discreteLinearDynamicsVS1 stateControlPair
        costslist = reverse $ map (quadratizeCosts players) stateControlPair

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

computeControlStateStepN :: StateControlData -> PAndAlpha -> State StateResponseSolverState StateControlData
computeControlStateStepN cspair pAndAlpha = do
    x <- get
    let StateControlPair xref uref = cspair
    let PAndAlpha p alpha = pAndAlpha
    let alphaScale = 0.1

    let u = reshape 1 uref - p <> (reshape 1 x - reshape 1 xref) - scale alphaScale alpha
    let xn = nonlinearDynamicsSolve x (flatten u)
    put xn
    return $ StateControlPair x (flatten u)

controlStateResponseSolver :: Vector R -> [StateControlData] -> [PAndAlpha] -> [StateControlData]
controlStateResponseSolver initialStates stateControlData pAndAlpha = evalState (zipWithM computeControlStateStep stateControlData pAndAlpha) initialStates