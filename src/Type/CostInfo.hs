{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.CostInfo (CostInfo(..)) where 

import qualified Type.Position as P

data CostInfo a = CostInfo1 {
                        goal :: P.Position a,
                        lane :: [[a]],
                        laneBoundary :: a,
                        maxVelocity :: a,
                        minVelocity :: a,
                        nominalVelocity :: a,
                        proximity :: a
                    } |
                    CostInfo2 {
                        goal :: P.Position a,
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
                    } | 
                    CostInfo4 {
                        goal :: P.Position a,
                        lane :: [[a]],
                        laneBoundary :: a,
                        maxVelocity :: a,
                        minVelocity :: a,
                        nominalVelocity :: a,
                        nominalHeading :: a,
                        proximity :: a
                    }


instance Functor CostInfo where
  fmap f (CostInfo1 gl polyline threshold maxVel minVel nomVel prox) =
    CostInfo1 (fmap f gl) (map (map f) polyline) (f threshold) (f maxVel) (f minVel) (f nomVel) (f prox)
  fmap f (CostInfo2 gl maxVel minVel nomVel prox) =
    CostInfo2 (fmap f gl) (f maxVel) (f minVel) (f nomVel) (f prox)
  fmap f (CostInfo3 nomVel nomHeading prox ln laneBound) =
    CostInfo3 (f nomVel) (f nomHeading) (f prox) (map (map f) ln) (f laneBound)
  fmap f (CostInfo4 gol polyline threshold maxVel minVel nomVel nomHead prox) =
    CostInfo4 (fmap f gol) (map (map f) polyline) (f threshold) (f maxVel) (f minVel) (f nomVel) (f nomHead) (f prox)

