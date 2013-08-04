(with-open [r (java.io.PushbackReader.
                 (clojure.java.io/reader "test_clj_file.clj"))]
    (loop [file-str ""] 
      (if (.ready r) (recur (str file-str " " (read r)))
          file-str)))