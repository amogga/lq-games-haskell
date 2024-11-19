module Players where

import Type.Player
import Type.Position
import Type.Index
import qualified Type.CostInfo as I
import qualified Type.Weight as W
import Diagrams.Prelude (sRGB24read)

allPositionIndices :: [[Int]]
allPositionIndices = [[0,1],[4,5],[8,9]]

inputsIndices :: [[Int]]
inputsIndices = [[0,1],[2,3],[4,5]]

player1 :: Floating a => Player a
player1 = let
              -- state and input costs
              costInfo1 = I.CostInfo4 { I.goal = Position (-2.0,50.0),
                                      I.lane = [[-2.0,-1000.0],[-2.0,1000.0]], I.laneBoundary = 2.5,
                                      I.minVelocity = 0, I.maxVelocity = 15, I.nominalVelocity = 8,
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

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 10,
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
              -- state and input costs
              costInfo1 = I.CostInfo4 { I.goal = Position (12,12),
                                      I.lane = [[-10, 1000.0],[-10,18],[-10 + 0.5, 15],[-10 + 1.0,14],[-10 + 3, 12.5],[-10 + 6, 12], [1000,12]], I.laneBoundary = 2.5,
                                      I.minVelocity = 0, I.maxVelocity = 12, 
                                      I.nominalVelocity = 5,
                                      I.nominalHeading = -(pi/2),
                                      I.proximity = 6
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight4 { W.goal = 1,
                                            W.lane = 25, W.laneBoundary = 3,
                                            W.maxVelocity = 10, W.minVelocity = 10, 
                                            W.nominalVelocity = 100,
                                            W.nominalHeading = 10,
                                            W.proximity = 10
                                          }

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 100,
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

player3 :: Floating a => Player a
player3 = let
              -- state and input costs
              costInfo1 = I.CostInfo4 { I.goal = Position (15,16),
                                      I.lane = [[-1000,16],[1000,16]], I.laneBoundary = 2.5,
                                      I.minVelocity = 0, I.maxVelocity = 5, I.nominalVelocity = 1.5,
                                      I.nominalHeading = 0,
                                      I.proximity = 6
                                    }

              -- state and input weights
              stateWeight1 = W.StateWeight4 { W.goal = 2 ,
                                            W.lane = 50, W.laneBoundary = 3,
                                            W.maxVelocity = 10, W.minVelocity = 10, 
                                            W.nominalVelocity = 100,
                                            W.nominalHeading = 10,
                                            W.proximity = 10
                                          }

              inputWeight1 = W.InputWeight1 { W.angularVelocity = 100,
                                            W.acceleration = 10
                                          }

              -- indices
              stateIndex1 = StateIndex1 { positionStateIndices = [8,9],
                                          psiStateIndex = 10,
                                          velocityStateIndex = 11,
                                          allPositionStateIndices = allPositionIndices
                                        }
              inputIndex1 = InputIndex1 { angularVelocityInputIndex = 4,
                                          accelerationInputIndex = 5,
                                          allInputs = inputsIndices
                                        }


            in Car {
                    stateIndex = stateIndex1,
                    inputIndex = inputIndex1,
                    costInfo = costInfo1,
                    stateWeight = stateWeight1,
                    inputWeight = inputWeight1,
                    color = sRGB24read "#6a5acd" -- purple
                }
