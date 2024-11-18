module Main (main) where

import Criterion.Main
import Simulation
import Criterion.Types (Config(jsonFile, reportFile, csvFile))

main :: IO ()
main = do
  let config = defaultConfig
          { jsonFile = Just "bench/reports/report.json",
            csvFile = Just "bench/reports/summary.csv",
            reportFile = Just "bench/reports/report.html"
        }
          
  defaultMainWith config [
            bgroup "LQ Solver" [
              bench "Total Cost" $ nf quadratizeCostsT initPairs,
              bench "Equilibrium" $ nf (runSimulationWithIterationAndMaxTimeT simParamsMaxT initState) initInput
           ]
        ]
