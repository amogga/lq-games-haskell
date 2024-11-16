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
-- runSimulationWithTermination :: CostFunctionType -> [Player R] -> Vector R -> Vector R -> Double -> Int -> R -> Int -> [[StateControlData]]
-- runSimulationWithTermination totcost players states input tolerance maxIteration sample horizon =  take (maxIteration+1) $ takeWhile condition $ iterate (\xu -> overallSolver totcost players xu sample) stateControlPairs
--     where
--         stateControlPairs = generateInitialStateControlPairs states input sample horizon
--         condition x = norm_2 (responseState (nextVal x) - priorState (nextVal x)) ** 2 > tolerance
--         nextVal x = last $ overallSolver totcost players x sample

runSimulationWithIterationAndHorizon :: CostFunctionType -> [Player R] -> Vector R -> Vector R -> Int -> R -> Int -> [[StateControlData]]
runSimulationWithIterationAndHorizon totcost players states input iterationsCount sample horizon =  take (iterationsCount + 1) $ iterate (overallSolver totcost players sample) stateControlPairs
    where
        stateControlPairs = generateInitialStateControlPairs states input sample horizon

overallSolver :: CostFunctionType -> [Player R] -> Double -> [StateControlData] -> [StateControlData]
overallSolver totcost players sample statesInput = controlStateResponseSolver sample initialState statesInput pAndAlpha
    where
        pAndAlpha = lqGameSolverWStateControl totcost players sample statesInput
        initialState = priorState $ head statesInput

lqGameSolverWStateControl :: CostFunctionType -> [Player R] -> Double -> [StateControlData] -> [PAndAlpha]
lqGameSolverWStateControl totCost players sample stateControlPair = lqGameSolver dynlist costslist
    where 
        dynlist = reverse $ map (discreteLinearDynamics sample) stateControlPair
        costslist = reverse $ map (quadratizeCosts totCost players) stateControlPair

computeControlStateStep :: Double -> StateControlData -> PAndAlpha -> State StateResponseSolverState StateControlData
computeControlStateStep sample cspair (PAndAlpha p alpha) = do
    x <- get
    let xref = priorState cspair
        uref = controlInput cspair
        alphaScale = 0.1

    let u = reshape 1 uref - p <> (reshape 1 x - reshape 1 xref) - scale alphaScale alpha
        xn = nonlinearDynamicsSolve x (flatten u) sample

    put xn
    return $ StateControlWResponse x (flatten u) xn

controlStateResponseSolver :: Double -> Vector R -> [StateControlData] -> [PAndAlpha] -> [StateControlData]
controlStateResponseSolver sample initialStates stateControlData pAndAlpha = evalState (zipWithM (computeControlStateStep sample) stateControlData pAndAlpha) initialStates
