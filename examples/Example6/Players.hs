module Players where

import Type.Player
import Type.Position
import Type.Index
import qualified Type.CostInfo as I
import qualified Type.Weight as W
import Diagrams.Prelude (sRGB24read)

allPositionIndices :: [[Int]]
allPositionIndices = [[0,1],[4,5]]

inputsIndices :: [[Int]]
inputsIndices = [[0,1],[2,3]]

player1 :: Floating a => Player a
player1 = let
              -- state and input costs (car heading north in head-on scenario)
              costInfo1 = I.CostInfo4 { I.goal = Position (-2.0,50.0),
                                      I.lane = [[-2.0,-1000.0],[-2.0,1000.0]], I.laneBoundary = 2.5,
                                      I.minVelocity = 0, I.maxVelocity = 8, I.nominalVelocity = 5,
                                      I.nominalHeading = pi/2,
                                      I.proximity = 6
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight4 { W.goal = 1,
                                            W.lane = 25, W.laneBoundary = 3,
                                            W.minVelocity = 10, W.maxVelocity = 10, W.nominalVelocity = 100,
                                            W.nominalHeading = 10,
                                            W.proximity = 10
                                          }

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 5,
                                              W.acceleration = 10 }


              -- indices
              stateIndex1 = StateIndex1 { positionStateIndices = [0,1],
                                          psiStateIndex = 2,
                                          velocityStateIndex = 3,
                                          allPositionStateIndices = allPositionIndices
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
                      color = sRGB24read "#cd5c5c" -- red
                  }


player2 :: Floating a => Player a
player2 = let
              -- state and input costs (car heading south in head-on scenario)
              costInfo1 = I.CostInfo4 { I.goal = Position (-2.0,-50.0),
                                      I.lane = [[-2.0,-1000.0],[-2.0,1000.0]], I.laneBoundary = 2.5,
                                      I.minVelocity = 0, I.maxVelocity = 8, I.nominalVelocity = 5,
                                      I.nominalHeading = -(pi/2),
                                      I.proximity = 6
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight4 { W.goal = 1,
                                            W.lane = 25, W.laneBoundary = 3,
                                            W.maxVelocity = 10, W.minVelocity = 10, W.nominalVelocity = 100,
                                            W.nominalHeading = 10,
                                            W.proximity = 10
                                          }

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 5,
                                            W.acceleration = 10
                                          }

              -- indices
              stateIndex1 = StateIndex1 { positionStateIndices = [4,5],
                                          psiStateIndex = 6,
                                          velocityStateIndex = 7,
                                          allPositionStateIndices = allPositionIndices
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
                    color = sRGB24read "#40826D" -- green
                }
