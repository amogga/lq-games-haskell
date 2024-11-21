{-# LANGUAGE RankNTypes #-}
module Algorithm.ODESolver (rk4Solve) where

import Numeric.LinearAlgebra
import Type.Dynamics
import Type.Basic

rk4Solve :: SystemDynamicsFunctionType -> TimeInstant R -> Vector R -> Vector R -> Vector R
rk4Solve stateFnc instant x u = last $ take (n + 1) $ iterate (\xs -> rungeKutta4MethodInstance stateFnc h xs u) x
  where 
    h = instant / fromIntegral n
    n = 10

rungeKutta4MethodInstance :: SystemDynamicsFunctionType -> TimeInstant R -> Vector R -> Vector R -> Vector R
rungeKutta4MethodInstance stateFnc h x u = x + xns
  where
  xns = scalar (h / 6.0) * (k1 + scalar 2 * k2 + scalar 2 * k3 + k4)

  k1 = stateFncV x u
  k2 = stateFncV (x + scalar (h / 2.0) * k1) u
  k3 = stateFncV (x + scalar (h / 2.0) * k2) u
  k4 = stateFncV (x + scalar h * k3) u

  stateFncV xv uv = vector $ stateFnc (toList xv) (toList uv)