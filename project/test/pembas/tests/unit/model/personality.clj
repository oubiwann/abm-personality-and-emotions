(ns pembas.tests.unit.model.personality
  (:require
   [clojure.test :refer :all]
   [pembas.testing.netlogo :as netlogo]))

(def model "PEMBAs-and-Crowds.nlogo")

(deftest attracted-types
  (let [ws (netlogo/create-workspace model)]
    (is (= "hey!"
           (netlogo/report ws "repulsed-types" "Ib" ["Ia" "Ib" "IIb"])))))

(deftest repulsed-types
  (let [ws (netlogo/create-workspace model)]
    (is (= "hey!"
           (netlogo/report ws "repulsed-types" "Ib" ["Ia" "Ib" "IIb"])))))
