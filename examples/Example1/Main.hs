{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
module Main where

import Numeric.LinearAlgebra
import Simulation
import Plot.CreateGifs
import TotalCost
import Example.Quadratization
import Dynamics.MultiModels
import Example.Utilities (generateInitialStateControlPairs)

main :: IO ()
main = do
    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    -- let iters = runSimulationWithTerminationE1 states input 2e-4 50

    -- createAnimationWithIterations players iters
    -- let costs = map totalCostsForPlayersPerIterationE1 iters
    -- let ans2 = grad (\x -> totcost player1 x (map auto us)) sts

    -- let answer = stateGradientT totcost player1 sts us
    -- let answerMain = stateGradientT totalCost player1 (toList states) (toList input)
    print $ last $ generateInitialStateControlPairs states input 20
    -- print answer
    -- print answerMain
    -- let res3 = quadratizeCostsForPlayerAB totalCost states input player1

    -- let reso = systemStateGradient states input player1 
    -- let rrr = quadratizeCostsForPlayer player1 states input
    -- let r32 = quadratizeCostsForPlayerABC (GradientFunction totalCost) player1 (ActiveApply states) (InactiveApply input)
    -- let r32 = quadratizeCostsForPlayerABCN totalCost player1 states input
    -- print $ costs
    -- let res = map (\p -> quadratizeCostsForPlayer totalCost p states input) players

    -- print res
    -- let rs = grady totalCost player1 states input
    -- let hs = hessy totalCost player1 states input
    -- print hs
-- ffwplayer :: (Floating a) => Player a -> [a] -> a
-- ffwplayer player [x, y] = x^2 + y^2 + x*(maxVelocityC $ costInfo player)

-- findg :: (Traversable f, Floating a) => (forall s. (Reifies s Tape, Typeable s) => Player (Reverse s a) -> f (Reverse s a) -> Reverse s a) -> f a -> f a
-- findg gg xx = grad (\x -> gg player1 x) xx
-- let res = findg ffwplayer [1.1,2.0]