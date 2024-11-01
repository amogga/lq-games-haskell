{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.CostInfo (CostInfo(..)) where 

import Type.Position

data CostInfo a = CostInfo1 {
                        goalC :: Position a,
                        polylineC :: [[a]],
                        polylineBoundaryThresholdC :: a,
                        maxVelocityC :: a,
                        minVelocityC :: a,
                        nominalVelocityC :: a,
                        proximityC :: a
                    } |
                    CostInfo2 {
                        goalC :: Position a,
                        maxVelocityC :: a,
                        minVelocityC :: a,
                        nominalVelocityC :: a,
                        proximityC :: a
                    } deriving (Show, Eq)


instance Functor CostInfo where
  fmap f (CostInfo1 goal polyline threshold maxVel minVel nomVel prox) =
    CostInfo1 (fmap f goal) (map (map f) polyline) (f threshold) (f maxVel) (f minVel) (f nomVel) (f prox)
  fmap f (CostInfo2 goal maxVel minVel nomVel prox) =
    CostInfo2 (fmap f goal) (f maxVel) (f minVel) (f nomVel) (f prox)