(ns pembas.docs
  (:require
   [pembas.netlogo :as netlogo]
   [clojure.string :as string])
  (:gen-class))

(defn save-file
  [model output]
  (let [data (netlogo/info model)]
    (spit output data)))

(defn -main
  [rsrc-rltv-path-to-model html-file & args]
  (println (format "Writing model '%s' to file '%s' ..."
                   rsrc-rltv-path-to-model
                   html-file))
  (save-file rsrc-rltv-path-to-model html-file))
