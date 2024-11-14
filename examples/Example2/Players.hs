module Players where

import Diagrams.Prelude (sRGB24read)
import qualified Type.CostInfo as I
import qualified Type.Weight as W
import Type.Index
import Type.Player
import Type.Position

lane1 :: (Floating a) => [[a]]
lane1 = [[-1, -1000], [-1, 1000]]

player1 :: (Floating a) => Player a
player1 =
  let -- state and input costs
      costInfo =
        I.CostInfo3
          { I.nominalVelocity = 15,
            I.nominalHeading = pi / 2,
            I.proximity = 1,
            I.lane = lane1,
            I.laneBoundary = 2.5
          }

      -- state and input weights
      stateWeight =
        W.StateWeight3
          { W.nominalVelocity = 10,
            W.nominalHeading = 10050,
            W.proximity = 100,
            W.lane = 100,
            W.laneBoundary = 100
          }

      inputWeight =
        W.InputWeight3
          { W.angularVelocity = 10,
            W.acceleration = 10
          }

      -- indices
      stateIndex =
        StateIndex1
          { positionStateIndices = [0, 1],
            psiStateIndex = 2,
            velocityStateIndex = 3,
            allPositionStateIndices = [[0, 1], [4, 5], [8, 9]]
          }
      inputIndex = InputIndex1 {angularVelocityInputIndex = 0, accelerationInputIndex = 1}
   in Car
        { stateIndex = stateIndex,
          inputIndex = inputIndex,
          costInfo = costInfo,
          stateWeight = stateWeight,
          inputWeight = inputWeight,
          color = sRGB24read "#cd5c5c"
        }

player2 :: (Floating a) => Player a
player2 =
  let costInfo =
        I.CostInfo3
          { I.nominalVelocity = 10,
            I.nominalHeading = pi / 2,
            I.proximity = 1,
            I.lane = lane1,
            I.laneBoundary = 2.5
          }

      -- state and input weights
      stateWeight =
        W.StateWeight3
          { W.nominalVelocity = 1,
            W.nominalHeading = 150,
            W.proximity = 100,
            W.lane = 100,
            W.laneBoundary = 100
          }

      inputWeight =
        W.InputWeight3
          { W.angularVelocity = 10,
            W.acceleration = 10
          }

      -- indices
      stateIndex =
        StateIndex1
          { positionStateIndices = [4, 5],
            psiStateIndex = 6,
            velocityStateIndex = 7,
            allPositionStateIndices = [[0, 1], [4, 5], [8, 9]]
          }
      inputIndex =
        InputIndex1
          { angularVelocityInputIndex = 2,
            accelerationInputIndex = 3
          }
   in Car
        { stateIndex = stateIndex,
          inputIndex = inputIndex,
          costInfo = costInfo,
          stateWeight = stateWeight,
          inputWeight = inputWeight,
          color = sRGB24read "#40826D"
        }

player3 :: (Floating a) => Player a
player3 =
  let costInfo =
        I.CostInfo3
          { I.nominalVelocity = 10,
            I.nominalHeading = pi / 2,
            I.proximity = 1,
            I.lane = [[2.5, -1000.0], [2.5, 1000.0]],
            I.laneBoundary = 2.5
          }

      -- state and input weights
      stateWeight =
        W.StateWeight3
          { W.nominalVelocity = 1,
            W.nominalHeading = 150,
            W.proximity = 100,
            W.lane = 100,
            W.laneBoundary = 100
          }

      inputWeight = W.InputWeight3 {W.angularVelocity = 10, W.acceleration = 10}

      -- indices
      inputIndex =
        InputIndex1
          { angularVelocityInputIndex = 4,
            accelerationInputIndex = 5
          }
      stateIndex =
        StateIndex1
          { positionStateIndices = [8, 9],
            psiStateIndex = 10,
            velocityStateIndex = 11,
            allPositionStateIndices = [[0, 1], [4, 5], [8, 9]]
          }
   in Car
        { stateIndex = stateIndex,
          inputIndex = inputIndex,
          costInfo = costInfo,
          stateWeight = stateWeight,
          inputWeight = inputWeight,
          color = sRGB24read "#6a5acd"
        }
