module Main (main) where

import Criterion.Main
import Simulation
import Criterion.Types (Config(jsonFile, reportFile, csvFile))
import Type.Basic
import GHC.Generics (Generic)
import Control.DeepSeq (NFData)

deriving instance Generic LinearMultiSystemCosts
deriving instance NFData LinearMultiSystemCosts
deriving instance Generic StateControlData
deriving instance NFData StateControlData

main :: IO ()
main = do
  let config = defaultConfig
          { jsonFile = Just "bench/reports/bench2-report.json",
            csvFile = Just "bench/reports/bench2-summary.csv",
            reportFile = Just "bench/reports/bench2-report.html"
        }

  defaultMainWith config [
            bgroup "Example5 Overtaking" [
                bench "Equilibrium" $ nf (runSimulationWithIterationAndHorizonE simParamsHorizon initState) initInput
           ]
        ]

    where
        initPairs = StateControlPair initState initInput
