#!/bin/sh

#-- USAGE:
#--     %cd <to parent dir of .vee>
#--     %sh rebuild-vee-index.sh > new-index.html

#-- NOTE:
#--     NON-DESTRUCTIVE - does NOT modify or delete files;

#-- SYNOPSIS: 
#--     script to rebuild index based on .raw files in .vee/ created out of necessity, but
#--     provides a good example of how to do some indexed based stuff and read the basic
#--     formate in the .raw files

#-- BUGS:
#--     Please report them to Github - https://github.com/estrabd/vee/issues

#-- MORE INFO:
#--     http://www.0x743.com/.vee/1321369959.2011-11-15T09:12:39.html

#-- CREDITS:
#--     B. Estrade, created on 15 Nov. 2011

#-- LICENSE:
#--     DWTFYW

GENDATE=`date`
VEEDIR=./.vee
HTMLEXT=html

if [ ! -d "$VEEDIR" ]; then
    echo "Can't find $VEEDIR!"
    exit;
fi

echo "<!-- ;1000000000000000000000000; initial HTML -->"
echo "<!-- ;100000000000000000000000; more HTML -->"
echo "<!-- ;10000000000000000000000; new index regenerated on $GENDATE -->"

for f in `ls -1 $VEEDIR/*.raw | sort -t. -nr`; 
do
    # title is the 3rd line
    TITLE=`head -n 3 $f | tail -n 1`

    # full date string (not epoch) is the first line
    DATE=`head -n 1 $f`

    # deal with with timezone info in a brutish way (seems like a TZ mismatch in data input will cause error)
    TZ_SYS=`date "+%Z"`
    TZ_DATE=`echo $DATE | awk '{ print $5 }'`
    DATE=`echo $DATE | sed -e "s/$TZ_DATE/$TZ_SYS/"`

    # reformate date for indexing purposes (.raw files untouched)
    FORMATTED_DATE=`date -j -f "%a %b %d %T %Z %Y" "$DATE" "+%Y-%m-%d"` 

    # get epoch for purpose of adding reasonable post index numbers 
    EPOCH=`date -j -f "%a %b %d %T %Z %Y" "$DATE" "+%s"` 

    # extract base name of .raw file so we can link to html file of same base
    FILENAME=$(basename $f)
    BASENAME=${FILENAME%.*}
    # output HTML index (can be modified to output in whatever format)
    echo "<!-- ;$EPOCH; -->$FORMATTED_DATE <a href=$VEEDIR/$BASENAME.$HTMLEXT>$TITLE</a><br/>"
done

echo "<!-- ;2; closing -->"
echo '<!-- ;1; closing -->Powered by <a href="http://www.0x743.com/vee">vee</a>'
echo "<!-- ;0; closing -->"
