# Modeling Crowds with Personality, Emotions and Moods

*NetLogo Agent-Based Models with Personality, Emotion, and Mood Bearing Agents*

[![Build Status][travis-badge]][travis]
[![Clojars Project][clojars-badge]][clojars]
[![Tag][tag-badge]][tag]
[![Clojure version][clojure-v]](project/project.clj)


## About

For my project, I wanted to explore very basic examples of interactions I've
been interested in for
[quite some time](https://github.com/hexagram30/agent/commits/master?after=c998722edc235612acf8420943c528a8315d7da6+0),
focused on what is sometimes called emotional modeling. While this topic has
numerous practical applications, my interest is simply in building interesting
interactions and observing any emergent behaviour. If useful, I'd like to
integrate this into world-building exercises or in generative
narratives/story creation (with interactive, dynamic characters).

While this project examines very simple examples of personality, emotion, and
mood, I am ultimately interested in building much more complex models that make
use of the OCEAN/Big Five personality model, and various taxonomies of emotions
and moods. This project took a certain amount of inspiration from the 2003
paper by Egges et al.,
[A Model for Personality and Emotion Simulation](https://github.com/hexagram30/agent/blob/master/dev-resources/research/%5B2003%20Egges%5D%20A%20Model%20for%20Personality%20and%20Emotion%20Simulation.pdf).

## Documentation

Each model model in this project has had its `Info` tab exported and published
as documentation viewable on Github:

* Personality Model
    * [Simple](https://oubiwann.github.io/abm-personality-and-emotions/personality.html)
    * [Complex](https://oubiwann.github.io/abm-personality-and-emotions/personality-complex.html)
* [Emotion Model](https://oubiwann.github.io/abm-personality-and-emotions/emotion.html) (in-progress)
* [Mood Model](https://oubiwann.github.io/abm-personality-and-emotions/mood.html)
* [Combined Models](https://oubiwann.github.io/abm-personality-and-emotions/combined.html) (not started)

## Naming

The agents in the model explored for this project I have named unimaginatively
PEMBAs: "personality-, emotion-, and mood-bearing agents."

## Resources

1. [Project Worksheet](plan.md)
2. Project Model Code
   * Personality
      * [Simple](PEMBAs-and-Crowds-Personality.nlogo)
      * [Complex](PEMBAs-and-Crowds-Personality-Complex.nlogo)
   * [Emotions](PEMBAs-and-Crowds-Emotion.nlogo) (in-progress)
   * [Moods](PEMBAs-and-Crowds-Mood.nlogo)
   * [Combined](PEMBAs-and-Crowds.nlogo) (not started)
3. Papers and articles
   * [A Model for Personality and Emotion Simulation](https://github.com/hexagram30/agent/blob/master/dev-resources/research/%5B2003%20Egges%5D%20A%20Model%20for%20Personality%20and%20Emotion%20Simulation.pdf)
   * [Testing Predictions From Personality Neuroscience: Brain Structure and the Big Five](../resources%2Fpapers%2F%5B2010%5D%20DeYoung%20-%20Testing%20Predictions%20From%20Personality%20Neuroscience%20-%20Brain%20Structure%20and%20the%20Big%20Five.pdf)
   * [Emotional Contagion and Empathy](../resources%2Fpapers%2F%5B2007%5D%20Hatfield%20-%20Emotional%20Contagion%20and%20Empathy.pdf)

## License

Copyright © 2019, Duncan McGreggor

Apache License, Version 2.0.

<!-- Named page links below: /-->

[travis]: https://travis-ci.org/oubiwann/abm-personality-and-emotions
[travis-badge]: https://travis-ci.org/oubiwann/abm-personality-and-emotions.png?branch=master
[deps]: http://jarkeeper.com/oubiwann/abm-personality-and-emotions
[deps-badge]: http://jarkeeper.com/oubiwann/abm-personality-and-emotions/status.svg
[logo]: resources/images/complexity-explorer-logo-x250.jpg
[logo-large]: resources/images/complexity-explorer-logo-x800.png
[tag-badge]: https://img.shields.io/github/tag/oubiwann/abm-personality-and-emotions.svg
[tag]: https://github.com/oubiwann/abm-personality-and-emotions/tags
[clojure-v]: https://img.shields.io/badge/clojure-1.10.1-blue.svg
[jdk-v]: https://img.shields.io/badge/jdk-1.11+-blue.svg
[clojars]: https://clojars.org/pembas
[clojars-badge]: https://img.shields.io/clojars/v/pembas.svg
