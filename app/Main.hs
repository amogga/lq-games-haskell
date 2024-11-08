module Main (main) where

main :: IO ()
main = do
    -- let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    -- let input = vector [0,0,0,0,0,0]
    let states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = [0,0,0,0,0,0]

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
