module Examples.E1.ODESolver (nonlinearDynamicsSolve) where

import Numeric.LinearAlgebra
import Examples.E1.Dynamics

nonlinearDynamicsSolve :: [R] -> [R] -> [R]
nonlinearDynamicsSolve = rk4Solve nonlinearDynamics

rk4Solve :: ([R] -> [R] -> [R]) -> [R] -> [R] -> [R]
rk4Solve stateFnc x u = last $ take (n + 1) $ iterate (\xs -> rungeKutta4MethodInstance stateFnc xs u h) x
  where h = t / fromIntegral n
        n = 10
        t = 0.25

rungeKutta4MethodInstance :: ([R] -> [R] -> [R]) -> [R] -> [R] -> R -> [R]
rungeKutta4MethodInstance stateFnc x u h = toList $ vector x + xns
  where
  xns = scalar (h / 6.0) * (k1 + scalar 2 * k2 + scalar 2 * k3 + k4)

  k1 = vector $ stateFnc x u
  k2 = vector $ vectorStateFunction (vector x + scalar (h / 2.0) * k1) u
  k3 = vector $ vectorStateFunction (vector x + scalar (h / 2.0) * k2) u
  k4 = vector $ vectorStateFunction (vector x + scalar h * k3) u

  vectorStateFunction xs = stateFnc (toList xs)
