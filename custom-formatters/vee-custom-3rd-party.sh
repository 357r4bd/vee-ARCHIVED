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

# uses markdown, a markdown-to-html converter tool
 format_with_mardown() # e
{
    MARKDOWN=`which markdown`;
    if [ "$MARKDOWN" == "" ]; then
        echo markdown is not installed
        die_cleanly
    else
        cat ${RAW} | ${MARKDOWN} >> ${FINAL}
    fi
}

 custom_set_format_func()
{ case "$1" in
    par72) FORMAT_FUNC=format_with_par72
            ;;
    pandoc) FORMAT_FUNC=format_with_pandoc
            ;;
    markdown) FORMAT_FUNC=format_with_markdown
            ;;
    *) echo "$1 bad format type" 
       die_cleanly
       ;;
  esac 
}
