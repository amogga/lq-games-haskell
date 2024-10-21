module Main (main) where

import Examples.E1.Dynamics
import Examples.E1.Costs
import Examples.E1.ODESolver
import Criterion.Main


main :: IO ()
main = do
    let states = [6.5, 0.0, pi / 2.0, 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = [0,0,0,0,0,0]
    let inputr = [1.2, -0.4, 5.44, 1.23, 0.98, 5.4]::[Double]
    -- let (ad,bd) = discreteLinearDynamicsS1 states input
    -- let (qs,ls,rs) = quadratizeCosts states input
    -- let res = rungeKutta4Method linearDynamics states input 0.25
    print $ nonlinearDynamicsSolve states inputr


-- main :: IO ()
-- main = defaultMain [
--            bench "Total Costs" $ whnf (quadratizeCosts states) input
--         ]
--         where
--             states = [6.5, 0.0, pi / 2.0, 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
--             input = [0,0,0,0,0,0]