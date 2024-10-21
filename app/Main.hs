module Main (main) where

import Examples.E1.Dynamics
import Examples.E1.Costs

import Criterion.Main


main :: IO ()
main = do
    let states = [6.5, 0.0, pi / 2.0, 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = [0,0,0,0,0,0]

    let (ad,bd) = discreteLinearDynamicsS1 states input
    let (qs,ls,rs) = quadratizeCosts states input
    print "====="


-- main :: IO ()
-- main = defaultMain [
--            bench "Total Costs" $ whnf (quadratizeCosts states) input
--         ]
--         where
--             states = [6.5, 0.0, pi / 2.0, 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
--             input = [0,0,0,0,0,0]