# README for the workflows
## Workflow 01: Power Amplifier (PA) Linearization via Genetic Algorithm and DPD
### Project Overview
This project aims to compensate for the non-linearities and memory effects of an RF Power Amplifier (PA) operating in the saturation region. To achieve this, a Digital Pre-Distorter (DPD) ws designed using a polynomial behavioral model with memory (NARX/Volterra), whose inverse coefficients are optimized through a *Genetic Algorithm (GA)*.

### Phase 01: Understanding the Physical Model (The Plant)
The starting point was the analysis of a set of mathematical coefficients that describe the PA's behavior:

- *Intercepts (Bias)*