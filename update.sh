#!/bin/bash
# download current post box data from osm and process into georss

for a in eiir eviiir eviir gr gvir vr scottish_crown no bad blank
do
	wget -nv -O $a.osm --post-file=$a.query http://overpass-api.de/api/interpreter
	xmlstarlet tr osm2georss.xslt $a.osm > $a.georss.xml
	echo sleeping to be nice to the api
	sleep 5
done


