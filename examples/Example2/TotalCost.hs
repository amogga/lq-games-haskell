{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module TotalCost (totalCost) where

import Example.Cost.HeadingCost
import Example.Cost.LaneCost
import Example.Cost.ProximityCost
import Example.Cost.VelocityCost
import Type.Index
import Type.Player
import qualified Type.Weight as W

totalCost :: (Floating a, Ord a) => Player a -> [a] -> [a] -> a
totalCost player@(Car _ inputIndx _ stateWght inputWght _) states input =
  let nominalVelocityVal = nominalVelocityCost player states
      nominalHeadingVal = nominalHeadingCost player states
      laneCostVal = laneCost player states
      laneBoundaryCostVal = laneBoundaryCost player states
      proximityCostVal = proximityCost player states
      angularVelocityCostVal = input !! angularVelocityInputIndex inputIndx
      accelerationCostVal = input !! accelerationInputIndex inputIndx
   in -- nominal velocity and heading
        W.nominalVelocity stateWght * nominalVelocityVal
        + W.nominalHeading stateWght * nominalHeadingVal
        -- stay in lane
        + W.lane stateWght * laneCostVal
        + W.laneBoundary stateWght * laneBoundaryCostVal
        -- avoid collisions with other road users
        + W.proximity stateWght * proximityCostVal
        -- penalize inputs: angular velocity and acceleration
        + W.angularVelocity inputWght * angularVelocityCostVal ** 2
        + W.acceleration inputWght * accelerationCostVal ** 2
