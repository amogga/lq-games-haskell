module Type.Simulation where

data SimulationParameters = SimulationParametersWithHorizon { iterationCount :: Int, sample :: Double, horizon :: Int} |
                            SimulationParametersWithMaxTime { iterationCount :: Int, sample :: Double, maxTime :: Double}

horizonSimParamsFromMaxTime :: SimulationParameters -> SimulationParameters
horizonSimParamsFromMaxTime (SimulationParametersWithMaxTime iterCount smple maxT) =  
                             SimulationParametersWithHorizon iterCount smple (floor (maxT/smple))
horizonSimParamsFromMaxTime _ = error "invalid parameters"