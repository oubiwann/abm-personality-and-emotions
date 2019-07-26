(ns pembas.tests.unit.model.personality.util.general
  (:require
   [clojure.test :refer :all]
   [pembas.netlogo :as netlogo])
  (:refer-clojure :exclude [frequencies]))

(def model "PEMBAs-and-Crowds-Personality.nlogo")

(deftest intersection
  (let [ws (netlogo/create-workspace model)]
    (is (= "[1 2]"
           (netlogo/report ws "intersection" [0 1 2] [1 2 3])))))

(deftest union
  (let [ws (netlogo/create-workspace model)]
    (is (= "[0 1 2 3]"
           (netlogo/report ws "union" [0 1 2] [1 2 3])))))

(deftest sort-tuples
  (let [ws (netlogo/create-workspace model)]
    (is (= "[[0 z] [3 m] [9 a]]"
           (netlogo/report ws "sort-tuples" [[9 "a"] [0 "z"] [3 "m"]])))))

(deftest frequencies
  (let [ws (netlogo/create-workspace model)]
    (is (= "[[a 3] [b 2] [c 1] [d 1]]"
           (netlogo/report ws "frequencies" ["a" "b" "a" "a" "c" "b" "d"])))))
