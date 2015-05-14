#!/bin/bash

TXTNAME="$1"
XMLNAME="screen-${TXTNAME//.txt}.xml"

cat << PREAMBLE > "$XMLNAME"
<?xml version="1.0" encoding="UTF-8"?>

<screen version="5.0"
         xsi:schemaLocation="http://docbook.org/ns/docbook http://www.docbook.org/xml/5.0/xsd/docbook.xsd"
         xmlns="http://docbook.org/ns/docbook"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:xs="http://www.w3.org/2001/XMLSchema"
         xmlns:ns="http://docbook.org/ns/docbook">
PREAMBLE

cat "${TXTNAME}" | sed \
  -e "s@/home/joakim/java/jvm@/lib/jvm@g" \
  -e "s@/home/joakim/code/.*/jetty-distribution/target/distribution@/opt/jetty-distribution@g" \
  -e "s@/home/joakim/code/.*/target/mybase@/home/jetty/mybase@g" \
  -e "s/9.3.0-SNAPSHOT/@project.version@/g" \
  -e "/jetty.tag.version = master/d" \
  -e "s/[<]/\&lt;/g" -e "s/[>]/\&gt;/g" \
  >> "${XMLNAME}"

echo "</screen>" >> "$XMLNAME"

echo "Created: $XMLNAME"

