\*(defmacro defn-macro
[defn F COMMENTS [PARAMS] BODY] -> [define F PARAMS -> BODY]])*\

(defmacro list-macro
  [( BODY )] -> [[ BODY ]])

(datatype symbol-type
  if (symbol? X)
  ____________
  (quote X) : symbol;)

(datatype val-type
  let Val (value S)
  Val : number;
  ___________
  S : number;)

(datatype val-type
  ___________
  b : number;)

(define quote
  {symbol --> symbol}
  X -> X)

(datatype quote-type
  _______________
  quote : (symbol --> symbol);)

(set quote (lambda X -> X))
