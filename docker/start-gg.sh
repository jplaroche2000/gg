#!/bin/bash


# start manager

rptFile="${GG_HOME}/dirrpt/MGR.rpt"
prmFile="${GG_HOME}/dirprm/mgr.prm"
${GG_HOME}/mgr PARAMFILE ${prmFile} REPORTFILE ${rptFile} &>/dev/null &
sleep 5
echo "add extract test, exttrailsource /tmp/coherence-archive/trailfiles/ca" | ${GG_HOME}/ggsci
echo "start test" | ${GG_HOME}/ggsci
tail -f ggserr.log

