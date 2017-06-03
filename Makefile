
.SECONDARY:

data/xyz/rm-0.0.xyz: data/gz/xyz/River-Mile-0.0.zip
data/xyz/rm-0.5.xyz: data/gz/xyz/River-Mile-0.5.zip

################################################################################
#	ARCHIVES
################################################################################
# http://www.mvn.usace.army.mil/Portals/56/docs/engineering/ChanStab/2013MBMR/River-Mile-0.0.zip
data/gz/xyz/%.zip:
	mkdir -p $(dir $@)
	curl -L --remote-time 'http://www.mvn.usace.army.mil/Portals/56/docs/engineering/ChanStab/2013MBMR/$(notdir $@)' -o $@.download
	mv $@.download $@


################################################################################
# SHAPEFILES: META
################################################################################
data/xyz/%.xyz:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar --exclude="._*" -xzm -C $(basename $@) -f $<

	for file in `find $(basename $@) -name '*.xyz'`; do \
		ogr2ogr -dim 2 -f 'ESRI Shapefile' -t_srs 'EPSG:4326' $(basename $@).$${file##*.} $$file; \
		chmod 644 $(basename $@).$${file##*.}; \
	done

	rm -rf $(basename $@)
