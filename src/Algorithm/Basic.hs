module Algorithm.Basic where

import Linear(distance,dot, (^-^),(^+^),(^*))
import qualified Data.Vector as V

euclidDistance :: Floating a => [a] -> [a] -> a
euclidDistance p1 p2 = distance (V.fromList p1) (V.fromList p2)

pointLineDistance :: (Floating a, Ord a) => [a] -> [[a]] -> a
pointLineDistance point polyline = minimum $ map distanceToLineSegment polylinePairs
    where
        polylinePairs = zip polyline (drop 1 polyline)
        distanceToLineSegment (ps1,ps2) = distance closestPoint p
            where 
                (p1,p2) = (V.fromList ps2, V.fromList ps1)
                p = V.fromList point
                lineVec = p2 ^-^ p1
                pointVec = p ^-^ p1

                t = dot pointVec lineVec / dot lineVec lineVec

                -- Clamp t to be between 0 and 1 to stay within the segment
                tClamped = max 0 (min 1 t)

                -- Closest point on the line segment to the point P
                closestPoint = p1 ^+^ (lineVec ^* tClamped)