module Examples.E1.Dynamics(discreteLinearDynamicsS1, discreteLinearDynamics, nonlinearDynamics, linearDynamics) where

import Numeric.AD
import Numeric.LinearAlgebra
import Data.List.Split (chunksOf)
import Examples.E1.Discretization

discreteLinearDynamicsS1:: [R] -> [R] -> (Matrix R, [Matrix R])
discreteLinearDynamicsS1 x u = discreteLinearDynamics x u 0.1

discreteLinearDynamics :: [R] -> [R] -> Double -> (Matrix R, [Matrix R])
discreteLinearDynamics x u = forwardEulerMulti (linearDynamics x u)

linearDynamics :: [R] -> [R] -> (Matrix R, [Matrix R])
linearDynamics x u = (a,bs)
  where
    a = mat ?? (All, Take 12)
    bs = map (\p -> ball ?? (All, Pos (fromList p))) (chunksOf 2 [0..5])

    ball = mat ?? (All, Drop 12)
    mat = (12><18) res :: Matrix R
    res = concat (jacobian system (x ++ u))

-- Overall system consisting of three players
system :: Floating a => [a] -> [a]
system xu = concat (zipWith (\sys (x,u) -> sys x u) dyn xuv)
  where
    dyn = [carDyn,carDyn,bicDyn]
    (xs, us) = splitAt 12 xu
    xuv = zip (chunksOf 4 xs) (chunksOf 2 us)

nonlinearDynamics :: Floating a => [a] -> [a] -> [a]
nonlinearDynamics x u = concat (zipWith (\sys (xs,us) -> sys xs us) dyn xuv)
  where
    dyn = [carDyn,carDyn,bicDyn]
    xuv = zip (chunksOf 4 x) (chunksOf 2 u)

-- Model equations
carDyn :: Floating a => [a] -> [a] -> [a]
carDyn [_, _, th, v] [w, a] = [v * cos th, v * sin th, w, a]
carDyn _ _ = error "Invalid arguments"

bicDyn :: Floating a => [a] -> [a] -> [a]
bicDyn [_, _, psi, v] [a,deltaf] = [v * cos (psi+beta), v * sin (psi+beta), v / lr * sin beta, a]
  where
    (lf, lr) = (0.5, 0.5)
    beta = atan (lr / (lf+lr) * tan deltaf)
bicDyn _ _ = error "Invalid arguments"