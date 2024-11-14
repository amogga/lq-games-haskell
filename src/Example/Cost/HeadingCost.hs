module Example.Cost.HeadingCost where

import Type.Player
import qualified Type.CostInfo as I 
import Type.Index

nominalHeadingCost :: (Floating a) => Player a -> [a] -> a
nominalHeadingCost player states = (heading - nominalHeading) ** 2
  where
    heading = states !! psiStateIndex (stateIndex player)
    nominalHeading = I.nominalHeading $ costInfo player

