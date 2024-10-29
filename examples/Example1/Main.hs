{-# LANGUAGE ScopedTypeVariables #-}
module Main (main) where

import Numeric.LinearAlgebra
import Simulation
import Plot.CreateGifs




main :: IO ()
main = do
    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    let iters = runSimulationWithTerminationE1 states input 2e-4 100

    createAnimationWithIterations players iters