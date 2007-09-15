#FORMAT_CUSTOM_DISPATCHER=custom_set_format_func
#FORMAT_CUSTOM_DEFS=./vee-custom.sh 
#UPDATE_INDEX=custom_update_index
#OUTPUT_TOP=custom_output_top
#OUTPUT_BOT=custom_output_bottom

function format_with_null # example implements the same as -f none
{ cat ${RAW} >> ${FINAL}
}

function format_with_groff_utf8
{ #sed 1liner from http://sed.sourceforge.net/sed1line.txt
  exe=`which groff-utf8 2> /dev/null || echo -1`
  if [ "-1" != ${exe} ]; then
    groff-utf8 -man -Tutf8 ${RAW} >> bla.raw
    sed '/^$/N;/\n$/D' bla.raw >> ${FINAL}
    rm bla.raw
  else
    echo "Warning: groff-utf8 not found, falling back to format_with_groff"
    format_with_groff
  fi
}

function custom_set_format_func
{ case "$1" in
    null) FORMAT_FUNC=format_with_null
            echo using $FORMAT_FUNC
            ;;
    groff-utf8)FORMAT_FUNC=format_with_groff_utf8
             echo using $FORMAT_FUNC
             ;;
    *) echo "bad format type" 
       die_cleanly
       ;;
  esac 
}

# formats post link on index page
function custom_update_index
{ echo "<!-- ;${SEC}; -->${PUBLISHED}:<a href=\"${DIR}/${SEC}.${TIME}.${FORMAT}\"> ${TITLE}</a>" >> ${INDEX}
  if [ -n "${SUMMARY}" ]; then
    SEC=`expr $SEC - 1`
    echo "<!-- ;${SEC}; -->${SUMMARY}" >> ${INDEX}
  fi
}

function custom_output_top
{ echo ${HEADERTXT} > ${FINAL}
  if [ -e "${TOP_TPL}" ]; then
     cat "${TOP_TPL}" >> ${FINAL}
     echo "<pre>"   >> ${FINAL}
   else
     echo "<!-- <?xml version=\"1.0\" encoding=\"UTF-8\" ?> --><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\">"  >> ${FINAL}
     echo "<meta http-equiv=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">" >> ${FINAL}
     echo "<head><title>${TITLE} - ${DATE}</title></head>"  >> ${FINAL}
     echo "<body>"  >> ${FINAL}
     echo "<pre>"   >> ${FINAL}
     echo "<a href=\"../${INDEX}\">[index]</a><a href=\"./${RAWNAME}\">[raw]</a><a href=\"../\">[main]</a>" >> ${FINAL}
   fi
   echo           >> ${FINAL}
}

function custom_output_bottom
{ echo          >> ${FINAL}
  echo --       >> ${FINAL}
  echo ${FOOTERTXT} >> ${FINAL}
  if [ -e "${BOT_TPL}" ]; then
    cat "${BOT_TPL}" >> ${FINAL}
  else
    echo "</pre>" >>  ${FINAL}
    echo "</body>" >>  ${FINAL}
    echo "</html>" >>  ${FINAL}
  fi
}

