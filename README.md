## Dragonfly Algorithm

_The Dragonfly Algorithm is one of the most recently developed heuristic optimization techniques, presented by Seyedali Mirjalili in 2016._

**Objective Function**

$MinZ = \sum_{i=1}^8 x_{i}^2$

**Components of Algorithm**

+ Seperation $\rightarrow S_{i} = -\sum_{j=1}^N(X-{X}_{j})$

+ Alignment $\rightarrow A_{i} = \frac{\sum_{j=1}^N {V}_{j}}{N}$

+ Cohesion $\rightarrow C_{i} = \frac{\sum_{j=1}^N {X}_{j}}{N}-X$

+ Velocity $\rightarrow V_{i} = s \times S_{i} + a \times A_{i} + c \times C_{i}$

+ Food $\rightarrow F_{i} = X^{+}-X$

+ Enemy $\rightarrow E_{i} = X^{-}+X$

**Step And Position**

+ Step $\rightarrow \Delta X_{t+1} = V_{i} + f \times F_{i} + e \times E_{i} + w \times \Delta X_{t}$

    + Position $\rightarrow X_{t+1} = X_{t} + \Delta X_{t+1}$

_If there is no neighbours,_

+ Position $\rightarrow X_{t+1} = X_{t} + Léyv(d) \times X_{t+1}$

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
