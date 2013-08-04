(defproject test-project "0.1.0-SNAPSHOT"
  :description ""
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :test-paths ["test" "test-server"]
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.4.0"]
                 [org.clojure/clojurescript "0.0-1586"]
                 [com.cemerick/piggieback "0.0.4"]
                 [compojure "1.1.3"]
                 [ring-serve "0.1.2"]
                 [ring/ring-devel "1.1.6"]
                 [ring/ring-core "1.1.6"]
                 [com.ewen.utils-cljs "1.0.0-RELEASE"]]
  :dev-dependencies [[lein-cljsbuild "0.3.0"]]
  :plugins [[lein-cljsbuild "0.3.0"]]
  :cljsbuild {:builds [{:id "dev"
                        :source-paths ["src-cljs" "browser-repl"]
                        :externs ["flapjax-2.1.js"]
                        :compiler {:output-to "test-resources/js/cljs.js"
                                   :optimizations :simple
                                   :pretty-print true}}]}
  :repl-options {:nrepl-middleware [cemerick.piggieback/wrap-cljs-repl]})