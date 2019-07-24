(defproject pembas "0.1.0-SNAPSHOT"
  :description "Introduction to Agent-Based Modeling (SFI/CI)"
  :url "http://github.com/oubiwann/intro-abm"
  :license {
    :name "Apache Version 2.0"
    :url "https://www.apache.org/licenses/LICENSE-2.0"}
  :repositories [
    ["netlogo" "https://dl.bintray.com/netlogo/NetLogo-JVM"]]
  :dependencies [
    [org.clojure/clojure "1.10.1"]
    [org.nlogo/netlogo "6.1.0"]]
  :profiles {
    :test {
      :resource-paths ["./"]
      :plugins [
        [lein-ltest "0.3.0"]]}}
  :aliases {
    "ltest" ["with-profile" "+test" "ltest"]})