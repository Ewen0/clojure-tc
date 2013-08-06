(ns clojure-tc-utils.clojure-tc-utils
  (:require [clojure.walk :refer [macroexpand-all prewalk]]))


(defn form-begins-with [form symb]
  (and (seq? form) (= symb (first form))))

(defn is-def-form [form]
  (->> (for [def-declaration ['def 'defn 'defmacro]]
         (form-begins-with form def-declaration))
       (reduce #(or %1 %2))))

(defn is-ns-form [form]
  (form-begins-with form 'ns))





(def target-ns nil)

(defn safe-read [r]
  (try (read r) (catch Exception e nil)))

(defn process-file [fct]
  (prn (-> (with-open [r (java.io.PushbackReader.
                          (clojure.java.io/reader "src/test_clj_file.clj"))]
             (loop [accumulator nil] 
               (if (.ready r) (recur (fct (safe-read r) accumulator))
                   accumulator)))
           macroexpand-all)))



(defn to-string [form accumulator]
  (str accumulator " " form))

(defn eval-ns-and-all-def [form-tree _]
  (prewalk #(cond (is-ns-form %) (do (eval %) 
                                     (binding [*ns* 'clojure-tc-utils.clojure-tc-utils] 
                                       (alter-var-root #'target-ns (fn [_] (-> (second %) quote)))) %)
                  (is-def-form %) (do (eval %) %)
                  :t %) 
           form-tree))

(defn macroexpand-and-ns-qualify [form-tree accumulator]
  (binding [*ns* (create-ns 'target-ns)] 
    (->> (macroexpand-all form-tree) 
        (str accumulator " " ))))

(process-file to-string)
(process-file eval-ns-and-all-def)
(in-ns 'clojure-tc-utils.clojure-tc-utils)
(process-file macroexpand-and-ns-qualify)
