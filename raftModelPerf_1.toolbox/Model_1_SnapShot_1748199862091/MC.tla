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
const_174819968433057000 == 
{v1, v2}
----

\* MV CONSTANT definitions Server
const_174819968433058000 == 
{r1, r2, r3, r4}
----

\* CONSTANT definitions @modelParameterConstants:3MaxTerm
const_174819968433059000 == 
2
----

\* CONSTANT definitions @modelParameterConstants:6MaxBecomeLeader
const_174819968433060000 == 
1
----

\* CONSTANT definitions @modelParameterConstants:13MaxClientRequests
const_174819968433061000 == 
2
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_174819968433062000 ==
MyConstraint
----
=============================================================================
\* Modification History
\* Created Sun May 25 21:01:24 CEST 2025 by crafters
