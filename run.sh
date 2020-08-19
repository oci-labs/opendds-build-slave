#!/bin/bash

set -x

env
java -version
java -cp /opt/jenkins/agent.jar hudson.remoting.jnlp.Main -headless -workDir "${JENKINS_AGENT_WORKDIR}" -direct "${DIRECT}" -protocols JNLP4-connect -instanceIdentity "${INSTANCE_IDENTITY}" "${JENKINS_SECRET}" "${JENKINS_NAME}"
