(ns pembas.netlogo
  (:require
   [clojure.java.io :as io]
   [clojure.string :as string])
  (:import
   (org.nlogo.api Dump)
   (org.nlogo.app.infotab InfoFormatter)
   (org.nlogo.headless HeadlessWorkspace)
   (org.nlogo.util Utils)))

(def section-separator #"@#\$#@#\$#@\n")
(def default-docs-font-size 12)

(defn arg->str
  [arg]
  (if (string? arg)
    (str "\"" arg "\"")
    (str arg)))

(defn args->str
  [func-name args]
  (string/join " " (concat [func-name] (map arg->str args))))

(defn resource-model
  [rsrc-rltv-path-to-model]
  (slurp (io/resource rsrc-rltv-path-to-model)))

(defn extract-info
  [source-str]
  (nth (string/split source-str section-separator) 2))

(defn info
  [rsrc-rltv-path-to-model]
  (extract-info (resource-model rsrc-rltv-path-to-model)))

(defn md->html
  ([string]
   (md->html string default-docs-font-size))
  ([string font-size]
   (InfoFormatter/apply string font-size)))

(defn info-html
  ([rsrc-rltv-path-to-model]
    (info-html default-docs-font-size))
  ([rsrc-rltv-path-to-model font-size]
    (md->html (info rsrc-rltv-path-to-model) font-size)))

(defn create-workspace
  [model-path]
  (let [ws (HeadlessWorkspace/newInstance)]
    (.open ws model-path false)
    ws))

(defn report
  [ws func-name & args]
  (Dump/logoObject (.report ws (args->str func-name args))))
