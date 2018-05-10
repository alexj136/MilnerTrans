# MilnerTrans

`MilnerTrans` is an implementation of a translation from λ-calculus to
π-calculus. The translation is in the style of Robin Milner's translations from
λ to π, as presented in [1]. The implemented translation is in a monadic
call-by-value style.

### Installation

Assuming you have [Stack](https://www.haskellstack.org/) installed, clone this
repository, `cd` into it and run `stack install`.

### Usage

Once installed, you can invoke `MilnerTrans` with the command:

    $ MilnerTrans EXP

Where `EXP` is a λ expression. The syntax of λ expressions is as follows:

    M ::=   lam x . M        Abstraction
       |    x                Variables [a-z]+
       |    M M              Application
       |    [M]              Parenthesised expression

This syntax is chosen because it doesn't interfere with the `bash` shell.
Therefore if you use `bash`, you don't need to put your input in quotes, you can
just type it out on the command line, e.g.:

    $ MilnerTrans [lam x . x] y

without any errors.

A π calculus translation of the given input will be printed to the command-line
assuming the given term parsed correctly. The π notation used is standard.

[1]: Functions as Processes - Robin Milner. Journal of Mathematical Structures
in Computer Science, 1992.
