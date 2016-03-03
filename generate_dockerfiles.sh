#!/bin/bash

set -o pipefail -e

TEMPLATE="Dockerfile.tpl"

JVM_VERSIONS=( 7 8 )
TOMCAT_VERSIONS=( 7.0.68 8.0.32 )

for JVM_VERSION in ${JVM_VERSIONS[@]}; do
  for TOMCAT_VERSION in ${TOMCAT_VERSIONS[@]}; do
    TOMCAT_MAJOR=$(echo $TOMCAT_VERSION | cut -d. -f1)

    echo -en "Generating Dockerfile for Tomcat ${TOMCAT_VERSION} using Java JRE ${JVM_VERSION}..."
    sed "s|%JVM_VERSION%|$JVM_VERSION|g;s|%TOMCAT_VERSION%|$TOMCAT_VERSION|g;s|%TOMCAT_MAJOR%|$TOMCAT_MAJOR|g" $TEMPLATE > tomcat${TOMCAT_MAJOR}/Dockerfile.JRE${JVM_VERSION} && \
      echo "done" || \
      echo "failed"
  done
done
