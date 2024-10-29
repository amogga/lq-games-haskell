module Players where

import Type.Player
import Type.Position
import Type.CostInfo
import Type.Weight
import Type.Index
import Diagrams.Prelude (sRGB24read)

player1 :: Floating a => Player a 
player1 = let stateWeight1 = StateWeight1 { goalW = 4, polylineW = 50, polylineBoundaryW = 50, maxVelocityW = 100, minVelocityW = 100, proximityW = 100
                                    }
              inputWeight1 = InputWeight1 { angularVelocityW = 25, accelerationW = 1 }
              costInfo1 = CostInfo1 { goalC = Position (6.0,35.0), polylineC = [[6.0,-100.0],[6.0,100.0]], polylineBoundaryThresholdC = 1, proximityC = 2, maxVelocityC = 10, minVelocityC = 0 }

              inputIndex1 = InputIndex1 { angularVelocityInputIndex = 0, accelerationInputIndex = 1 }
              stateIndex1 = StateIndex1 { positionStateIndices = [0,1], psiStateIndex = 2, velocityStateIndex = 3 }
              
              in Car { 
                      stateIndex = stateIndex1,
                      inputIndex = inputIndex1,
                      costInfo = costInfo1,
                      stateWeight = stateWeight1,
                      inputWeight = inputWeight1,
                      color = sRGB24read "#cd5c5c"                   
                  }
              

player2 :: Floating a => Player a 
player2 = let stateWeight1 = StateWeight1 { goalW = 3, polylineW = 50, polylineBoundaryW = 50, maxVelocityW = 100, minVelocityW = 100, proximityW = 100 }
              inputWeight1 = InputWeight1 { angularVelocityW = 25, accelerationW = 1 }       
              costInfo1 = CostInfo1 { goalC = Position (12,12), polylineC = [[2.0,100.0],[2.0,18.0],[2.5,15.0],[3.0,14.0],[5.0,12.5],[8.0,12.0],[100.0,12.0]], 
                                polylineBoundaryThresholdC = 1, proximityC = 2, maxVelocityC = 10, minVelocityC = 0 }
              inputIndex1 = InputIndex1 { angularVelocityInputIndex = 2, accelerationInputIndex = 3 }
              stateIndex1 = StateIndex1 { positionStateIndices = [4,5], psiStateIndex = 6, velocityStateIndex = 7 }
            in Car { 
                    stateIndex = stateIndex1,
                    inputIndex = inputIndex1,
                    costInfo = costInfo1,
                    stateWeight = stateWeight1,
                    inputWeight = inputWeight1,
                    color = sRGB24read "#40826D"                        
                }

bicycle :: Floating a => Player a 
bicycle = let stateWeight1 = StateWeight2 { goalW = 1, maxVelocityW = 100, minVelocityW = 100, proximityW = 100 }
              inputWeight1 = InputWeight2 { steeringAngleW = 1, accelerationW = 1 }       
              costInfo1 = CostInfo2 { goalC = Position (15,21), proximityC = 1, maxVelocityC = 8, minVelocityC = 0 }
              inputIndex2 = InputIndex2 { steeringAngleInputIndex = 4, accelerationInputIndex = 5 }
              stateIndex2 = StateIndex1 { positionStateIndices = [8,9], psiStateIndex = 10, velocityStateIndex = 11 }

            in Bicycle { 
              stateIndex = stateIndex2,
              inputIndex = inputIndex2,
              costInfo = costInfo1,
              stateWeight = stateWeight1,
              inputWeight = inputWeight1,
              color = sRGB24read "#6a5acd"                     
            }
