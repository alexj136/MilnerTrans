module Syntax where

import Util

data LamTerm
    = App LamTerm LamTerm
    | Lam Name LamTerm
    | Var Name
    deriving (Show, Eq, Ord)

instance PrettyPrint LamTerm where
    pp names lt = case lt of
        Lam x t                     -> "lam " ++ pp names x ++ "." ++ pp names t
        App t@(Lam _ _) u@(App _ _) ->
            "[" ++ pp names t ++ "] [" ++ pp names u ++ "]"
        App t           u@(App _ _) -> pp names t ++  " [" ++ pp names u ++ "]"
        App t@(Lam _ _) u           -> "[" ++ pp names t ++ "] "  ++ pp names u
        App t           u           -> pp names t ++  " "  ++ pp names u
        Var n                       -> pp names n

data PiTerm
    = Par PiTerm PiTerm
    | Rep PiTerm
    | New Name PiTerm
    | Out Name Name PiTerm
    | In Name Name PiTerm
    | O
    deriving (Show, Eq, Ord)

instance PrettyPrint PiTerm where
    pp names pt = case pt of
        Par p q   -> "(" ++ pp names p ++ " | " ++ pp names q ++ ")"
        Rep p     -> "!" ++ pp names p
        New x p   -> "(ν" ++ pp names x ++ ")" ++ pp names p
        Out x y O -> putBar (pp names x) ++ pp names y
        In x y O  -> pp names x ++ "(" ++ pp names y ++ ")"
        Out x y p -> pp names (Out x y O) ++ "." ++ pp names p
        In x y p  -> pp names (In x y O) ++ "." ++ pp names p
        O         -> "0"
        where
        putBar :: String -> String
        putBar s = case s of { "" -> "" ; c:cs -> "̅" ++ [c] ++ putBar cs }
