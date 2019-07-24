;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Global Data   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

globals []

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Turtle Data   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

turtles-own [
  personality-id
  personality-type
  personality-neighbors
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Setup Procedures   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  clear-all
  set-default-shape turtles "circle"
  ;; agent-count is the total number of personality agents in the model; it is
  ;; a global variable set via a slider in the GUI
  create-turtles agent-count [
    setxy random-xcor random-ycor
    set personality-id random 4
    set personality-neighbors nobody
  ]
  set-personalities
  reset-ticks
end

to set-personalities
  ;; XXX Once this is ironed out, move salient details to info tab ...
  ;;
  ;; We define two simple personality types here, whose sole characteristics are
  ;; just the names of the types: I and II.
  ;;
  ;; * abstractly similar / dissimilar
  ;; * abstractly attractrf / repulsed (think of gravity as the analogy here,
  ;;   not physical appearance, etc.)
  ;;
  ;; Viewing these types in a grid is helpful, with a `+` indicating agents that
  ;; are attracted, and a `-` indicating agents that are repulsed:
  ;;
  ;;     | I | II |
  ;; ----+---+----+
  ;;   I | +    + |
  ;;  II | -    - |
  ;; ----+---+----+
  ;;
  ;; Which gives us a full set of type interaction permutations to explore, namely
  ;; specific types that are:
  ;;
  ;; * similar and attracted to each other
  ;; * dissimilar and attracted to each other
  ;; * similar and repulsed from each other
  ;; * dissimilar and repulsed from each other
  ;;
  ;; That being said, it's not exactly the most convenient way to explore the
  ;; personality interactions. The behaviours shown in that grid will change
  ;; based upon the initiating agent's personality type:
  ;;
  ;; * Type I(top) to Type II(side) are repulsed, whereas
  ;; * Type II(top) to Type I(side) are attracted.
  ;;
  ;; As such, it would be useful to make them more distinct, perhaps something
  ;; along these lines:
  ;;
  ;;      | Ia | IIa |
  ;; -----+----+----+
  ;;   Ib |  +    + |
  ;;  IIb |  -    - |
  ;; -----+----+----+
  ;;
  ;; Now we can say with more clarity:
  ;;
  ;; * Type Ia and Type IIb are repulsed;
  ;; * Type Ib and Type IIa are attracted.
  ;;
  ;; However, while this provides a quick look at how different types interact
  ;; with each other, we can't tell from this how each agent interacts with
  ;; other agents of its own types. To split things evently, let's say that:
  ;;
  ;; * all I's are attracted to other I's
  ;; * all II's are repulsed from other II's
  ;; * IIa's and Ib's are attracted
  ;; * Ia's and IIb's are repulsed
  ;;
  ;; That set of rules then gives us the following grid:
  ;;
  ;;      | Ia | Ib | IIa | IIb |
  ;; -----+----+----+-----+----+
  ;;   Ia |  +    +    +     -
  ;;   Ib |       +    +     -
  ;;  IIa |            -     -
  ;;  IIb |                  -
  ;;
  ;; Note that only one portion of the grid is required in this model, since
  ;; for simplicity's sake, we're making all attractions/repulsions reciprocal.
  ;;
  ;; By an aribtrary convention, we could assign integers to the different
  ;; personality types; from the left across the column headers in the grid:
  ;;
  ;; * Type Ia: 0
  ;; * Type Ib: 1
  ;; * Type IIa: 2
  ;; * Type IIb: 3
  ;;
  ;; Note that the interaction force will be provided by a separate function,
  ;; `get-interaction-force`
  ;;
  set-agent-colors
  ask turtles [
    set personality-type id-to-name personality-id
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Entrypoint Procedure   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to go
  ask turtles [ move-personality-agents ]
  tick
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Turtle Procedures   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to move-personality-agents
  find-neighbors
  ifelse any? personality-neighbors
    [ take-interaction-step ]
    [ take-random-step ]
end

to find-neighbors
  ;; interaction-radius is the distance within which personality agents
  ;; will have an impact on each other; it is a global variable set via a
  ;; slider in the GUI
  set personality-neighbors (in-radius2 (other turtles) interaction-radius)
end

to take-interaction-step
  ;; TBD
end

to-report interaction-force
  ;; This procedure calculates the force of personalities on the current
  ;; agent from all of its neighbors. This involves several steps:
  ;;
  ;; 1. Get the distance to each neighbor (direction)
  ;; 2. Get the personality type of each neighbor and calculate its impact
  ;;    on the current agent (magnitude)
  ;; 3. With 1 & 2, create a vector for each neighbor
  ;; 4. Calulate the sum of the "forces" of these vectors; if positive, the
  ;;    agent will be attracted, and if negative, the agent will be repulsed.

  ;; force-multiplier is an arbitrary rational number that limits the
  ;; force of personality interaction, from zero, though to partial, to
  ;; maximum influence; it is a global variable set via a slider in the
  ;; GUI
end

to take-random-step
  ;;set heading random 360
  rt random 30
  forward 1
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Visual Debugging Procedures   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to show-attracted
  let agent turtle selected-agent
  all-blue
  agent-yellow agent
  highlight-attracted agent
end

to show-repulsed
  let agent turtle selected-agent
  all-blue
  agent-yellow agent
  highlight-repulsed agent
end

to show-relations
  let agent turtle selected-agent
  all-blue
  agent-yellow agent
  highlight-relations agent
end

to agent-yellow [agent]
  ask agent [
    set color yellow
    ]
end

to all-blue
  ask turtles [
    set color blue
  ]
end

to highlight-attracted [agent]
  let attracted-agents filter-attracted-agents agent
  if attracted-agents != nobody [
    ask attracted-agents [
      set color green
    ]
  ]
end

to highlight-repulsed [agent]
  let repulsed-agents filter-repulsed-agents agent
  if repulsed-agents != nobody [
    ask repulsed-agents [
      set color red
    ]
  ]
end

to highlight-relations [agent]
  highlight-attracted agent
  highlight-repulsed agent
end

to set-agent-colors
  ask turtles [
    set color id-to-color personality-id
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   General Support Procedures   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to-report in-radius2 [agentset r]
  ;; This procedure is required due to the following bug in NetLogo 6.1:
  ;;   https://github.com/NetLogo/NetLogo/issues/1763
  report (agentset with [ distance myself <= r ])
end

to-report intersection [a b]
  report filter [x -> member? x a] b
end

to-report union [a b]
  report remove-duplicates sentence a b
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Personality Support Procedures   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to-report id-to-color [type-id]
  if type-id = 0 [ report red ]
  if type-id = 1 [ report green ]
  if type-id = 2 [ report blue ]
  if type-id = 3 [ report yellow ]
end

to-report id-to-name [type-id]
  if type-id = 0 [ report "Ia" ]
  if type-id = 1 [ report "Ib" ]
  if type-id = 2 [ report "IIa" ]
  if type-id = 3 [ report "IIb" ]
end

to-report name-to-id [type-name]
  if type-name = "Ia" [ report 0 ]
  if type-name = "Ib" [ report 1 ]
  if type-name = "IIa" [ report 2 ]
  if type-name = "IIb" [ report 3 ]
end

;; For the following attraction/repulsion procedures, the grid from the
;; `set-personalities` procedure documentation is useful:
;;
;;      | Ia | Ib | IIa | IIb |
;; -----+----+----+-----+----+
;;   Ia |  +    +    +     -
;;   Ib |       +    +     -
;;  IIa |            -     -
;;  IIb |                  -
;;
;; More so if we convert that to the integer values:
;;
;;    | 0 | 1 | 2 | 3 |
;; ---+---+---+---+---+
;;  0 | +   +   +   -
;;  1 |     +   +   -
;;  2 |         -   -
;;  3 |             -
;;

to-report attracted-lookup [self-type]
  if self-type = 0 [ report [0 1 2] ]
  if self-type = 1 [ report [0 1 2] ]
  if self-type = 2 [ report [0 1] ]
  if self-type = 3 [ report [] ]
  report word "Unkown type: " self-type
end

to-report repulsed-lookup [self-type]
  if self-type = 0 [ report [3] ]
  if self-type = 1 [ report [3] ]
  if self-type = 2 [ report [2 3] ]
  if self-type = 3 [ report [0 1 2 3] ]
  report word "Unkown type: " self-type
end

to-report filter-attracted [self-type other-types]
  report intersection (attracted-lookup self-type) other-types
end

to-report filter-repulsed [self-type other-types]
  report intersection (repulsed-lookup self-type) other-types
end

to-report summed-charge
  ;;

end

to-report charge-magnitude
  ;; The magnitude of an attractive or repuslive "charge" is given by
  ;; the inverse square of the distance from the agent in question

end

to-report center-of-charge
  ;; The "center of charge" is given by the x and y components of the nearby
  ;; personalities times their associated charge magnitudes, then divided by the
  ;; sums of their magnitudes. This is analogous to center of mass calcualtions
  ;; in two dimensions.
  ;;
  ;; Steps are as follows, for all agents:
  ;; 1) Get their distance from self; square it and invert it. This is the
  ;;    magnitude.
  ;; 2) Get each xcoord and multiply by magnitude, sum the results
  ;; 3) Sum the magnitudes and divide the results of the previous step by this
  ;; 4) Do steps 2 & 3 for ycoords; the combination of these two results
  ;;    represents the x,y coord of the "center of charge".
end

to-report sum-forces
  ;; This procedure does the following:
  ;; * gets the "center of charge" for attracting agents
  ;; * gets the "center of charge" for repulsing agents
  ;; * calculates their magnitude using the `charge-magnitude` function
  ;; * transforms the repulsing location by putting it on the other side
  ;;   of the agent and then treating it as attracting
  ;; * calculates the sum of the magnitudes
  ;; * calculates the sum of the vector components
  ;;
  ;; Once these steps are done, the direction can be converted to degrees so
  ;; that the agent can face that direction, and the magnitude can be used to
  ;; move the agent that many units in the direction it faces.
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Agent Support Procedures   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to-report member-personality? [agent personality-ids]
  let agent-personality [personality-id] of agent
  if member? agent-personality personality-ids [ report true ]
  report false
end

to-report agent-intersection [agents personality-ids]
  if agents = nobody [ report agents ]
  if personality-ids = [] [ report nobody ]
  report turtle-set (map [x -> agents with [personality-id = x]] personality-ids)
end

to-report filter-attracted-agents [agent]
  report agent-intersection [personality-neighbors] of agent
                            (attracted-lookup [personality-id] of agent)
end

to-report filter-repulsed-agents [agent]
  report agent-intersection [personality-neighbors] of agent
                            (repulsed-lookup [personality-id] of agent)
end

;; Copyright © 2019 Duncan McGreggor.
;; See "Info" tab for full copyright and license.
@#$#@#$#@
GRAPHICS-WINDOW
216
24
1069
566
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-32
32
-20
20
1
1
1
ticks
30.0

BUTTON
19
250
85
283
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
101
250
164
283
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SLIDER
19
63
191
96
agent-count
agent-count
4
1000
55.0
1
1
NIL
HORIZONTAL

TEXTBOX
20
27
170
49
Initial Conditions
18
0.0
1

SLIDER
18
109
190
142
interaction-radius
interaction-radius
0
100
8.0
1
1
NIL
HORIZONTAL

TEXTBOX
20
211
170
233
Model Manager
18
0.0
1

SLIDER
18
156
190
189
force-multiplier
force-multiplier
0
1
0.5
0.01
1
NIL
HORIZONTAL

INPUTBOX
18
341
115
401
selected-agent
0.0
1
0
Number

TEXTBOX
19
305
169
327
Hilight
18
0.0
1

BUTTON
17
403
115
436
show relations
show-relations
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
17
440
115
473
show attracted
show-attracted
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
17
479
117
512
show repulsed
show-repulsed
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## HOW TO CITE

If you mention this model in a publication, we ask that you include the citations below.

McGreggor, D. (2019). NetLogo Simple XXX Model. https://github.com/oubiwann/intro-abm/tree/master/project.

## REFERENCES

1. [Github project](https://github.com/oubiwann/intro-abm).
1. A Model for Personality and Emotion Simulation, Arjan Egges-Sumedha Kshirsagar-Nadia Magnenat-Thalmann - Lecture Notes in Computer Science Knowledge-Based Intelligent Information and Engineering Systems - 2003

## COPYRIGHT AND LICENSE

Copyright © 2019 Duncan McGreggor.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
