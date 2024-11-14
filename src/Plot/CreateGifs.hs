module Plot.CreateGifs where
import System.Process (callProcess)
import System.Directory ( removeFile, listDirectory, createDirectoryIfMissing )
import Control.Monad (forM_)
import Type.Basic
import Type.Player
import Plot.TrajectorySketch
import System.FilePath ((</>))

createAnimation :: FilePath -> Int -> FilePath -> IO ()
createAnimation inputPattern iterationCount outputPath = do
    -- Generate the list of file paths
    let inputFiles = [inputPattern ++ show n ++ ".png" | n <- [0..iterationCount-1]]
    let command = "magick"
    let args = ["-delay", "10"] ++ inputFiles ++ [outputPath]
    callProcess command args

-- Function to create a directory if it does not exist
ensureDirectoryExists :: FilePath -> IO ()
ensureDirectoryExists = createDirectoryIfMissing True

-- Function to delete all files in a specified directory
deleteAllFilesInDir :: FilePath -> IO ()
deleteAllFilesInDir dir = do
    files <- listDirectory dir      -- List all files in the directory
    forM_ files $ \file -> do      -- Iterate over each file
        let filePath = dir </> file -- Construct the full file path
        removeFile filePath         -- Remove the file

createAnimationWithIterations :: [Player Double] -> [[StateControlData]] -> IO ()
createAnimationWithIterations players iters = do
    ensureDirectoryExists "./plots/iterations"
    deleteAllFilesInDir "./plots/iterations"

    let iterationCount = length iters
    mapM_ (\it -> createPNGPlot players ("plot_iter" ++ show it) it (iters !! it)) [0..iterationCount-1]
    createAnimation "./plots/iterations/plot_iter" iterationCount "./plots/animation.gif"


createAnimationWithIteration :: [Player Double] -> [StateControlData] -> IO ()
createAnimationWithIteration players iter = do
    ensureDirectoryExists "./plots/simulation"
    deleteAllFilesInDir "./plots/simulation"

    let horizonCount = length iter
    mapM_ (\it -> createSimulationPNGPlot players ("plot_iter" ++ show it) (take (it+1) iter)) [0..horizonCount-1]
    createAnimation "./plots/iterations/plot_iter" horizonCount "./plots/animation.gif"
