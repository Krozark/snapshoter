#!/bin/bash
while [[ $# > 1 ]]
do
key="$1"
shift

case $key in
    -t|--timeout)
    TIMEOUT="$1"
    shift
    ;;
    -p|--pid)
    PID="$1"
    shift
    ;;
    -l|--limit)
    LIMIT="$1"
    shift
    ;;
    -h|--help)
        echo "usage is -t/--timeout <timeout> -p/--pid <pid> -l/--limit <limit> -h/--help"
    shift
    ;;
    *)
        # unknown option
    ;;
esac
done

if [[ -z $PID ]]; then
    echo "No pid specify"
    exit
fi
echo pid     = "${PID}"

if [[ -z $TIMEOUT ]]; then
    TIMEOUT=60
fi
echo timeout  = "${TIMEOUT}"

if [[ -z $LIMIT ]]; then
    LIMIT=10
fi
echo limit    = "${LIMIT}"


save(){
    rm -rf "$1"
    mkdir -p "$1"
    cd $1
    echo "save pid $2 in repertory $1"
    echo `date` >> save.date
    criu dump -t $2 --shell-job -s
    kill -CONT $2
    cd ..
}

i=0
while true
do
    save $i $PID
    sleep $TIMEOUT
    i=`expr $i + 1`
    if test $i -gt $LIMIT;then
        i=0
    fi
done

