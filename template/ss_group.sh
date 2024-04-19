#!/bin/bash
unset -v group_name

USAGE="Usage: $(basename $0) [-n name]"

while getopts 'n:' OPTION; do
    case "$OPTION" in
        n)
            group_name=$OPTARG
            ;;
        ?)
            echo $USAGE
            exit 1
            ;;
    esac
done

if [ -z "$group_name" ]; then
        echo -e "Missing -n\n$USAGE" >&2
        exit 1
fi

if [ -d "model/software_systems_group/$group_name" ]; then
    echo -e "Group ${group_name} already exists\n " >&2
    exit 1
fi

mkdir -p model/software_system_group/$group_name
mkdir model/software_system_group/$group_name/software_system
touch model/software_system_group/$group_name/software_system/.keep
mkdir model/software_system_group/$group_name/rel
touch model/software_system_group/$group_name/rel/.keep

echo "group_$group_name = group "$group_name" {
	!include software_system_group/$group_name/software_system
}
" >> model/software_system_group.dsl

echo "!include software_system_group/${group_name}/rel" >> model/relationship.dsl