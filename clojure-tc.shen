\* TEST *\

(set yyy (/.* [a b | c] -> 2))

((value yyy) [a])

(datatype yyy-type
  __________
  (value yyy) : ((list symbol) --> number);)

a
'[quote a]













\*********\
\* TESTS *\
\*********\

(define two-first
  [X Y | Z] -> [X Y])

\*

(map (/. X (shen.typecheck X (gensym (protect A)))) (two-first (convert-quotes (read-file "/home/ewen/shen/clojure-tc/clojure-tc.shen"))))

(shen.typecheck (head (convert-quotes (read-file "/home/ewen/shen/clojure-tc/clojure-tc.shen"))) (gensym (protect A)))

*\















\*********************\
\* LOAD DEPENDENCIES *\
\*********************\

(cd "/home/ewen/shen/clojure-tc/")
(load "list.shen")

















\**********\
\* Quotes *\
\**********\

(defmacro neq-macro
  [!= | X] -> [not [= | X]])

\*
Return true when given an "quoted" atom. False otherwise.

(quoted? 's) -> true
(quoted? s) -> false
(quoted? ') -> false
(quoted? '[cons A []]) -> false

trap-error is there because str only works on atoms. Thus when given something that is not an atom,
we trap the error and return false.
*\
(define quoted?
  X -> (trap-error (and (!= "'" (str X)) 
			(= "'" (hdstr (str X)))) 
		   (/. E false)))


\* 
 * Unquote a quoted atom.
 *  
 * (unquote 's) -> s 
 *\

(define unquote
  X -> (intern (tlstr (str X))) where (quoted? X))

\* Don't pay attention, only expermiments with shen-yacc :)

(defcc <quoted>
  [X] <quoted> := [X | <quoted>] 
  X <quoted> := [[quote (unquote X)] | <quoted>] where (quoted? X);
  X <quoted>;
  <e> := [];)

(compile <quoted> ['r ['r]]) *\

(define handle-subtries
  ' [[cons | X] | Y] -> [[quote [cons | X]] | Y]
  ' [[X] | Y] -> [[list [X]] | Y]
  ' [X | Y] -> [[quote X] | Y]
  X Y -> [X | Y])


(define convert-quotes
  [] -> []
  [X | Y] -> (handle-subtries (convert-quotes X) (convert-quotes Y))
  X -> [quote (unquote X)] where (quoted? X)
  X -> ' where (= ' X)
  X -> X)


\* (convert-quotes [['r] u [p 'y] t ' [a] 't ' [cons e ['y]]]) *\






















\*************************\
\* Shen lists to vectors *\
\*************************\

(defmacro vec-macro
  [] -> <>
  [cons X Y] -> (@v X (vec-macro Y)))















\**************\
\* CLOJURE FN *\
\**************\


\* Example *\
\* (macroexpand [clojure.core/fn [A] "e"]) -> [lambda A "e"]  *\

\* Pattern matching for anonymous functions *\
(defmacro l-macro
  [ /.* | PatternsActions] -> (let TmpName (intern (str (gensym tmpname)))
                                   DBody (tail (tail (compile
						      shen.<define> 
						      [ TmpName | PatternsActions])))
				[/. | (append (head DBody) (tail DBody))]))


(datatype hd-type
  ______________
  hd : ((list A) --> A);)

(datatype tl-type
  ______________
  tl : ((list A) --> (list A));)

(defmacro cond-macro
  [cond [CaseP CaseR] | []]
  -> [if CaseP CaseR [simple-error "True condition not found"]]
  [cond [CaseP CaseR] | OtherCases]
  -> [if CaseP CaseR (cons cond OtherCases)])

(datatype f_error-type
  _______________
  shen.f_error : (symbol --> A);)



\* (macroexpand [/.* a -> 2]) *\





















\* *\
\* 
(define normalize-fn-param
  [cons X []] -> [X]
  X -> X)

(defmacro fn-macro
  [clojure.core/fn Params Body] -> [/. | (append (normalize-fn-param Params) [Body])])

(defmacro fn-macro
  [clojure.core/fn Params Body] -> (normalize-fn-param Params))
*\









\*(datatype symbol-type
  if (symbol? X)
  ____________
  (quote X) : symbol;)*\




\*(datatype quote-type
  _______________
  quote : (A --> A);)*\






