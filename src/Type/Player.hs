module Type.Player(Player(..)) where

import Type.Weight
import Type.CostInfo
import Type.Index
import Diagrams.Prelude (Colour)

data Player a = Car { 
                  stateIndex :: StateIndex,
                  inputIndex :: InputIndex,
                  costInfo :: CostInfo a,
                  stateWeight :: StateWeight a,
                  inputWeight :: InputWeight a,
                  color :: Colour Double
                } 
                | 
                Bicycle { 
                  stateIndex :: StateIndex,
                  inputIndex :: InputIndex,
                  costInfo :: CostInfo a,
                  stateWeight :: StateWeight a,
                  inputWeight :: InputWeight a,
                  color :: Colour Double
                }

instance Functor Player where
  fmap f (Car stateIdx inputIdx costInf stateWght inputWght col) =
    Car stateIdx inputIdx (fmap f costInf) (fmap f stateWght) (fmap f inputWght) col
  fmap f (Bicycle stateIdx inputIdx costInf stateWght inputWght col) =
    Bicycle stateIdx inputIdx (fmap f costInf) (fmap f stateWght) (fmap f inputWght) col
