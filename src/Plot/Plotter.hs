module Plot.Plotter where

import Diagrams.Prelude
import Diagrams.Backend.Cairo
import Type.Position
import Type.Utilities

-- Function to plot lines between points
plotLine :: [(Double, Double)] -> Colour Double -> Diagram B
plotLine points col = strokeLine (fromVertices (map p2 points))
                 # lc col
                 # moveTo (p2 $ head points)

plotSpline :: [(Double, Double)] -> Colour Double -> Diagram B
plotSpline points col = cubicSpline False (map p2 points)
                 # lc col
                 # lw thin
                 -- # moveTo (p2 $ head points)

plotBSpline :: [(Double, Double)] -> Colour Double -> Diagram B
plotBSpline points col = bspline (map p2 points)
                 # lc col
                 # lw thin

plotPosition :: [Position Double] -> Colour Double -> Diagram B
plotPosition positions = plotLine (map tupleFromPosition positions)

plotBPosition :: [Position Double] -> Colour Double -> Diagram B
plotBPosition positions = plotBSpline (map tupleFromPosition positions)

plotCPosition :: [Position Double] -> Colour Double -> Diagram B
plotCPosition positions = plotSpline (map tupleFromPosition positions)
