(ns pembas.tests.unit.netlogo
  (:require
   [clojure.string :as string]
   [clojure.test :refer :all]
   [pembas.netlogo :as netlogo]))

(deftest arg->str
  (is (= "\"a\""
         (netlogo/arg->str "a")))
  (is (= "[\"a\" \"b\" \"c\"]"
         (netlogo/arg->str ["a" "b" "c"])))
  (is (= "1"
         (netlogo/arg->str 1)))
  (is (= "[1 2 3]"
         (netlogo/arg->str [1 2 3])))
  (is (= "[[1 2 3]]"
         (netlogo/arg->str [[1 2 3]]))))

(deftest args->str
  (is (= "myfunc 1 2 3"
         (netlogo/args->str "myfunc" [1 2 3])))
  (is (= "myfunc [1 2 3]"
         (netlogo/args->str "myfunc" [[1 2 3]]))))

(deftest md->html
  (let [result (netlogo/md->html
                "# Heading 1\n\nstuff\n\n## Heading 2\n\nthings"
                12)]
    (is (string/includes? result "<h1>Heading 1</h1>"))
    (is (string/includes? result "<h2>Heading 2</h2>"))
    (is (string/includes? result "<p>stuff</p>"))
    (is (string/includes? result "<p>things</p>"))))
