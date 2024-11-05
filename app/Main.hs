module Main (main) where

main :: IO ()
main = do
    -- let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    -- let input = vector [0,0,0,0,0,0]
    let states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = [0,0,0,0,0,0]

    
    -- let prox = proximityCost [[3,0.4],[5.5,2.3],[4.4,3]] player
    -- let pos = Position (2.2,4)
    -- let pos2 = Position (4.4,5)
    -- createPlotViaGloss
    -- createPlot
    -- let bn2 = norm_2 ((vector[1,2.3,4]) - (vector [2.2,3.4,3]))
    -- let bninf = norm_Inf ((vector[1,2.3,4]) - (vector [2.2,3.4,3]))
    -- print bn2
    -- print bninf

    print "sd"


-- Generic Gradient and Hessians (taking `totalcost` as argument)
-- 'stateHessianT :: (Traversable f, Floating a) => StateHessianFunctionType f a -> Player a -> ActiveApplyType f a -> InactiveApplyType a -> f (f a)
-- stateHessianT totCost player states input = hessian totalCost' states
--   where
--     totalCost' x = totCost (fmap auto player) x (map auto input)

-- inputHessianT :: (Traversable f, Floating a) => InputHessianFunctionType f a -> Player a -> InactiveApplyType a -> ActiveApplyType f a -> f (f a)
-- inputHessianT totCost player states = hessian totalCost'
--   where
--     totalCost' u = totCost (fmap auto player) (map auto states) u'

-- stateGradientT :: (Traversable f, Floating a) => StateGradientFunctionType f a -> Player a -> ActiveApplyType f a -> InactiveApplyType a -> ActiveApplyType f a
-- stateGradientT totCost player states input = grad totalCost' states
--   where
--     totalCost' x = totCost (fmap auto player) x (map auto input)