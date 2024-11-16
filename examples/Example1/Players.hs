module Players where

import Type.Player
import Type.Position
import Type.Index
import qualified Type.CostInfo as I
import qualified Type.Weight as W
import Diagrams.Prelude (sRGB24read)


inputsIndices :: [[Int]]
inputsIndices = [[0,1],[2,3],[4,5]]

player1 :: Floating a => Player a
player1 = let
              -- state and input costs
              costInfo1 = I.CostInfo1 { I.goal = Position (6.0,35.0),
                                      I.lane = [[6.0,-100.0],[6.0,100.0]], I.laneBoundary = 1,
                                      I.minVelocity = 0, I.maxVelocity = 10, I.nominalVelocity = 8,
                                      I.proximity = 2
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight1 { W.goal = 4,
                                            W.lane = 50, W.laneBoundary = 50,
                                            W.minVelocity = 100, W.maxVelocity = 100, W.nominalVelocity = 0,
                                            W.proximity = 100
                                          }

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 25,
                                            W.acceleration = 1 }


              -- indices
              stateIndex1 = StateIndex1 { positionStateIndices = [0,1],
                                          psiStateIndex = 2,
                                          velocityStateIndex = 3,
                                          allPositionStateIndices = [[0,1],[4,5],[8,9]]
                                        }

              inputIndex1 = InputIndex1 { angularVelocityInputIndex = 0,
                                          accelerationInputIndex = 1,
                                          allInputs = inputsIndices
                                        }

              in Car {
                      stateIndex = stateIndex1,
                      inputIndex = inputIndex1,
                      costInfo = costInfo1,
                      stateWeight = stateWeight1,
                      inputWeight = inputWeight1,
                      color = sRGB24read "#cd5c5c"
                  }


player2 :: Floating a => Player a
player2 = let
              -- state and input costs
              costInfo1 = I.CostInfo1 { I.goal = Position (12,12),
                                      I.lane = [[2.0,100.0],[2.0,18.0],[2.5,15.0],[3.0,14.0],[5.0,12.5],[8.0,12.0],[100.0,12.0]], I.laneBoundary = 1,
                                      I.minVelocity = 0, I.maxVelocity = 10, I.nominalVelocity = 5,
                                      I.proximity = 2
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight1 { W.goal = 4,
                                            W.lane = 50, W.laneBoundary = 50,
                                            W.maxVelocity = 100, W.minVelocity = 100, W.nominalVelocity = 0,
                                            W.proximity = 100
                                          }

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 25,
                                            W.acceleration = 1
                                          }

              -- indices
              stateIndex1 = StateIndex1 { positionStateIndices = [4,5],
                                          psiStateIndex = 6,
                                          velocityStateIndex = 7,
                                          allPositionStateIndices = [[0,1],[4,5],[8,9]]
                                        }
              inputIndex1 = InputIndex1 { angularVelocityInputIndex = 2,
                                          accelerationInputIndex = 3,
                                          allInputs = inputsIndices
                                        }


            in Car {
                    stateIndex = stateIndex1,
                    inputIndex = inputIndex1,
                    costInfo = costInfo1,
                    stateWeight = stateWeight1,
                    inputWeight = inputWeight1,
                    color = sRGB24read "#40826D"
                }

bicycle :: Floating a => Player a
bicycle = let
              -- state and input costs
              costInfo1 = I.CostInfo2 { I.goal = Position (15,21),
                                      I.minVelocity = 0, I.maxVelocity = 7, I.nominalVelocity = 4,
                                      I.proximity = 1
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight2 { W.goal = 1,
                                            W.maxVelocity = 100, W.minVelocity = 100, W.nominalVelocity = 0,
                                            W.proximity = 100
                                          }
              inputWeight1 = W.InputWeight2 { W.steeringAngle = 1,
                                            W.acceleration = 1
                                          }

              -- indices
              inputIndex2 = InputIndex2 { steeringAngleInputIndex = 4,
                                          accelerationInputIndex = 5,
                                          allInputs = inputsIndices
                                        }
              stateIndex2 = StateIndex1 { positionStateIndices = [8,9],
                                          psiStateIndex = 10,
                                          velocityStateIndex = 11,
                                          allPositionStateIndices = [[0,1],[4,5],[8,9]]
                                        }

            in Bicycle {
              stateIndex = stateIndex2,
              inputIndex = inputIndex2,
              costInfo = costInfo1,
              stateWeight = stateWeight1,
              inputWeight = inputWeight1,
              color = sRGB24read "#6a5acd"
            }
