{
module Lexer where

import Util

import Control.Monad.State
import qualified Data.Map as M
}

%wrapper "basic"

tokens :-
    $white+ ;
    "lam"   { \s -> TkLam     }
    "."     { \s -> TkDot     }
    "["     { \s -> TkLSq     }
    "]"     { \s -> TkRSq     }
    [a-z]+  { \s -> TkSName s }

{
convertNames :: [Token] -> State (Name, M.Map String Name) [Token]
convertNames = sequence . map (\tk -> case tk of
    TkSName s -> freshFor s >>= return . TkName
    _         -> return tk)

data Token
    = TkLam
    | TkDot
    | TkLSq
    | TkRSq
    | TkSName String
    | TkName Name
    deriving (Show, Eq, Ord)
}
