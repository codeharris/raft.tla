---- MODULE MC ----
EXTENDS raftModelPerf_1_0247338943, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
v1, v2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3, r4
----

\* MV CONSTANT definitions Value
const_174823799418924000 == 
{v1, v2}
----

\* MV CONSTANT definitions Server
const_174823799418925000 == 
{r1, r2, r3, r4}
----

\* CONSTANT definitions @modelParameterConstants:3MaxTerm
const_174823799418926000 == 
2
----

\* CONSTANT definitions @modelParameterConstants:6MaxBecomeLeader
const_174823799418927000 == 
1
----

\* CONSTANT definitions @modelParameterConstants:13MaxClientRequests
const_174823799418928000 == 
2
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_174823799418929000 ==
MyConstraint
----
=============================================================================
\* Modification History
\* Created Mon May 26 07:39:54 CEST 2025 by crafters
