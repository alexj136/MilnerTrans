module Util where

import Control.Monad.State
import qualified Data.Map as M

newtype Name = Name Int deriving (Show, Eq, Ord)

next :: Name -> Name
next (Name n) = Name (n + 1)

fresh :: State (Name, M.Map Name String) Name
fresh = do
    (n@(Name i), names) <- get
    let ss = [ c : s | s <- "" : ss, c <- ['a'..'z'] ]
    put (next n, M.insert n (ss !! i) names)
    return n

freshFor :: String -> State (Name, M.Map String Name) Name
freshFor s = do
    (n, names) <- get
    case M.lookup s names of
        Nothing -> do { put (next n, M.insert s n names) ; return n }
        Just n' -> return n'

class PrettyPrint a where
    pp :: M.Map Name String -> a -> String

instance PrettyPrint Name where
    pp names n = M.findWithDefault "?" n names

swap :: Ord a => Ord b => M.Map a b -> M.Map b a
swap = M.fromList . map (\(a, b) -> (b, a)) . M.toList
