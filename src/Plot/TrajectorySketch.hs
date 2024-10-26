module Plot.TrajectorySketch where

import Diagrams.Prelude
import Diagrams.Backend.SVG
import Diagrams.Backend.SVG.CmdLine
-- import Diagrams.Backend.Rasterific
-- import Diagrams.Backend.Rasterific.CmdLine


-- Function to plot lines between points
plotLine :: [(Double, Double)] -> Diagram B
plotLine points = strokeLine (fromVertices (map p2 points)) 
                 # lc blue 
                 # lw thick 


myCircle :: Diagram B
myCircle = circle 2
            # frame 0.1
            # bg white



createPlot :: IO ()
createPlot = do
    let points = [(1, 1), (2, 3), (3, 2), (4, 4), (5, 1)]
        diagram = plotLine points 

    renderSVG "plot.svg" (mkWidth 400) diagram

