{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
module Main where

import Numeric.LinearAlgebra
import Simulation

main :: IO ()
main = do
    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    -- let iters = runSimulationWithTerminationE1 states input 2e-4 10
    let iters = runSimulationWithIterationE1 states input 56

   -- let iterIndex = 55
   -- let horizonIndex = 19
    -- print $ priorState $ iters !! iterIndex !! horizonIndex
    -- print $ controlInput $ iters !! iterIndex !! horizonIndex
    -- createAnimationWithIterations players iters
    let costs = map totalCostsForPlayersPerIterationE1 iters

    print $ last  costs
