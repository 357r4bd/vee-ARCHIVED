# this vee-custom.sh provides a formatting function for 'par'

 format_with_par72() # example implements the same as -f none
{ 
     PAR=`which par`;
     if [ "$PAR" == "" ]; then
       echo par is not installed
       die_cleanly
     else
       cat ${RAW} | ${PAR} -w 72 >> ${FINAL}
     fi
}

 custom_set_format_func()
{ case "$1" in
    par72) FORMAT_FUNC=format_with_par72
            ;;
    *) echo "$1 bad format type" 
       die_cleanly
       ;;
  esac 
}
