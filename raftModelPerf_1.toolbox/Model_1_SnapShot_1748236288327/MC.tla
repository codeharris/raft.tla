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
const_174823628530113000 == 
{v1, v2}
----

\* MV CONSTANT definitions Server
const_174823628530114000 == 
{r1, r2, r3, r4}
----

\* CONSTANT definitions @modelParameterConstants:3MaxTerm
const_174823628530115000 == 
2
----

\* CONSTANT definitions @modelParameterConstants:6MaxBecomeLeader
const_174823628530116000 == 
1
----

\* CONSTANT definitions @modelParameterConstants:13MaxClientRequests
const_174823628530117000 == 
2
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_174823628530118000 ==
MyConstraint
----
=============================================================================
\* Modification History
\* Created Mon May 26 07:11:25 CEST 2025 by crafters
