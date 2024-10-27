{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.Weight (StateWeight(..),InputWeight(..)) where

data StateWeight a = 
            StateWeight1 { 
                goalW :: a,
                polylineW :: a,
                polylineBoundaryW :: a,
                maxVelocityW :: a,
                minVelocityW :: a,
                proximityW :: a
            } |
            StateWeight2 {
                goalW :: a,
                maxVelocityW :: a,
                minVelocityW :: a,
                proximityW :: a
            } deriving (Show, Eq)

data InputWeight a = 
            InputWeight1 { 
                angularVelocityW :: a,
                accelerationW :: a
            } |
            InputWeight2 {
                steeringAngleW :: a,
                accelerationW :: a
            } deriving (Show, Eq)

instance Functor StateWeight where
  fmap f (StateWeight1 goalW polylineW boundaryW maxVelW minVelW proxW) =
    StateWeight1 (f goalW) (f polylineW) (f boundaryW) (f maxVelW) (f minVelW) (f proxW)
  fmap f (StateWeight2 goalW maxVelW minVelW proxW) =
    StateWeight2 (f goalW) (f maxVelW) (f minVelW) (f proxW)



instance Functor InputWeight where
  fmap f (InputWeight1 angVelW accW) = InputWeight1 (f angVelW) (f accW)
  fmap f (InputWeight2 steerAngleW accW) = InputWeight2 (f steerAngleW) (f accW)
