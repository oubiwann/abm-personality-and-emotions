# Project Plan: Worksheet

These questions are intended to focus your thoughts on a phenomenon for which you would eventually like to build an ABM model. It is important to choose a phenomenon of limited scope so that you can make progress with your model.  Even if the phenomenon you would eventually like to address is large in scope, try to choose a sub-part of it as a starting point.

## 1. What part of your phenomenon would you like to build a model of?

Crowd behaviours

## 2. What are the principal types of agents involved in this phenomenon?

Agents with simulated personality, emotions, and moods -- all very simplistic.

## 3. What properties do these agents have (describe by agent type)?

* **Personality agents**: an agent displays one personality of a possible set of personality types. Type interactions are such that there are two types that are similar and they attract; there are two types that are similar and they repulse; there are two types that are dissimilar and they attract; there are two types that are dissimilar and they repulse.
* **Emotional agents**: an agent displays one emotion of two possible emotions (positive emotion, negative emotion). These are considered highly volatile. Two agents with the same emotional state attract; otherwise, repulse. An agent's emotional state is updated based upon the average emotional state of its immediate neighbors. No history of neighbors is maintained.
* **Mood agents**: an agent displays one of two possible moods (good mood, bad mood). These are not as volatile as emotions, but are influenced by their neighbors under certain circumstances. Furthermore, the transmission of mood has a continued impact over time.
* **Combined** If there is time at the end of the course, combinations of these agents in a single agent will be explored.

## 4. What actions (or behaviors) can these agents take (describe by agent type)?

* Personality agents can move in 2D space. Motivation will be based upon personality compatibility between neighbors.
* Emotional agents can move in 2D space. Motivation will be based upon those with similar emotions.
* Mood agents can move in 2D space. Motivation will be based upon those with similar moods, but with persistent/lingering effects.

## 5. If the agents have goals, what are their goals (describe by agent type)?

The goal of the agents is to move; if an agent is able to apply a motivation rule, to use that as the basis for choosing a direction of movement. If not, move randomly. (Or not at all?)

## 6. In what kind of environment do these agents operate?

An abstract, 2D plane; their environment is characterless and does not contribute any motivating factors. Each agent has four options for movement: forward, back, left, right (no diagonal moves).

## 7. How do these agents interact with this environment?

They do not; they interact only with each other. Toward that end, each agent is considered to have four sides. The direction in which an agent moves is considered its input/output sensory side (the means by which it will send/receive a mood to/from another agent).

* **Personality agents**: have fixed values; movement in the environment does not change the value, but is determined by the values of all neighboring agents. The sum of the personality forces (repulsive, attractive) will result in a vector, and the direction of the vector that is most closely matched by one of the available legal moves will be the direction in which the agent moves.
* **Emotional agents**: for each move in the environment, the emotional agent will determine the emotional value of each of its neighbors, determine their average, multiply that average by a tunable parameter that represents the degree to which the neighbors' average emotional value influences their own (e.g., between 0.0 and 1.0), and then multiply that by their current emotional state to get a new emotional state.
* **Mood agents**: for each move that results in two agents facing each other, a mood event is transmitted from each to the other. The value transmitted is the value of that agent's own mood, with a tunable parameter available. After a mood transmission event, continued effects will contribute to the mood of the receiving agent according to an inverse square law: at one tick, impact is 100% of the value; after two ticks, the impact is 1/4th the value; after three ticks, 1/9th the value, etc. The full effect of these will be subject to the tunable parameter (a 0.0 to 1.0 multiplier, as with the emotional agents). The number of ticks after which any further post-transmission effects will be zero should also be a tunable parameter. (This would be the number of ticks after which an agent will have "forgotten" the event, where the effects no longer contribute to its mood value).

## 8. If you had to discretize the phenomenon into time steps, what events and in what order would occur during any one time step?

Each time step will allow all agents to move one pixel. The snapshot in time of each agent's neighbors will be the data each agent will use to calculate its preferred direction of movement.

* **Personality agents**: identify the personality type of each neighbor and calculate the vector representing most attractive direction to move (random choice for tie breakers)
* **Emotional agents**: identity the emotional state of each neighbor and perform an average, updating the agent state accordingly; move in the direction that is most like one's own (random choice for tie breakers)
* **Mood agents**: perform calculations for any past mood transmission events that are still having an impact. Then, identify the moods of each neighbor and perform an average; move in the direction that is most like one's own and record that direction for the neighboring agents to use to see which direction the agent is facing. Then check to see if it is facing the agent it moved towards (by checking that agent's most recent move). If not, then skip the rest. If so, then perform a full-impact mood transmission event and append the impacting value to a queue, marking its value. This will be used in subsequent ticks for this agent until the memory threshold is passed, at which point the transmitted value will be discarded.

## 9. What do you hope to observe from this model?

Patterns of movement in crowds of simplified personalities, emotives, and mood-bearers. In the event that I am able to model a combination agent, I would be very interested in observing the idea of moods moving through a crowd as contagions.

Thank you in advance for your time and effort on these questionnaires.  We look forward to seeing you soon.
