{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Solver.LQGame where

import Prelude hiding ((<>))
import Numeric.LinearAlgebra
import Types.Basic
import Control.Monad.State
import Control.Monad (zipWithM)

data LQGameState = LQGameState { z::[Matrix R], zeta::[Vector R] } deriving (Show)
data PAndAlpha = PAndAlpha { pMatrix :: Matrix R, alphaMatrix :: Matrix R} deriving (Show)

lqGameSolver :: [LinearMultiSystemDynamics] -> [LinearMultiSystemCosts] -> [PAndAlpha]
lqGameSolver dynlist costslist = reverse $ evalState (zipWithM computeStep dynlist costslist) initialState
    where
        initialState = initialStateFromCosts $ head costslist

initialStateFromCosts :: LinearMultiSystemCosts -> LQGameState
initialStateFromCosts (LinearMultiSystemCosts qs ls _) = LQGameState qs ls

computeStep :: LinearMultiSystemDynamics -> LinearMultiSystemCosts -> State LQGameState PAndAlpha
computeStep dynamics costs = do
    gameState <- get
    let pAndAlpha = computePAndAlpha dynamics costs gameState
    put (updateZsZetas dynamics costs gameState pAndAlpha)
    return pAndAlpha

computeS :: LinearMultiSystemDynamics -> LinearMultiSystemCosts -> LQGameState -> Matrix R
computeS dynamics costs (LQGameState zs _) = fromBlocks [[computeBlock i j | j <- [0..nplys-1]] | i <- [0..nplys-1]]
    where
        computeBlock i j
          | i == j    = (rs !! i !! j) + tr (bs !! i) <> (zs !! i) <> (bs !! i)
          | otherwise = tr (bs !! i) <> (zs !! i) <> (bs !! j)
        nplys = length bs
        LinearDiscreteMultiSystemDynamics _ bs _ = dynamics
        LinearMultiSystemCosts _ _ rs = costs

computePAndAlpha :: LinearMultiSystemDynamics -> LinearMultiSystemCosts -> LQGameState -> PAndAlpha
computePAndAlpha dynamics costs gameState = PAndAlpha p alpha
    where
        p = computeP dynamics gameState s
        alpha = computeAlpha dynamics gameState s
        s = computeS dynamics costs gameState


computeP :: LinearMultiSystemDynamics -> LQGameState -> Matrix R -> Matrix R
computeP dynamics gameState s = p
    where
        p = case linearSolve s yp of
            Just x -> x
            Nothing -> error "No solution found for the system"
        yp = fromBlocks [[tr (bs !! i) <> zs !! i <> a] | i <- [0..nplys-1]]
        nplys = length bs
        LinearDiscreteMultiSystemDynamics a bs _ = dynamics
        LQGameState zs _ = gameState

computeAlpha :: LinearMultiSystemDynamics -> LQGameState -> Matrix R -> Matrix R
computeAlpha dynamics gameState s = alpha
    where
        alpha = case linearSolve s yalpha of
            Just x -> x
            Nothing -> error "No solution found for the system"
        yalpha = fromBlocks [[tr (bs !! i) <> reshape 1 (zts !! i)] | i <- [0..nplys-1]]
        nplys = length bs
        LinearDiscreteMultiSystemDynamics _ bs _ = dynamics
        LQGameState _ zts = gameState

computeF :: LinearMultiSystemDynamics -> PAndAlpha -> Matrix R
computeF (LinearDiscreteMultiSystemDynamics a bs _) (PAndAlpha p _) = a - (fromBlocks [bs] <> p)

computeBeta :: LinearMultiSystemDynamics -> PAndAlpha -> Matrix R
computeBeta (LinearDiscreteMultiSystemDynamics _ bs _) (PAndAlpha _ alpha) = -(fromBlocks [bs] <> alpha)

updateZsZetas :: LinearMultiSystemDynamics -> LinearMultiSystemCosts -> LQGameState -> PAndAlpha -> LQGameState
updateZsZetas dynamics costs (LQGameState zs zts) pAndAlpha = LQGameState zsp ztsp
    where
        -- zsp = [tr f <> (zs !! i) <> f + (qs !! i) | i <- [0..nplys-1]]
        -- ztsp = [flatten $ tr f <> (reshape 1 (zts !! i) + (zs !! i) <> beta) + reshape 1 (ls !! i) | i <- [0..nplys - 1]]

        zsp = [tr f <> (zs !! i) <> f + (qs !! i) + sumZJ i | i <- [0..nplys-1]]

        ztsp = [flatten $ tr f <> (reshape 1 (zts !! i) + (zs !! i) <> beta) + reshape 1 (ls !! i) + sumZetaJ i | i <- [0..nplys - 1]]


        sumZJ i = sum [tr (ps i j) <> rs !! i !! j <> ps i j | j <- [0..nplys -1]]

        sumZetaJ i = sum [tr (ps i j) <> rs !! i !! j <> alphas i j | j <- [0..nplys -1]]

        -- ri k = matrix (rows $ rpm k) [if i == j + (1*k) then 1 else 0 | i <- [0..5], j <- [0..1]]

        f = computeF dynamics pAndAlpha
        beta = computeBeta dynamics pAndAlpha

        ps i j = let startRow = if i > 0 then sum [rows (rs !! k !! j) | k <- [0..i-1]] else 0
                     endRow = startRow + rows (rs !! i !! j) - 1
                 in p ?? ( Range startRow 1 endRow, All)

        alphas i j = let startRow = if i > 0 then sum [cols (rs !! k !! j) | k <- [0..i-1]] else 0
                         endRow = startRow + cols (rs !! i !! j) - 1
                     in alpha ?? ( Range startRow 1 endRow, All)

        nplys = length bs

        LinearDiscreteMultiSystemDynamics _ bs _ = dynamics
        LinearMultiSystemCosts qs ls rs = costs
        PAndAlpha p alpha = pAndAlpha