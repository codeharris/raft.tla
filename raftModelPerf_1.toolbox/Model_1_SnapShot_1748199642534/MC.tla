---- MODULE MC ----
EXTENDS raftModelPerf, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
v1, v2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3, r4, r5
----

\* MV CONSTANT definitions Value
const_174819957382135000 == 
{v1, v2}
----

\* MV CONSTANT definitions Server
const_174819957382136000 == 
{r1, r2, r3, r4, r5}
----

\* CONSTANT definitions @modelParameterConstants:3MaxTerm
const_174819957382137000 == 
2
----

\* CONSTANT definitions @modelParameterConstants:6MaxBecomeLeader
const_174819957382138000 == 
1
----

\* CONSTANT definitions @modelParameterConstants:13MaxClientRequests
const_174819957382139000 == 
2
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_174819957382240000 ==
MyConstraint
----
=============================================================================
\* Modification History
\* Created Sun May 25 20:59:33 CEST 2025 by crafters
