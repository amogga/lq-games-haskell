{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.Weight (StateWeight(..),InputWeight(..)) where

data StateWeight a = 
            StateWeight1 { 
                goal :: a,
                lane :: a,
                laneBoundary :: a,
                maxVelocity :: a,
                minVelocity :: a,
                nominalVelocity :: a,
                proximity :: a
            } |
            StateWeight2 {
                goal :: a,
                maxVelocity :: a,
                minVelocity :: a,
                nominalVelocity :: a,
                proximity :: a
            } |
            StateWeight3 {
                nominalVelocity:: a,
                nominalHeading:: a,
                proximity :: a,
                lane ::a,
                laneBoundary :: a
            } | 
            StateWeight4 { 
                goal :: a,
                lane :: a,
                laneBoundary :: a,
                maxVelocity :: a,
                minVelocity :: a,
                nominalVelocity :: a,
                nominalHeading :: a,
                proximity :: a
            } deriving (Show, Eq)

data InputWeight a = 
            InputWeight1 { 
                angularVelocity :: a,
                acceleration :: a
            } |
            InputWeight2 {
                steeringAngle :: a,
                acceleration :: a
            } |
            InputWeight3 {
                angularVelocity :: a,
                acceleration :: a  
            } deriving (Show, Eq)


instance Functor StateWeight where
  fmap f (StateWeight1 goalWht polylineWht boundaryW maxVelW minVelW nomVelW proxW) =
    StateWeight1 (f goalWht) (f polylineWht) (f boundaryW) (f maxVelW) (f minVelW) (f nomVelW) (f proxW)
  fmap f (StateWeight2 goalWht maxVelW minVelW nomVelW proxW) =
    StateWeight2 (f goalWht) (f maxVelW) (f minVelW) (f nomVelW) (f proxW)
  fmap f (StateWeight3 nomVel nomHead prox lne laneBound) =
    StateWeight3 (f nomVel) (f nomHead) (f prox) (f lne) (f laneBound)
  fmap f (StateWeight4 goalWht polylineWht boundaryW maxVelW minVelW nomVelW nomHeading proxW) =
    StateWeight4 (f goalWht) (f polylineWht) (f boundaryW) (f maxVelW) (f minVelW) (f nomVelW) (f nomHeading) (f proxW)


instance Functor InputWeight where
  fmap f (InputWeight1 angVelW accW) = InputWeight1 (f angVelW) (f accW)
  fmap f (InputWeight2 steerAngleW accW) = InputWeight2 (f steerAngleW) (f accW)
  fmap f (InputWeight3 angVelW accW) = InputWeight3 (f angVelW) (f accW)
