#Configure conf/hive-site.xml
#<configuration>
#    <property>
#	    <name>hive.metastore.schema.verification</name>
#		<value>false</value>
#    </property>
#    <property>
#	    <name>datanucleus.schema.autoCreateAll</name>
#		<value>true</value>
#    </property>
#</configuration>

./bin/hive --service metastore
