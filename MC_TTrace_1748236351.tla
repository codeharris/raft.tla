---- MODULE MC_TTrace_1748236351 ----
EXTENDS Sequences, TLCExt, MC, Toolbox, Naturals, TLC

_expression ==
    LET MC_TEExpression == INSTANCE MC_TEExpression
    IN MC_TEExpression!expression
----

_trace ==
    LET MC_TETrace == INSTANCE MC_TETrace
    IN MC_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        votedFor = ((r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2))
        /\
        log = ((r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r4 :> <<[term |-> 2, value |-> v1, payload |-> v1]>>))
        /\
        voterLog = ((r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>))
        /\
        nextIndex = ((r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)))
        /\
        Servers = ({r2, r3, r4})
        /\
        switchIndex = (r1)
        /\
        maxc = (2)
        /\
        switchBuffer = ((v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]))
        /\
        currentTerm = ((r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2))
        /\
        entryCommitStats = ((<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]))
        /\
        votesResponded = ((r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}))
        /\
        votesGranted = ((r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}))
        /\
        messages = (([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 2] :> 1 @@ [mdest |-> r2, msource |-> r4, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 1 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 0 @@ [mdest |-> r4, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 1] :> 0))
        /\
        matchIndex = ((r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)))
        /\
        switchSentRecord = ((r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}))
        /\
        state = ((r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower))
        /\
        leaderCount = ((r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0))
        /\
        unorderedRequest = ((r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}))
        /\
        commitIndex = ((r1 :> 0 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1))
    )
----

_init ==
    /\ unorderedRequest = _TETrace[1].unorderedRequest
    /\ messages = _TETrace[1].messages
    /\ matchIndex = _TETrace[1].matchIndex
    /\ log = _TETrace[1].log
    /\ switchSentRecord = _TETrace[1].switchSentRecord
    /\ state = _TETrace[1].state
    /\ Servers = _TETrace[1].Servers
    /\ leaderCount = _TETrace[1].leaderCount
    /\ entryCommitStats = _TETrace[1].entryCommitStats
    /\ commitIndex = _TETrace[1].commitIndex
    /\ currentTerm = _TETrace[1].currentTerm
    /\ votesResponded = _TETrace[1].votesResponded
    /\ switchIndex = _TETrace[1].switchIndex
    /\ maxc = _TETrace[1].maxc
    /\ nextIndex = _TETrace[1].nextIndex
    /\ votesGranted = _TETrace[1].votesGranted
    /\ switchBuffer = _TETrace[1].switchBuffer
    /\ voterLog = _TETrace[1].voterLog
    /\ votedFor = _TETrace[1].votedFor
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ unorderedRequest  = _TETrace[i].unorderedRequest
        /\ unorderedRequest' = _TETrace[j].unorderedRequest
        /\ messages  = _TETrace[i].messages
        /\ messages' = _TETrace[j].messages
        /\ matchIndex  = _TETrace[i].matchIndex
        /\ matchIndex' = _TETrace[j].matchIndex
        /\ log  = _TETrace[i].log
        /\ log' = _TETrace[j].log
        /\ switchSentRecord  = _TETrace[i].switchSentRecord
        /\ switchSentRecord' = _TETrace[j].switchSentRecord
        /\ state  = _TETrace[i].state
        /\ state' = _TETrace[j].state
        /\ Servers  = _TETrace[i].Servers
        /\ Servers' = _TETrace[j].Servers
        /\ leaderCount  = _TETrace[i].leaderCount
        /\ leaderCount' = _TETrace[j].leaderCount
        /\ entryCommitStats  = _TETrace[i].entryCommitStats
        /\ entryCommitStats' = _TETrace[j].entryCommitStats
        /\ commitIndex  = _TETrace[i].commitIndex
        /\ commitIndex' = _TETrace[j].commitIndex
        /\ currentTerm  = _TETrace[i].currentTerm
        /\ currentTerm' = _TETrace[j].currentTerm
        /\ votesResponded  = _TETrace[i].votesResponded
        /\ votesResponded' = _TETrace[j].votesResponded
        /\ switchIndex  = _TETrace[i].switchIndex
        /\ switchIndex' = _TETrace[j].switchIndex
        /\ maxc  = _TETrace[i].maxc
        /\ maxc' = _TETrace[j].maxc
        /\ nextIndex  = _TETrace[i].nextIndex
        /\ nextIndex' = _TETrace[j].nextIndex
        /\ votesGranted  = _TETrace[i].votesGranted
        /\ votesGranted' = _TETrace[j].votesGranted
        /\ switchBuffer  = _TETrace[i].switchBuffer
        /\ switchBuffer' = _TETrace[j].switchBuffer
        /\ voterLog  = _TETrace[i].voterLog
        /\ voterLog' = _TETrace[j].voterLog
        /\ votedFor  = _TETrace[i].votedFor
        /\ votedFor' = _TETrace[j].votedFor

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("MC_TTrace_1748236351.json", _TETrace)

=============================================================================

 Note that you can extract this module `MC_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `MC_TEExpression.tla` file takes precedence 
  over the module `MC_TEExpression` below).

---- MODULE MC_TEExpression ----
EXTENDS Sequences, TLCExt, MC, Toolbox, Naturals, TLC

expression == 
    [
        \* To hide variables of the `MC` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        unorderedRequest |-> unorderedRequest
        ,messages |-> messages
        ,matchIndex |-> matchIndex
        ,log |-> log
        ,switchSentRecord |-> switchSentRecord
        ,state |-> state
        ,Servers |-> Servers
        ,leaderCount |-> leaderCount
        ,entryCommitStats |-> entryCommitStats
        ,commitIndex |-> commitIndex
        ,currentTerm |-> currentTerm
        ,votesResponded |-> votesResponded
        ,switchIndex |-> switchIndex
        ,maxc |-> maxc
        ,nextIndex |-> nextIndex
        ,votesGranted |-> votesGranted
        ,switchBuffer |-> switchBuffer
        ,voterLog |-> voterLog
        ,votedFor |-> votedFor
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_unorderedRequestUnchanged |-> unorderedRequest = unorderedRequest'
        
        \* Format the `unorderedRequest` variable as Json value.
        \* ,_unorderedRequestJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(unorderedRequest)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_unorderedRequestModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].unorderedRequest # _TETrace[s-1].unorderedRequest
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE MC_TETrace ----
\*EXTENDS IOUtils, MC, TLC
\*
\*trace == IODeserialize("MC_TTrace_1748236351.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE MC_TETrace ----
EXTENDS MC, TLC

trace == 
    <<
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 0,switchBuffer |-> <<>>,currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 1,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>} @@ r3 :> {} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {v1} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {v1, v2} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {v1, v2} @@ r3 :> {v1} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {v1, v2} @@ r3 :> {v1, v2} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> <<>>,votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {v1, v2} @@ r3 :> {v1, v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {v2} @@ r3 :> {v1, v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> <<>>,matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v1, v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v1, v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 1 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 0, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 1 @@ [mdest |-> r4, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 1] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {v2} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 1 @@ [mdest |-> r4, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 1] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r4 :> <<>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 2] :> 1 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 0 @@ [mdest |-> r4, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 1] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {v1}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r4 :> <<[term |-> 2, value |-> v1, payload |-> v1]>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 2] :> 1 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 0 @@ [mdest |-> r4, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 1] :> 1),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 0)]),
    ([votedFor |-> (r1 :> r2 @@ r2 :> Nil @@ r3 :> r2 @@ r4 :> r2),log |-> (r1 :> <<>> @@ r2 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r3 :> <<[term |-> 2, value |-> v1, payload |-> v1], [term |-> 2, value |-> v2, payload |-> v2]>> @@ r4 :> <<[term |-> 2, value |-> v1, payload |-> v1]>>),voterLog |-> (r1 :> <<>> @@ r2 :> (r3 :> <<>> @@ r4 :> <<>>) @@ r3 :> <<>> @@ r4 :> <<>>),nextIndex |-> (r1 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r2 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 2 @@ r4 :> 1) @@ r3 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1) @@ r4 :> (r1 :> 1 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)),Servers |-> {r2, r3, r4},switchIndex |-> r1,maxc |-> 2,switchBuffer |-> (v1 :> [term |-> 2, value |-> v1, payload |-> v1] @@ v2 :> [term |-> 2, value |-> v2, payload |-> v2]),currentTerm |-> (r1 :> 2 @@ r2 :> 2 @@ r3 :> 2 @@ r4 :> 2),entryCommitStats |-> (<<1, 2>> :> [committed |-> TRUE, sentCount |-> 1, ackCount |-> 1] @@ <<2, 2>> :> [committed |-> FALSE, sentCount |-> 1, ackCount |-> 0]),votesResponded |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),votesGranted |-> (r1 :> {} @@ r2 :> {r3, r4} @@ r3 :> {} @@ r4 :> {}),messages |-> ([mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 0 @@ [mdest |-> r2, msource |-> r3, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 2] :> 1 @@ [mdest |-> r2, msource |-> r4, mtype |-> AppendEntriesResponse, mterm |-> 2, msuccess |-> TRUE, mmatchIndex |-> 1] :> 1 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 0] :> 0 @@ [mdest |-> r3, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 1, mprevLogTerm |-> 2, mentries |-> <<[term |-> 2, value |-> v2]>>, mcommitIndex |-> 1] :> 0 @@ [mdest |-> r4, msource |-> r2, mtype |-> AppendEntriesRequest, mterm |-> 2, mprevLogIndex |-> 0, mprevLogTerm |-> 0, mentries |-> <<[term |-> 2, value |-> v1]>>, mcommitIndex |-> 1] :> 0),matchIndex |-> (r1 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r2 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 1 @@ r4 :> 0) @@ r3 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0) @@ r4 :> (r1 :> 0 @@ r2 :> 0 @@ r3 :> 0 @@ r4 :> 0)),switchSentRecord |-> (r1 :> {} @@ r2 :> {<<v1, 2>>, <<v2, 2>>} @@ r3 :> {<<v1, 2>>, <<v2, 2>>} @@ r4 :> {<<v1, 2>>}),state |-> (r1 :> Switch @@ r2 :> Leader @@ r3 :> Follower @@ r4 :> Follower),leaderCount |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 0 @@ r4 :> 0),unorderedRequest |-> (r1 :> {} @@ r2 :> {} @@ r3 :> {} @@ r4 :> {}),commitIndex |-> (r1 :> 0 @@ r2 :> 1 @@ r3 :> 1 @@ r4 :> 1)])
    >>
----


=============================================================================

---- CONFIG MC_TTrace_1748236351 ----
CONSTANTS
    v1 = v1
    v2 = v2
    r1 = r1
    r2 = r2
    r3 = r3
    r4 = r4
    AppendEntriesResponse = AppendEntriesResponse
    Follower = Follower
    Leader = Leader
    Nil = Nil
    RequestVoteResponse = RequestVoteResponse
    Candidate = Candidate
    Switch = Switch
    RequestVoteRequest = RequestVoteRequest
    AppendEntriesRequest = AppendEntriesRequest
    Value <- const_174823628530113000
    Server <- const_174823628530114000
    MaxTerm <- const_174823628530115000
    MaxBecomeLeader <- const_174823628530116000
    MaxClientRequests <- const_174823628530117000
    Follower = Follower
    r1 = r1
    v2 = v2
    Leader = Leader
    RequestVoteResponse = RequestVoteResponse
    v1 = v1
    Nil = Nil
    AppendEntriesResponse = AppendEntriesResponse
    Candidate = Candidate
    Switch = Switch
    r4 = r4
    r2 = r2
    AppendEntriesRequest = AppendEntriesRequest
    RequestVoteRequest = RequestVoteRequest
    r3 = r3

INVARIANT
    _inv

CHECK_DEADLOCK
    \* CHECK_DEADLOCK off because of PROPERTY or INVARIANT above.
    FALSE

INIT
    _init

NEXT
    _next

CONSTANT
    _TETrace <- _trace

ALIAS
    _expression
=============================================================================
\* Generated on Mon May 26 07:12:34 CEST 2025