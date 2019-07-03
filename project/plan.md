# Project Plan: Worksheet

These questions are intended to focus your thoughts on a phenomenon for which you would eventually like to build an ABM model. It is important to choose a phenomenon of limited scope so that you can make progress with your model.  Even if the phenomenon you would eventually like to address is large in scope, try to choose a sub-part of it as a starting point.

(1) What part of your phenomenon would you like to build a model of?

<strong>
Crowd behaviours
</strong>

(2) What are the principal types of agents involved in this phenomenon?

<strong>
Agents with simulated personality, emotions, and moods -- all very simplistic.
</strong>

(3)   What properties do these agents have (describe by agent type)?

<strong>
Personality agents: an agent displays one personality of of a possible set of personality types. Type interactions are such that there are two types that are similar and they attract; there are two types that are similar and they repulse; there are two types that are dissimilar and they attract; there are two types that are dissimilar and they repulse.

Emotional agents: an agent displays one emotion of two possible emotions (positive emotion, negative emotion). These are considered highly volatile. Two agents with the same emotional state attract; otherwise, repulse. An agent's emotional state is updated based upon the average emotional state of its immediate neighbors. No history of neighbors is maintained.

Mood agents: an agent displays one of two possible moods (good mood, bad mood). These are not as volatile as emotions, but rather persist over time. However, they are changeable. Mood impact from one agent to another will only be transmitted when arbitrary sensory input/output sides face each other. As such, each agent will have four sides, with the lowest indexed face representing the intput/output side. A mood impact event will follow an inverse square law as far as the degree to which it effects a given agent; after a certain number of ticks, the event will be "forgotten" and no longer contribute to the agent's mood.

If there is time at the end of the course, combinations of these agents in a single agent will be explored.
</strong>

(4)   What actions (or behaviors) can these agents take (describe by agent type)?

<strong>
Personality agents can move in 2D space. Motivation will be based upon personality compatibility between neighbors.

Emotional agents can move in 2D space. Motivation will be based upon those with similar moods.

Mood agents can move in 2D space. Motivation will be based upon those with similar moods, but with persistent/lingering effects.
</strong>

(5)   If the agents have goals, what are their goals (describe by agent type)?

<strong>
The goal of the agents is to move; if an agent is able to apply a motivation rule, to use that as the basis for choosing a direction of movement. If not, move randomly.
</strong>

(6)   In what kind of environment do these agents operate?

<strong>
An abstract, 2D plane; their environment is characterless and does not contribute any motivating factors.
</strong>

(7)   How do these agents interact with this environment?

<strong>
They do not; they interact only with each other.
</strong>

(8)   If you had to discretize the phenomenon into time steps, what events and in what order would occur during any one time step?

<strong>
Each time step will allow all agents to move one pixel. The snapshot in time of each agent's neighbors will be the data each agent will use to calculate its preferred direction of movement.
</strong>

(9)   What do you hope to observe from this model?

<strong>
Patterns of movement in crowds of simplified personalities, emotives, and mood-bearers. In the event that I am able to model a combination agent, I would be very interested in observing the idea of moods moving through a crowd as contagions.

Thank you in advance for your time and effort on these questionnaires.  We look forward to seeing you soon.
</strong>
