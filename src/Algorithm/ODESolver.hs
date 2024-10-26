module Algorithm.ODESolver (nonlinearDynamicsSolve) where

import Dynamics.MultiModels
import Numeric.LinearAlgebra

nonlinearDynamicsSolve :: Vector R -> Vector R -> Vector R
nonlinearDynamicsSolve = rk4Solve nonlinearDynamics

rk4Solve :: (Vector R -> Vector R -> Vector R) -> Vector R -> Vector R -> Vector R
rk4Solve stateFnc x u = last $ take (n + 1) $ iterate (\xs -> rungeKutta4MethodInstance stateFnc xs u h) x
  where h = t / fromIntegral n
        n = 10
        t = 0.25

rungeKutta4MethodInstance :: (Vector R -> Vector R -> Vector R) -> Vector R -> Vector R -> R -> Vector R
rungeKutta4MethodInstance stateFnc x u h = x + xns
  where
  xns = scalar (h / 6.0) * (k1 + scalar 2 * k2 + scalar 2 * k3 + k4)

  k1 = stateFnc x u
  k2 = stateFnc (x + scalar (h / 2.0) * k1) u
  k3 = stateFnc (x + scalar (h / 2.0) * k2) u
  k4 = stateFnc (x + scalar h * k3) u