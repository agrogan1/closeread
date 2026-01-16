# When Empathy Helps and Hurts: 
## Non-Linear Associations Between Early Childhood Maltreatment History, Empathy and Self-Harm Thoughts

**Objective:** Child maltreatment is a well-established risk factor for self-harm, yet the affective processes underlying this association remain unclear. This study examines how empathy relates to the association between early childhood maltreatment and lifetime self-harm thoughts.

**Method:** Data from 303 adults were stratified based on the presence or absence of maltreatment history in early childhood. Self-reports of lifetime self-harm thoughts in adulthood and empathy during adolescence were examined in both groups using generalized additive models to assess non-linear relationships.

```mermaid
block
  columns 3
  m space sh
  space space space
  space e space
  space space space
  childhood adolescence adulthood

  m("maltreatment") --> sh("self harm thoughts")

  e("empathy") --> sh

  style m fill:#9A3324,stroke:#000000,stroke-width:2px,color:#FFFFFF;

  style e fill:#374EA2,stroke:#000000,stroke-width:2px,color:#FFFFFF;

  style sh fill:#FFC20E,stroke:#000000,stroke-width:2px,color:#000000;

  style childhood fill:#D3D3D3,stroke:#000000,stroke-width:2px,color:#000000;

  style adolescence fill:#D3D3D3,stroke:#000000,stroke-width:2px,color:#000000;

  style adulthood fill:#D3D3D3,stroke:#000000,stroke-width:2px,color:#000000;

```

**Results:** Adults with early childhood maltreatment history were more likely to report self-harm thoughts than those without the history (χ² = 14.87, p < .01). A significant nonlinear association was observed between empathy and self-harm thoughts (edf = 2.14 χ² = 9.67, p = .02). 

```mermaid
block
  columns 3
  m space sh
  space space space
  space space space
  space e space
  space space space
  childhood adolescence adulthood

  m("maltreatment") -- "increases" --> sh("self harm thoughts")

  e("empathy") -- "curvilinear <br>relationship" --> sh

  style m fill:#9A3324,stroke:#000000,stroke-width:2px,color:#FFFFFF;

  style e fill:#374EA2,stroke:#000000,stroke-width:2px,color:#FFFFFF;

  style sh fill:#FFC20E,stroke:#000000,stroke-width:2px,color:#000000;

  style childhood fill:#D3D3D3,stroke:#000000,stroke-width:2px,color:#000000;

  style adolescence fill:#D3D3D3,stroke:#000000,stroke-width:2px,color:#000000;

  style adulthood fill:#D3D3D3,stroke:#000000,stroke-width:2px,color:#000000;

```
Predicted probabilities of self-harm thoughts were lowest at moderate levels of empathy for both groups. Risk for self-harm thoughts was highest among individuals with early childhood maltreatment history and low or high empathy.

![three dimensional plot of results](empathy-vis-gam.png)

**Conclusion:** While a moderate level of empathy can be protective from early childhood maltreatment, both low and high levels of empathy were associated with a greater risk for self-harm thoughts. Findings suggest the need to further investigate the role of empathy as a “risky strength” among adults.


