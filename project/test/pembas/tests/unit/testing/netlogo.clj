(ns pembas.tests.unit.testing.netlogo
  (:require
   [clojure.test :refer :all]
   [pembas.testing.netlogo :as netlogo]))

(def model "PEMBAs-and-Crowds.nlogo")

(deftest arg->str
  (is (= "\"a\""
         (netlogo/arg->str "a")))
  (is (= "[\"a\" \"b\" \"c\"]"
         (netlogo/arg->str ["a" "b" "c"]))))
