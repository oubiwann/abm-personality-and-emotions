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

; (deftest charge-magnitude
;   (let [ws (netlogo/create-workspace model)]
;     (is (= "xxx" (netlogo/report "charge-magnitude" ws [1])))))

; (deftest center-of-charge
;   (let [ws (netlogo/create-workspace model)]
;     (is (= "xxx" (netlogo/report "center-of-charge" ws [1] [2])))))

; (deftest sum-forces
;   (let [ws (netlogo/create-workspace model)]
;     (is (= "xxx" (netlogo/report "sum-forces" ws [1] [2])))))
