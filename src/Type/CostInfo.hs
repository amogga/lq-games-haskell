{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.CostInfo (CostInfo(..)) where 

import Type.Position

data CostInfo a = CostInfo1 {
                        goal :: Position a,
                        lane :: [[a]],
                        laneBoundary :: a,
                        maxVelocity :: a,
                        minVelocity :: a,
                        nominalVelocity :: a,
                        proximity :: a
                    } |
                    CostInfo2 {
                        goal :: Position a,
                        maxVelocity :: a,
                        minVelocity :: a,
                        nominalVelocity :: a,
                        proximity :: a
                    } |
                    CostInfo3 {
                        nominalVelocity :: a,
                        nominalHeading :: a,
                        proximity :: a,
                        lane :: [[a]],
                        laneBoundary :: a
                    }


instance Functor CostInfo where
  fmap f (CostInfo1 goal polyline threshold maxVel minVel nomVel prox) =
    CostInfo1 (fmap f goal) (map (map f) polyline) (f threshold) (f maxVel) (f minVel) (f nomVel) (f prox)
  fmap f (CostInfo2 goal maxVel minVel nomVel prox) =
    CostInfo2 (fmap f goal) (f maxVel) (f minVel) (f nomVel) (f prox)
  fmap f (CostInfo3 nomVel nomHeading prox lane laneBound) =
    CostInfo3 (f nomVel) (f nomHeading) (f prox) (map (map f) lane) (f laneBound)
