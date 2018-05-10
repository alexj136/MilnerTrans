module Trans where

import Util
import Syntax

import Control.Monad.State
import qualified Data.Map as M

trans :: LamTerm -> Name -> State (Name, M.Map Name String) PiTerm
trans lt u = case lt of
    App m n -> do
        [a, b, c, x, w] <- sequence $ replicate 5 fresh
        mw <- trans m w
        nx <- trans n x
        return $ New w $ Par mw $ In w a $ In w b $ New x $ Par nx $
            In x c $ Out a c $ Out b u O
    Lam x m -> do
        [a, b, x, w] <- sequence $ replicate 4 fresh
        mw <- trans m w
        return $ New a $ Out u a $ New b $ Out u b $ Rep $ In a x $ In b w mw
    Var x -> return $ Out u x O
