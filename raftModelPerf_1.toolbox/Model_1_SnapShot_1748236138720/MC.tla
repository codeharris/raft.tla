---- MODULE MC ----
EXTENDS raftModelPerf, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
v1, v2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3, r4
----

\* MV CONSTANT definitions Value
const_17482360728852000 == 
{v1, v2}
----

\* MV CONSTANT definitions Server
const_17482360728853000 == 
{r1, r2, r3, r4}
----

\* CONSTANT definitions @modelParameterConstants:3MaxTerm
const_17482360728854000 == 
2
----

\* CONSTANT definitions @modelParameterConstants:6MaxBecomeLeader
const_17482360728855000 == 
1
----

\* CONSTANT definitions @modelParameterConstants:13MaxClientRequests
const_17482360728856000 == 
2
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_17482360728857000 ==
MyConstraint
----
=============================================================================
\* Modification History
\* Created Mon May 26 07:07:52 CEST 2025 by crafters
