(defproject pembas "0.4.0"
  :description "NetLogo Agent-Based Models with Personality, Emotion, and Mood Bearing Agents"
  :url "http://github.com/oubiwann/abm-personality-and-emotions"
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
  :jar-exclusions [#".*resources", #".*papers"]
  :clean-targets ^{:protect false} ["target"]
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
