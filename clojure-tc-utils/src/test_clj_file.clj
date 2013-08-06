(ns test-clj-file
  (:require [ring.util.serve :refer [serve-headless stop-server]]
            [cljs.repl.browser]
            [cemerick.piggieback]))

(stop-server)

;Starts the browser connected REPL
(cemerick.piggieback/cljs-repl
  :repl-env (doto (cljs.repl.browser/repl-env :port 9000)
              cljs.repl/-setup))

(def er "edfdf" (fn [a]
                  (str a)))

(defn tt [y] y)

(defmacro yy [y] tt)

(yy 3)
