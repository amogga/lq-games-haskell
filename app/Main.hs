module Main (main) where

import Example.Cost.TotalCost
import Numeric.LinearAlgebra
import Example.Cost.ProximityCost
import Plot.GlossSketch
import Plot.TrajectorySketch

main :: IO ()
main = do
    -- let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    -- let input = vector [0,0,0,0,0,0]
    let states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = [0,0,0,0,0,0]

    
    -- let prox = proximityCost [[3,0.4],[5.5,2.3],[4.4,3]] player
    -- let pos = Position (2.2,4)
    -- let pos2 = Position (4.4,5)
    -- createPlotViaGloss
    -- createPlot
    print "sd"
    -- putStrLn "Hello, World!"