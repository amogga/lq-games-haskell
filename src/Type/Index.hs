{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.Index(InputIndex(..),StateIndex(..)) where 

data InputIndex = InputIndex1 {
                    angularVelocityInputIndex :: Int,
                    accelerationInputIndex :: Int
                } | 
                InputIndex2 {
                    steeringAngleInputIndex :: Int,      
                    accelerationInputIndex :: Int
                } deriving (Show, Eq)

data StateIndex = StateIndex1 {
                    positionStateIndices:: [Int],
                    psiStateIndex :: Int,
                    velocityStateIndex:: Int
                } deriving (Show, Eq)
