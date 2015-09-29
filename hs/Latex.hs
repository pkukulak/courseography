{-# LANGUAGE OverloadedStrings #-}

module Latex where

import Text.LaTeX
import Text.LaTeX.Packages.Graphicx
import ImageConversion

main = do
    tex <- execLaTeXT example
    renderFile "example.tex" tex
    compileTexToPDF "example.tex" "example.pdf"

{- Here are some constants that we need to
   feed in as options to the image processor. -}

width = IGWidth $ Pt 300.0

height = IGHeight $ Pt 300.0

aspectRatio = KeepAspectRatio True

scale = IGScale 1.0

angle = IGAngle 0

noTrim = IGTrim (Pt 0) (Pt 0) (Pt 0) (Pt 0)

noClip = IGClip False

startPageOne = IGPage 1

example = do
    preamble
    document body

preamble = do
    documentclass [] article -- Document type declaration.
    usepackage [] graphicx -- Package to include images.

body :: Monad m => LaTeXT_ m
body = do
    includegraphics [width, height,         -- These are options for
                     aspectRatio, scale,    -- image processing.
                     angle, noTrim,         -- Pretty self-explanatory.
                     noClip, startPageOne]
                    "isk.png"
    "Text is inserted just as you would expect."
    "\n"
    "Note how ugly it looks. This is fine, because "
    "we don't be writing much text."
    
