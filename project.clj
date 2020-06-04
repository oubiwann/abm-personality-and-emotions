(defproject pembas "0.3.0-SNAPSHOT"
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
  :source-paths ["src/clj"]
  :resource-paths ["./", "resources"]
  :profiles {
    :docs {
      :main pembas.docs}
    :test {
      :plugins [
        [lein-ltest "0.3.0"]]}}
  :aliases {
    "ltest" ["with-profile" "+test" "ltest"]
    "gen-docs" ["do"
      ["with-profile" "+docs" "run" "PEMBAs-and-Crowds-Personality.nlogo" "./docs/personality.html"]
      ["with-profile" "+docs" "run" "PEMBAs-and-Crowds-Personality-Complex.nlogo" "./docs/personality-complex.html"]
      ["with-profile" "+docs" "run" "PEMBAs-and-Crowds-Emotion.nlogo" "./docs/emotion.html"]
      ["with-profile" "+docs" "run" "PEMBAs-and-Crowds-Mood.nlogo" "./docs/mood.html"]
      ["with-profile" "+docs" "run" "PEMBAs-and-Crowds.nlogo" "./docs/combined.html"]]})
