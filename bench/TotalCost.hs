module TotalCost where

import Example.Cost.GoalCost
import Example.Cost.LaneCost
import Example.Cost.VelocityCost
import Example.Cost.ProximityCost
import Type.Player
import qualified Type.Weight as W
import Type.Index


totalCost :: (Floating a, Ord a) => Player a -> [a] -> [a] -> a
totalCost player states input =
  let 
      goalCostVal = goalCostFromStates player states
      proximityVal = proximityCost player states
      maxVelCostVal = maximumVelocityCost player states
      minVelCostVal = minimumVelocityCost player states
  in

  case player of
    (Car stateIdx inputIdx _ stateWeightCar inputWeightCar _) -> 

                                           let laneCostVal =  laneCost player states
                                               laneBoundaryCostVal = laneBoundaryCost player states
                                               angularVelocityCostVal = input !! angularVelocityInputIndex inputIdx
                                               accelerationCostVal = input !! accelerationInputIndex inputIdx
                                              in
                                              -- progress
                                              W.goal stateWeightCar * goalCostVal +

                                              -- stay in lane
                                              W.lane stateWeightCar * laneCostVal + W.lane stateWeightCar * laneBoundaryCostVal +

                                              -- adjust speed and keep within bounds: nominal, maximum and minimum speed
                                              W.maxVelocity stateWeightCar * maxVelCostVal + 
                                              W.minVelocity stateWeightCar * minVelCostVal +

                                              -- avoid collisions with other road users
                                              W.proximity stateWeightCar * proximityVal +

                                              -- penalize inputs: angular velocity and acceleration
                                              W.angularVelocity inputWeightCar * angularVelocityCostVal ** 2 + 
                                              W.acceleration inputWeightCar * accelerationCostVal ** 2

    (Bicycle stateIdx inputIdx _ stateWeightBicycle inputWeightBicycle _) -> 
                                            
                                            let steeringAngleCostVal = input !! steeringAngleInputIndex inputIdx 
                                                accelerationCostVal = input !! accelerationInputIndex inputIdx
                                               
                                               in

                                               -- progress
                                                W.goal stateWeightBicycle * goalCostVal +

                                                -- adjust speed and keep within bounds: nominal, maximum and minimum speed
                                                W.maxVelocity stateWeightBicycle * maxVelCostVal + 
                                                W.minVelocity stateWeightBicycle * minVelCostVal +
                                                
                                                -- avoid collisions with other road users
                                                W.proximity stateWeightBicycle * proximityVal + 

                                                -- penalize inputs: steering angle and acceleration
                                                W.steeringAngle inputWeightBicycle * steeringAngleCostVal ** 2 + 
                                                W.acceleration inputWeightBicycle * accelerationCostVal ** 2

