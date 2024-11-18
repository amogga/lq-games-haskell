{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}
module Plot.TrajectorySketch where

import Diagrams.Prelude
import Diagrams.Backend.Cairo
import Type.Player
import qualified Type.CostInfo as I
import Type.Utilities
import Type.Basic
import Type.Plot
import Data.Maybe (fromJust)
import Plot.Plotter

goalSpot :: Player Double -> Diagram B
goalSpot player = circle 0.2
                # lc (color player)
                # moveTo (p2 $ tupleFromPosition $ I.goal $ costInfo player)

spot :: Player Double -> (Double,Double) -> Diagram B
spot player tuple = circle 0.2
                # fc (color player)
                # lw none
                # moveTo (p2 tuple)

createDiagram :: Player Double -> [StateControlData] -> Diagram B
createDiagram player iterationData = do
    let
        playerinitPosition = tupleFromPosition $ positionOfPlayerFromStateControlData player (head iterationData)
        playerSpot = spot player playerinitPosition

        positions = map (positionOfPlayerFromStateControlData player) iterationData
        diagram = plotCPosition positions (color player)

    diagram <> playerSpot

createDiagramWithGoals :: Player Double -> [StateControlData] -> Diagram B
createDiagramWithGoals player iterationData = do
    let
        playerinitPosition = tupleFromPosition $ positionOfPlayerFromStateControlData player (head iterationData)
        playerSpot = spot player playerinitPosition

        playerGoal = goalSpot player

        positions = map (positionOfPlayerFromStateControlData player) iterationData
        diagram = plotCPosition positions (color player)
    diagram <> playerSpot <> playerGoal

createCar :: Player Double -> [StateControlData] -> Diagram B
createCar player iterationData = do
    let playerinitPosition = tupleFromPosition $ positionOfPlayerFromStateControlData player (last iterationData)
    let playerinitPsi = psiOfPlayerFromStateControlData player (last iterationData)
    roundedRect 2 1 0.1 # lw none # fc (color player)
                        # rotate (playerinitPsi @@ rad)
                        # translate (r2 playerinitPosition)

addIterationCount :: Int -> Diagram B
addIterationCount iterationCount = do
    text ("Iterations: " ++ show iterationCount) # translate (r2 (15, 0)) # fontSizeL 0.45

createPlot :: PlotExtension -> [Player Double] -> String -> Int -> [StateControlData] -> IO ()
createPlot pext players plotname iterationCount iterationData = do
    let
        combinedPlot = mconcat $ map (`createDiagram` iterationData) players
        combinedCars = mconcat $ map (`createCar` iterationData) players

        polyline1 = map (fromJust . positionFromList) (I.lane $ costInfo (players !! 0))
        polyline2 = map (fromJust . positionFromList) (I.lane $ costInfo (players !! 1))

        
        comb = combinedCars <> combinedPlot <> addIterationCount iterationCount :: QDiagram Cairo V2 Double Any

        polyPlot1 = plotBPosition polyline1 silver # lw thin # withEnvelope (boundingBox comb)
        polyPlot2 = plotBPosition polyline2 silver # lw thin # withEnvelope (boundingBox comb)

        restr = comb <> polyPlot1 <> polyPlot2
        finalPlot = bg white (restr # centerXY # padX 1.3 # padY 1.1 )
        -- finalPlotv = view (p2 (1, 2) :: Point V2 Double) (p2 (3, 34) :: Point V2 Double) finalPlot

    -- renderCairo ("plots/iterations/" ++ plotname ++ extensionToString pext) (mkWidth 400) finalPlot
    renderCairo ("plots/iterations/" ++ plotname ++ extensionToString pext) (mkSizeSpec2D (Just 300) (Just 600)) finalPlot

    -- mapM_ (\ext -> renderCairo ("plots/iterations/" ++ plotname ++ "." ++ ext) (mkWidth 400) finalPlot) ["png","pdf"]

createSimulationPlot :: PlotExtension -> String -> [Player Double] -> String -> [StateControlData] -> IO ()
createSimulationPlot pext filepath players plotname iterationData = do
    let
        combinedPlot = mconcat $ map (`createDiagram` iterationData) players
        combinedCars = mconcat $ map (`createCar` iterationData) players

        polyline1 = map (fromJust . positionFromList) (I.lane $ costInfo (players !! 0))
        polyline2 = map (fromJust . positionFromList) (I.lane $ costInfo (players !! 1))

        
        comb = combinedCars <> combinedPlot :: QDiagram Cairo V2 Double Any

        polyPlot1 = plotBPosition polyline1 silver # lw thin # withEnvelope (boundingBox comb)
        polyPlot2 = plotBPosition polyline2 silver # lw thin # withEnvelope (boundingBox comb)

        restr = comb <> polyPlot1 <> polyPlot2
        finalPlot = bg white (restr # centerXY # padX 1.3 # padY 1.1 )
        -- finalPlotv = view (p2 (1, 2) :: Point V2 Double) (p2 (3, 34) :: Point V2 Double) finalPlot

    -- renderCairo ("plots/iterations/" ++ plotname ++ extensionToString pext) (mkWidth 400) finalPlot
    renderCairo (filepath ++ "/plots/simulation/" ++ plotname ++ extensionToString pext) (mkSizeSpec2D (Just 300) (Just 600)) finalPlot

    -- mapM_ (\ext -> renderCairo ("plots/iterations/" ++ plotname ++ "." ++ ext) (mkWidth 400) finalPlot) ["png","pdf"]

createSimulationPlotWithGoals :: PlotExtension -> String -> [Player Double] -> String -> [StateControlData] -> IO ()
createSimulationPlotWithGoals pext filepath players plotname iterationData = do
    let
        combinedPlot = mconcat $ map (`createDiagramWithGoals` iterationData) players
        combinedCars = mconcat $ map (`createCar` iterationData) players

        polyline1 = map (fromJust . positionFromList) (I.lane $ costInfo (players !! 0))
        polyline2 = map (fromJust . positionFromList) (I.lane $ costInfo (players !! 1))

        
        comb = combinedCars <> combinedPlot :: QDiagram Cairo V2 Double Any

        polyPlot1 = plotBPosition polyline1 silver # lw thin # withEnvelope (boundingBox comb)
        polyPlot2 = plotBPosition polyline2 silver # lw thin # withEnvelope (boundingBox comb)

        restr = comb <> polyPlot1 <> polyPlot2
        finalPlot = bg white (restr # centerXY # padX 1.3 # padY 1.1 )
        -- finalPlotv = view (p2 (1, 2) :: Point V2 Double) (p2 (3, 34) :: Point V2 Double) finalPlot

    -- renderCairo ("plots/iterations/" ++ plotname ++ extensionToString pext) (mkWidth 400) finalPlot
    renderCairo (filepath ++ "/plots/simulation/" ++ plotname ++ extensionToString pext) (mkSizeSpec2D (Just 300) (Just 600)) finalPlot

    -- mapM_ (\ext -> renderCairo ("plots/iterations/" ++ plotname ++ "." ++ ext) (mkWidth 400) finalPlot) ["png","pdf"]


createPNGPlot :: [Player Double] -> String -> Int -> [StateControlData] -> IO ()
createPNGPlot = createPlot PNGext

createSimulationPNGPlot :: String -> [Player Double] -> String -> [StateControlData] -> IO ()
createSimulationPNGPlot = createSimulationPlot PNGext

createSimulationPNGPlotWithGoals :: String -> [Player Double] -> String -> [StateControlData] -> IO ()
createSimulationPNGPlotWithGoals = createSimulationPlotWithGoals PNGext
