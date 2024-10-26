module Dynamics.MultiModels where

import Data.List.Split (chunksOf)
import Dynamics.Models
import Numeric.LinearAlgebra
import Types.Basic
import Numeric.AD

linearDynamics :: Vector R -> Vector R -> LinearMultiSystemDynamics
linearDynamics x u = LinearContinuousMultiSystemDynamics { systemMatrix = a, inputMatrices = bs }
  where
    a = mat ?? (All, Take 12)
    bs = map (\p -> ball ?? (All, Pos (fromList p))) (chunksOf 2 [0..5])

    ball = mat ?? (All, Drop 12)
    mat = (12><18) res :: Matrix R
    res = concat (jacobian system (toList $ vjoin [x, u]))

nonlinearDynamics :: Vector R -> Vector R -> Vector R
nonlinearDynamics x u = vector $ concat (zipWith (\sys (xs,us) -> sys xs us) dyn xuv)
  where
    dyn = [carDyn,carDyn,bicDyn]
    xuv = zip (chunksOf 4 $ toList x) (chunksOf 2 $ toList u)

-- Overall system consisting of three players
system :: Floating a => [a] -> [a]
system xu = concat (zipWith (\sys (x,u) -> sys x u) dyn xuv)
  where
    dyn = [carDyn,carDyn,bicDyn]
    (xs, us) = splitAt 12 xu
    xuv = zip (chunksOf 4 xs) (chunksOf 2 us)