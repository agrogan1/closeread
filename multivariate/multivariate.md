# Why Do We Need Multivariate Models To Evaluate Interventions?

Across the world, there is a great deal of suffering. Many people have mental health issues or substance use. People often suffer the after effects of discrimination, poverty, trauma, violence or conflict.

Understandably, many people and organizations try to develop *interventions* or *programs* for those who suffer from such difficulties. 

Yet evaluating such *interventions* or *programs* may be more difficult than it appears.

Let's consider a simple evaluation of an *intervention* or *program* designed to improve mental health.

```mermaid
---
config:
  look: handDrawn
  theme: neutral
---

flowchart LR

  A["Group A: 50%"]

  B["Group B: 50%"]

```

```mermaid
---
config:
  look: handDrawn
  theme: neutral
---

flowchart LR

  interventiongroup["intervention group"] --> intervention

  intervention[intervention] --> outcome1[outcome]

  comparisongroup["comparison group"] ---> outcome0[outcome]

  linkStyle 0,1,2 stroke:#000000,stroke-width:3px,font-size:36px,color:black;

```

```mermaid
---
config:
  look: handDrawn
  theme: neutral
---

flowchart LR

  intervention(intervention) --> outcome(outcome)

  group(group) --> outcome(outcome)

  linkStyle 0,1 stroke:#000000,stroke-width:3px,font-size:36px,color:black;

```

