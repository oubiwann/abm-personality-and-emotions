(ns pembas.tests.unit.infotab
  (:require
   [clojure.java.io :as io]
   [clojure.string :as string]
   [clojure.test :refer :all]
   [pembas.netlogo :as netlogo]))

(def model "testing/Infotabtest.nlogo")

(deftest resource-model
  (is (string/includes? (netlogo/resource-model model)
                        "## HOW IT WORKS\n\nIt doesn't!")))

(deftest extract-info
  (let [result (netlogo/extract-info (netlogo/resource-model model))]
    (is (string/starts-with? result "## WHAT IS IT?"))
    (is (string/ends-with? result "extract the text in the infotab!\n"))))

(deftest info
  (let [result (netlogo/info model)]
    (is (string/starts-with? result "## WHAT IS IT?"))
    (is (string/ends-with? result "extract the text in the infotab!\n"))))
