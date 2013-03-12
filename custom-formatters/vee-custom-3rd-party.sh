# Formatting options for 3rd party software

# use the "par" formatting utility, no HTML is generated so you rely on <pre> to encapsulate
 format_with_par72()
{ 
     PAR=`which par`;
     if [ "$PAR" == "" ]; then
       echo par is not installed
       die_cleanly
     else
       cat ${RAW} | ${PAR} -w 72 >> ${FINAL}
     fi
}

# uses pandoc, which has a lot of depenencies, but it an all-to-all converter
 format_with_pandoc() # example implements the same as -f none
{ 
     PANDOC=`which pandoc`;
     if [ "$PANDOC" == "" ]; then
       echo pandoc is not installed
       die_cleanly
     else
       cat ${RAW} | ${PANDOC} --from=markdown --to=html >> ${FINAL}
     fi
}

 custom_set_format_func()
{ case "$1" in
    par72) FORMAT_FUNC=format_with_par72
            ;;
    pandoc) FORMAT_FUNC=format_with_pandoc
            ;;
    *) echo "$1 bad format type" 
       die_cleanly
       ;;
  esac 
}
