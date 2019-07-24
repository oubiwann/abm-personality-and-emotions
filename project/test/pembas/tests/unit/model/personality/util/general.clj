(ns pembas.tests.unit.model.personality.util.general
  (:require
   [clojure.test :refer :all]
   [pembas.testing.netlogo :as netlogo]))

(def model "PEMBAs-and-Crowds-Personality.nlogo")

(deftest intersection
  (let [ws (netlogo/create-workspace model)]
    (is (= "[1 2]"
           (netlogo/report ws "intersection" [0 1 2] [1 2 3])))))

(deftest union
  (let [ws (netlogo/create-workspace model)]
    (is (= "[0 1 2 3]"
           (netlogo/report ws "union" [0 1 2] [1 2 3])))))
