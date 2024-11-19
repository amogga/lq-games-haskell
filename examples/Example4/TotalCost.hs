{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module TotalCost where

import Example.Cost.GoalCost
import Example.Cost.LaneCost
import Example.Cost.VelocityCost
import Example.Cost.ProximityCost
import Type.Player
import qualified Type.Weight as W
import Type.Index
import Example.Cost.HeadingCost


totalCost :: (Floating a, Ord a) => Player a -> [a] -> [a] -> a
totalCost player@(Car _ inputIdx _ stateWgt inputWght _) states input =
  let 
      goalCostVal = goalCostFromStates player states
      proximityVal = proximityCost player states
      maxVelCostVal = maximumVelocityCost player states
      minVelCostVal = minimumVelocityCost player states
      nominalVelocityVal = nominalVelocityCost player states
      nominalHeadingVal = nominalHeadingCost player states
  in
   let laneCostVal =  laneCost player states
       laneBoundaryCostVal = laneBoundaryCost player states
       angularVelocityCostVal = input !! angularVelocityInputIndex inputIdx
       accelerationCostVal = input !! accelerationInputIndex inputIdx
      in
      -- progress
      -- W.goal stateWgt * goalCostVal +

      W.nominalVelocity stateWgt * nominalVelocityVal +
      -- W.nominalHeading stateWgt * nominalHeadingVal +

      -- stay in lane
      W.lane stateWgt * laneCostVal + W.lane stateWgt * laneBoundaryCostVal +

      -- adjust speed and keep within bounds: nominal, maximum and minimum speed
      W.maxVelocity stateWgt * maxVelCostVal + 
      W.minVelocity stateWgt * minVelCostVal +

      -- avoid collisions with other road users
      W.proximity stateWgt * proximityVal +

      -- penalize inputs: angular velocity and acceleration
      W.angularVelocity inputWght * angularVelocityCostVal ** 2 + 
      W.acceleration inputWght * accelerationCostVal ** 2
