(ns pembas.tests.unit.testing.netlogo
  (:require
   [clojure.test :refer :all]
   [pembas.testing.netlogo :as netlogo]))

(def model "PEMBAs-and-Crowds.nlogo")

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
