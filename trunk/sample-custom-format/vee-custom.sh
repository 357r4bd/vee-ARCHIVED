#FORMAT_CUSTOM_DISPATCHER=custom_set_format_func
#FORMAT_CUSTOM_DEFS=./vee-custom.sh 
function format_with_custom
{
 echo hello
 die_cleanly
}

function custom_set_format_func
{ case "$1" in
    custom) FORMAT_FUNC=format_with_custom
            echo using $FORMAT_FUNC
            ;;
    *) echo "bad format type" 
       die_cleanly
       ;;
  esac 
}
