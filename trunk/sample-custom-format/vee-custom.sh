#FORMAT_CUSTOM_DISPATCHER=custom_set_format_func
#FORMAT_CUSTOM_DEFS=./vee-custom.sh 

function format_with_null # example implements the same as -f none
{ cat ${RAW} >> ${FINAL}
}

function custom_set_format_func
{ case "$1" in
    null) FORMAT_FUNC=format_with_null
            echo using $FORMAT_FUNC
            ;;
    *) echo "bad format type" 
       die_cleanly
       ;;
  esac 
}
