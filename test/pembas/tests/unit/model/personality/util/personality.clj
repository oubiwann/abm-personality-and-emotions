(ns pembas.tests.unit.model.personality.util.personality
  (:require
   [clojure.test :refer :all]
   [pembas.netlogo :as netlogo]))

(def model "PEMBAs-and-Crowds-Personality.nlogo")

(def netlogo-red "15")
(def netlogo-green "55")
(def netlogo-blue "105")
(def netlogo-yellow "45")

(deftest id-to-color
  (let [ws (netlogo/create-workspace model)]
    (is (= netlogo-green
           (netlogo/report ws "id-to-color" 0)))
    (is (= netlogo-blue
           (netlogo/report ws "id-to-color" 1)))
    (is (= netlogo-yellow
           (netlogo/report ws "id-to-color" 2)))
    (is (= netlogo-red
           (netlogo/report ws "id-to-color" 3)))))

(deftest id-to-name
  (let [ws (netlogo/create-workspace model)]
    (is (= "Ia"
           (netlogo/report ws "id-to-name" 0)))
    (is (= "Ib"
           (netlogo/report ws "id-to-name" 1)))
    (is (= "IIa"
           (netlogo/report ws "id-to-name" 2)))
    (is (= "IIb"
           (netlogo/report ws "id-to-name" 3)))))

(deftest name-to-id
  (let [ws (netlogo/create-workspace model)]
    (is (= "0"
           (netlogo/report ws "name-to-id" "Ia")))
    (is (= "1"
           (netlogo/report ws "name-to-id" "Ib")))
    (is (= "2"
           (netlogo/report ws "name-to-id" "IIa")))
    (is (= "3"
           (netlogo/report ws "name-to-id" "IIb")))))

(deftest attracted-lookup
  (let [ws (netlogo/create-workspace model)]
    (is (= "[0 1 2 3]"
           (netlogo/report ws "attracted-lookup" 0)))
    (is (= "[0 1]"
           (netlogo/report ws "attracted-lookup" 1)))
    (is (= "[0]"
           (netlogo/report ws "attracted-lookup" 2)))
    (is (= "[0]"
           (netlogo/report ws "attracted-lookup" 3)))))

(deftest repulsed-lookup
  (let [ws (netlogo/create-workspace model)]
    (is (= "[]"
           (netlogo/report ws "repulsed-lookup" 0)))
    (is (= "[2 3]"
           (netlogo/report ws "repulsed-lookup" 1)))
    (is (= "[2 3]"
           (netlogo/report ws "repulsed-lookup" 2)))
    (is (= "[1 2 3]"
           (netlogo/report ws "repulsed-lookup" 3)))))

(deftest filter-attracted
  (let [ws (netlogo/create-workspace model)]
    (is (= "[0 1]"
           (netlogo/report ws "filter-attracted" 1 [0 1 3])))))

(deftest filter-repulsed
  (let [ws (netlogo/create-workspace model)]
    (is (= "[3]"
           (netlogo/report ws "filter-repulsed" 1 [0 1 3])))))
