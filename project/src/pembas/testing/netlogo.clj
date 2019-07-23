(ns pembas.testing.netlogo
  (:require
   [clojure.java.io :as io]
   [clojure.string :as string])
  (:import
   (org.nlogo.api Dump)
   (org.nlogo.headless HeadlessWorkspace)
   (org.nlogo.util Utils)))

(defn load-model
  [model-path]
  (slurp (io/resource model-path)))

(defn create-workspace
  [model-path]
  (let [ws (HeadlessWorkspace/newInstance)]
    (.open ws model-path false)
    ws))

(defn arg->str
  [arg]
  (if (string? arg)
    (str "\"" arg "\"")
    (str arg)))

(defn args->str
  [func-name args]
  (string/join " " (concat [func-name] (map arg->str args))))

(defn report
  [ws func-name & args]
  (Dump/logoObject (.report ws (args->str func-name args))))
