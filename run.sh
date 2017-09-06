#!/bin/bash

java -jar /opt/jenkins/slave.jar -jnlpUrl "$JENKINS_JNLP_URL" -secret "$JENKINS_SECRET"
