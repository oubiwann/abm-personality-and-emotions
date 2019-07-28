(ns pembas.tests.unit.model.personality.util.charge
  (:require
   [clojure.test :refer :all]
   [pembas.netlogo :as netlogo]))

(def model "PEMBAs-and-Crowds-Personality.nlogo")

(deftest charge
  (let [ws (netlogo/create-workspace model)]
    (is (= "0.1111111111111111"
           (netlogo/report ws "charge" 3)))
    (is (= "0.027777777777777776"
           (netlogo/report ws "charge" 6)))
    (is (= "0.020408163265306124"
           (netlogo/report ws "charge" 7)))))

(deftest summed-charge
  (let [ws (netlogo/create-workspace model)]
    (is (= "0.20011337868480725"
           (netlogo/report ws "summed-charge" [7 3 7 6 7])))))

(deftest summed-coords
  (let [ws (netlogo/create-workspace model)]
    (is (= "[0 0]"
        (netlogo/report ws "summed-coords" [[0 0]])))
    (is (= "[1 1]"
        (netlogo/report ws "summed-coords" [[1 1]])))
    (is (= "[-1 -1]"
        (netlogo/report ws "summed-coords" [[-1 -1]])))
    (is (= "[1 1]"
        (netlogo/report ws "summed-coords" [[0 0] [1 1]])))
    (is (= "[0 0]"
        (netlogo/report ws "summed-coords" [[-1 -1] [1 1]])))
    (is (= "[3 3]"
        (netlogo/report ws "summed-coords" [[0 0] [1 1] [2 2]])))
    (is (= "[9 12]"
        (netlogo/report ws "summed-coords" [[1 2] [3 4] [5 6]])))))

(deftest center-of-charge
  (let [ws (netlogo/create-workspace model)]
    (is (= "[0 0]"
        (netlogo/report ws "center-of-charge" [[0 0]])))
    (is (= "[1 1]"
        (netlogo/report ws "center-of-charge" [[1 1]])))
    (is (= "[-1 -1]"
        (netlogo/report ws "center-of-charge" [[-1 -1]])))
    (is (= "[0.5 0.5]"
        (netlogo/report ws "center-of-charge" [[0 0] [1 1]])))
    (is (= "[0 0]"
        (netlogo/report ws "center-of-charge" [[-1 -1] [1 1]])))
    (is (= "[1 1]"
        (netlogo/report ws "center-of-charge" [[0 0] [1 1] [2 2]])))
    (is (= "[3 4]"
        (netlogo/report ws "center-of-charge" [[1 2] [3 4] [5 6]])))))

; (deftest sum-forces
;   (let [ws (netlogo/create-workspace model)]
;     (is (= "xxx" (netlogo/report "sum-forces" ws [1] [2])))))
