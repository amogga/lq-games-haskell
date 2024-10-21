
module Examples.E1.Costs (quadratizeCosts, totalCostsForPlayers) where

-- import Data.Matrix
import Numeric.AD
import Numeric.LinearAlgebra
import Examples.E1.Helpers
import Data.List.Split (chunksOf)

quadratizeCosts :: [R] -> [R] -> ([Matrix R], [Vector R],[[Matrix R]])
quadratizeCosts x u = unzip3 $ map (quadratizeCostsForPlayer x u) [1..3]

quadratizeCostsForPlayer :: [R] -> [R] -> Int -> (Matrix R, Vector R, [Matrix R])
quadratizeCostsForPlayer x u player = (qs,ls,rs)
  where
    (qs,rs) = stateInputHessian x u player
    ls = stateGradient x u player


stateInputHessian :: [R] -> [R] -> Int -> (Matrix R, [Matrix R])
stateInputHessian states input player =  (q,rs)
  where
    rs = map (\(x,y) -> ar ?? (Range x 1 y, Range x 1 y)) [(0,1),(2,3),(4,5)]
    ar = stInHess ?? (Drop 12, Drop 12)
    q = stInHess ?? (Take 12, Take 12)
    stInHess = matrix (stlen + inlen) (concat (hessian totalCost' (states ++ input)))
    (stlen, inlen) = (length states,length input)

    totalCost' statesinput = uncurry totalCost xu player
      where xu = splitAt stlen statesinput

stateHessian :: [R] -> [R] -> Int -> Matrix R
stateHessian states input player =  fst (stateInputHessian states input player)

inputHessian :: [R] -> [R] -> Int -> [Matrix R]
inputHessian states input player = snd (stateInputHessian states input player)

stateGradient :: [R] -> [R] -> Int -> Vector R
stateGradient states input player = vector (take stlen (grad totalCost' (states ++ input)))
  where
    stlen = length states
    totalCost' statesinput = uncurry totalCost xu player
      where xu = splitAt stlen statesinput

totalCostsForPlayers :: (Floating a, Ord a) => [a] -> [a] -> [a]
totalCostsForPlayers states input = map (totalCost states input) [1..3]


totalCost :: (Floating a, Ord a) => [a] -> [a] -> Int -> a
totalCost states input player = case player of
  1 -> let weightsx = [1,50,50,100,100,100]
           weightsu = [25,1]
           weightedCarCosts = sum $ zipWith (*) weightsx carCosts
           weightedInputCosts = sum $ zipWith (*) weightsu inputCosts
        in weightedCarCosts + weightedInputCosts

  2 -> let weightsx = [1,50,50,100,100,100] 
           weightsu = [25,1]
           weightedCarCosts = sum $ zipWith (*) weightsx carCosts
           weightedInputCosts = sum $ zipWith (*) weightsu inputCosts
        in weightedCarCosts + weightedInputCosts

  3 -> let weightsx = [1,100,100,1]
           weightsu = [1,1]
           weightedBicycleCosts = sum $ zipWith (*) weightsx bikeCosts
           weightedInputCosts = sum $ zipWith (*) weightsu inputCosts 
        in weightedBicycleCosts + weightedInputCosts

  _ -> error "No more players! Choose from the players set {1,2,3}"
  where
    carCosts = [goalCost states player, polylineCost states player, polylineBoundaryCost states player, maxVelocityCost states maxv player, minVelocityCost states minv player, proximityCost states player]
    bikeCosts = (\(x:_:_:xs) -> x:xs) carCosts
    inputCosts = map (**2) playerInput
    playerInput = chunksOf 2 input !! (player - 1)
    (minv,maxv) = (0,10)

goalCost :: Floating a => [a] -> Int -> a
goalCost states player = case player of
  1 -> let goal = [6.0,35.0] in euclidDistance position goal ** 2
  2 -> let goal = [12,12] in euclidDistance position goal ** 2
  3 -> let goal = [15,21] in euclidDistance position goal ** 2
  _ -> error "No more players! Choose from player set {1,2,3}"

  where position = map (take 2) (chunksOf 4 states) !! (player - 1)

polylineCost :: (Floating a, Ord a) => [a] -> Int -> a
polylineCost states player = case player of
  1 -> let polyline = [[6.0,-100.0],[6.0,100.0]] in pointLineDistance position polyline ** 2
  2 -> let polyline = [[2.0,100.0],[2.0,18.0],[2.5,15.0],[3.0,14.0],[5.0,12.5],[8.0,12.0],[100.0,12.0]] in pointLineDistance position polyline ** 2
  _ -> error "No more players! Choose from player set {1,2,3}"

  where position = map (take 2) (chunksOf 4 states) !! (player - 1)

polylineBoundaryCost :: (Floating a, Ord a) => [a] -> Int -> a
polylineBoundaryCost states player = if plineCost > threshold then plineCost else 0
  where plineCost = polylineCost states player
        threshold = 1.0

maxVelocityCost :: (Floating a, Ord a) => [a] -> a -> Int -> a
maxVelocityCost states threshold player = max (velocity - threshold) 0 ** 2
  where
    velocity = last $ chunksOf 4 states !! (player - 1)

minVelocityCost :: (Floating a, Ord a) => [a] -> a -> Int -> a
minVelocityCost states threshold player = min (velocity - threshold) 0 ** 2
  where
    velocity = last $ chunksOf 4 states !! (player-1)

proximityCost :: (Floating a, Ord a) => [a] -> Int -> a
proximityCost states player = sum $ map (**2) costs
  where
      positions = map (take 2) (chunksOf 4 states) -- extract 2D positions
      pairs = [(p1, p2) | p1 <- positions, p2 <- positions, p1 /= p2] -- generate pairs
      costs = map (\(p1, p2) -> min (euclidDistance p1 p2 - proximity) 0) pairs
      proximity = if player == 1 || player == 2
                  then 2 else 1
