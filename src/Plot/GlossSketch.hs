module Plot.GlossSketch where

import Graphics.Gloss

drawPlot :: [(Float, Float)] -> Picture
drawPlot points = Line [(x * 50, y * 50) | (x, y) <- points]

createPlotViaGloss :: IO ()
createPlotViaGloss = do
    let points = [(0, 0), (1, 2), (2, 1), (3, 3), (4, 2)]  -- Example points
    let plotPicture = drawPlot points
    display (InWindow "Nice Window" (400, 400) (300, 300)) white plotPicture