module Type.Player where

import Type.Weight
import Type.CostInfo
import Type.Index

data Player1 a = Bus {
  field1 :: a,
  field2 :: a
}

instance Functor Player1 where
  fmap f (Bus field1 field2) = Bus (f field1) (f field2)

data Player a = Car { 
                  stateIndex :: StateIndex,
                  inputIndex :: InputIndex,
                  costInfo :: CostInfo a,
                  stateWeight :: StateWeight a,
                  inputWeight :: InputWeight a
                } 
                | 
                Bicycle { 
                  stateIndex :: StateIndex,
                  inputIndex :: InputIndex,
                  costInfo :: CostInfo a,
                  stateWeight :: StateWeight a,
                  inputWeight :: InputWeight a
                }
                deriving (Show, Eq)

instance Functor Player where
  fmap f (Car stateIdx inputIdx costInfo stateWeight inputWeight) =
    Car stateIdx inputIdx (fmap f costInfo) (fmap f stateWeight) (fmap f inputWeight)
  fmap f (Bicycle stateIdx inputIdx costInfo stateWeight inputWeight) =
    Bicycle stateIdx inputIdx (fmap f costInfo) (fmap f stateWeight) (fmap f inputWeight)
