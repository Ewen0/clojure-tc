(ns test-project.test-clj-file
  (:require [test-project.test-server.handler :as handler-test]
            [ring.util.serve :refer [serve-headless stop-server]]
            [cljs.repl.browser]))

(serve-headless handler-test/app)

(stop-server)

;Starts the browser connected REPL
(cemerick.piggieback/cljs-repl
  :repl-env (doto (cljs.repl.browser/repl-env :port 9000)
              cljs.repl/-setup))

(define er "edfdf" [a]
  (str a))

(fn tt [y] r)
