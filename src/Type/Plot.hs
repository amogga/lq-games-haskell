module Type.Plot where

data PlotExtension = PNGext | PDFext

extensionToString :: PlotExtension -> String
extensionToString PNGext = ".png"
extensionToString PDFext = ".pdf"