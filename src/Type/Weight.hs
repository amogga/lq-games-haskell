{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.Weight (StateWeight(..),InputWeight(..)) where

data StateWeight a = 
            StateWeight1 { 
                goalW :: a,
                polylineW :: a,
                polylineBoundaryW :: a,
                maxVelocityW :: a,
                minVelocityW :: a,
                nominalVelocityW :: a,
                proximityW :: a
            } |
            StateWeight2 {
                goalW :: a,
                maxVelocityW :: a,
                minVelocityW :: a,
                nominalVelocityW :: a,
                proximityW :: a
            } |
            StateWeight3 {
                nominalVelocity:: a,
                nominalHeading:: a,
                proximity :: a,
                lane ::a,
                laneBoundary :: a
            } deriving (Show, Eq)

data InputWeight a = 
            InputWeight1 { 
                angularVelocityW :: a,
                accelerationW :: a
            } |
            InputWeight2 {
                steeringAngleW :: a,
                accelerationW :: a
            } |
            InputWeight3 {
                angularVelocity:: a,
                acceleration :: a  
            } deriving (Show, Eq)


instance Functor StateWeight where
  fmap f (StateWeight1 goalWht polylineWht boundaryW maxVelW minVelW nomVelW proxW) =
    StateWeight1 (f goalWht) (f polylineWht) (f boundaryW) (f maxVelW) (f minVelW) (f nomVelW) (f proxW)
  fmap f (StateWeight2 goalWht maxVelW minVelW nomVelW proxW) =
    StateWeight2 (f goalWht) (f maxVelW) (f minVelW) (f nomVelW) (f proxW)
  fmap f (StateWeight3 nomVel nomHead prox lane laneBoundary) =
    StateWeight3 (f nomVel) (f nomHead) (f prox) (f lane) (f laneBoundary)

instance Functor InputWeight where
  fmap f (InputWeight1 angVelW accW) = InputWeight1 (f angVelW) (f accW)
  fmap f (InputWeight2 steerAngleW accW) = InputWeight2 (f steerAngleW) (f accW)
  fmap f (InputWeight3 angVelW accW) = InputWeight3 (f angVelW) (f accW)
