## Dragonfly Algorithm

_The Dragonfly Algorithm is one of the most recently developed heuristic optimization techniques, presented by Seyedali Mirjalili in 2016._

**Objective Function**

$MinZ = \sum_{i=1}^8 x_{i}^2$

**Components of Algorithm**

+ Seperation $\rightarrow {S}_{i} = -\sum_{j=1}^N(X-{X}_{j})$

+ Alignment $\rightarrow {A}_{i} = \frac{\sum_{j=1}^N {V}_{j}}{N}$

+ Cohesion $\rightarrow {C}_{i} = \frac{\sum_{j=1}^N {X}_{j}}{N}-X$

+ Velocity $\rightarrow {V}_{i} = s \times {S}_{i} + a \times {A}_{i} + c \times {C}_{i}$

+ Food $\rightarrow {F}_{i} = {X}^{+}-X$

+ Enemy $\rightarrow {E}_{i} = {X}^{-}+X$

**Step And Position**

+ Step $\rightarrow{\Delta X}_{t+1} = {V}_{i} + f \times {F}_{i} + e \times {E}_{i} + w \times {\Delta X}_{t}$

    + Position $\rightarrow{X}_{t+1} = {X}_{t} + {\Delta X}_{t+1}$

_If there is no neighbours,_

+ Position $\rightarrow{X}_{t+1} = {X}_{t} + Léyv(d) \times {X}_{t+1}$

**Parameters of Algorithm**

+ Swarm Size
+ Dimension
+ Lower Bound
+ Upper Bound
+ Iteration Bound
+ Seperation Weight
+ Alignment Weight
+ Cohesion Weight
+ Food Weight
+ Enemy Weight
+ Inertia Weight
+ Beta for Lévy Flight

**Benchmark Results**

```r
DA(30, 8, -5, 5, 500, 0.3, 0.3, 0.3, 0.5, 0.001, 0.1, 1.7)
```

| Descriptive Statistics | Time | Trials |
| --- | --- | --- |
| Mean: $0.0191$ <br> Variance: $8.85 \times {10}^{-5}$ <br> Min: $0.0027$ <br> Max: $0.0503$ | $6.62$ mins | 100 |
