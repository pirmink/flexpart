#!/bin/bash

# Settings
# --------
# Path to flexplot installation
         flexplot=/users/kaufmann/src/oprtools/dispersion/bin/flexplot-ifs
dispers_resources=/users/kaufmann/src/oprtools/dispersion/resources

# Option for debugging
#debug_opt=--debug

# Domains (see ls $dispers_resources/cities_*.txt for available domains)
domains=( envelope ) # zoom )

# Levels/fields to plot
fieldlevels=( CONC ) # CONC_1 ) # DEPO )

# Formats (ps, gif, png)
formats=( ps )

# Size of image for GIF or PNG files
img_size='--xsize=1024 --ysize=728'
# --------

# Check file availability
if ! [ -x $flexplot ] ; then
    echo Executable not found: $flexplot
    exit 1
fi
if ! [ -d $dispers_resources ] ; then
    echo Resource directory not found: $dispers_resources
    exit 1
fi

# Postscript
# only lowest level and deposition
for domain in ${domains[*]} ; do
    for format in ${formats[*]} ; do

	case $format in
	    ps)
		for select in ${fieldlevels[*]} ; do
		    set -x
		    $flexplot --domain=$domain $debug_opt \
			--cities=$dispers_resources --select=$select
		    set +x
		done
		;;

	    gif | png)
		$flexplot --domain=$domain $debug_opt \
		    --format=$format $img_size \
		    --cities=$dispers_resources
		#   --cantons==$dispers_resources/kantonsgrenzen_wgs1984.shx
		;;
	esac
    done
done

exit
