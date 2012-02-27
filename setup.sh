#!/bin/sh
BASE_DIR=.
wget http://apache.mirrors.timporter.net/lucene/solr/3.5.0/apache-solr-3.5.0-src.tgz 
tar zxvf apache-solr-3.5.0-src.tgz 
gem install rsolr

echo "modify field definitions to make movie class attributes"
echo "<field name="id" type="string" indexed="true" stored="true" required="true" />"
echo "<field name="title" type="text_general" indexed="true" stored="true"/>"
echo "<field name="actor" type="text_general" indexed="true" stored="true" multiValued="true"/>"
echo "<field name="summary" type="text_general" indexed="false" stored="true"/>"


gvim apache-solr-3.5.0/solr/example/solr/conf/schema.xml

java -jar apache-solr-3.5.0/example/start.jar &


