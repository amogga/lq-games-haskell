{-# LANGUAGE RankNTypes #-}
module Type.Dynamics (SystemDynamicsFunctionType, SystemDynamicsFunctionTypeA, SystemDynamicsFunctionTypeV) where
    
import Numeric.AD
import Numeric.LinearAlgebra

type SystemDynamicsFunctionType = forall s. ((Mode s, Floating s) => [s] -> [s] -> [s])
type SystemDynamicsFunctionTypeV = Vector R -> Vector R -> Vector R
type SystemDynamicsFunctionTypeA = forall s. ((Mode s, Floating s) => [[s] -> [s] -> [s]])