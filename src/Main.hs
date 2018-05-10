module Main where

import Util
import Lexer
import Parser
import Syntax
import Trans

import Data.List (intersperse)
import System.Environment (getArgs)
import Control.Monad.State
import qualified Data.Map as M

main :: IO ()
main = do
    args <- getArgs
    let tks = alexScanTokens $ concat $ intersperse " " args
    let (tks', (n, names)) = runState (convertNames tks) (Name 0, M.empty)
    let lam = parse tks'
    let (u, st) = runState fresh (n, swap names)
    let (pi, st') = runState (trans lam u) st
    putStrLn $ "[[ " ++ pp (snd st') lam ++ " ]]" ++ pp (snd st') u ++ " = " ++ pp (snd st') pi
    return ()
