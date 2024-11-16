module Main (main) where

import Criterion.Main
import Example.Quadratization
import Numeric.LinearAlgebra
import Type.Basic
import Simulation (quadratizeCostsE)

main :: IO ()
main = defaultMain [
           bench "Total Costs" $ whnf quadratizeCostsE pairs
        ]
        where
            states = vector [6.5, 0.0, pi / 2.0, 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
            input = vector [0,0,0,0,0,0]
            pairs = StateControlPair states input
