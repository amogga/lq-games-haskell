{-# OPTIONS_GHC -Wno-partial-fields #-}
module Type.Index(InputIndex(..),StateIndex(..)) where 

data InputIndex = InputIndex1 {
                    angularVelocityInputIndex :: Int,
                    accelerationInputIndex :: Int,
                    allInputs :: [[Int]]
                } | 
                InputIndex2 {
                    steeringAngleInputIndex :: Int,      
                    accelerationInputIndex :: Int,
                    allInputs :: [[Int]]
                } 

data StateIndex = StateIndex1 {
                    positionStateIndices:: [Int],
                    psiStateIndex :: Int,
                    velocityStateIndex:: Int,
                    allPositionStateIndices:: [[Int]]
                }
