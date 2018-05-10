{
module Parser where

import Util
import Lexer
import Syntax
}

%name parseM M

%tokentype { Token }
%error { parseError }


%token
    Lam  { TkLam     }
    Dot  { TkDot     }
    LSq  { TkLSq     }
    RSq  { TkRSq     }
    Name { TkName $$ }
%%

M :: { [LamTerm] }
M : N M { $1 : $2 } | N { [$1] }

N :: { LamTerm }
N : Lam Name Dot M { Lam $2 (fromList $4) }
  | Name { Var $1 }
  | LSq M RSq { fromList $2 }

{
parse :: [Token] -> LamTerm
parse = fromList . parseM

fromList :: [LamTerm] -> LamTerm
fromList []  = error "empty list"
fromList [t] = t
fromList ts  = App (fromList (init ts)) (last ts)

parseError :: [Token] -> a
parseError [] = error "Reached end of input while parsing"
parseError ts = error $ "Parse error: " ++ show ts
}
