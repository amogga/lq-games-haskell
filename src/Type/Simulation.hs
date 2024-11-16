module Type.Simulation where

data SimulationParameters = SimulationParametersWithHorizon { iterationCount :: Int, sample :: Double, horizon :: Int} |
                            SimulationParametersWithMaxTime { iterationCount :: Int, sample :: Double, maxTime :: Double}
                            deriving (Show)
