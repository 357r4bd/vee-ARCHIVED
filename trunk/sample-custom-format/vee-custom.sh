#FORMAT_CUSTOM_DISPATCHER=custom_set_format_func
#FORMAT_CUSTOM_DEFS=./vee-custom.sh 

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
