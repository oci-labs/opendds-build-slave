#!/bin/bash

java -jar /opt/jenkins/slave.jar -jnlpUrl "${JENKINS_URL}computer/${JENKINS_NAME}/slave-agent.jnlp" -secret "$JENKINS_SECRET"
