#!/bin/bash
unset -v group_name

USAGE="Usage: $(basename $0) [-n company_name]"

while getopts 'n:' OPTION; do
    case "$OPTION" in
        n)
            name=$OPTARG
            ;;
        ?)
            echo $USAGE
            exit 1
            ;;
    esac
done

if [ -z "$name" ]; then
        echo -e "Missing -n\n$USAGE" >&2
        exit 1
fi

if [ -f "workspace.dsl" ]; then
    echo -e "Workspace already exists\n " >&2
    exit 1
fi

sed 's/%Company%/'$name'/g' template/workspace.tmpl > workspace.dsl

mkdir -p views/PROJ
touch views/PROJ/.keep
touch views/container.dsl
touch views/system_context.dsl
cp template/system_landscape.tmpl views/system_landscape.dsl
mkdir -p model/person/rel
cp template/person.tmpl model/person.dsl
touch model/software_system_group.dsl
echo "!include person/rel" > model/relationship.dsl
touch model/person/rel/p_b2b_customer_rel.dsl
touch model/person/rel/p_b2b_staff_rel.dsl
touch model/person/rel/p_b2c_customer_rel.dsl
touch model/person/rel/p_other_rel.dsl
touch model/person/rel/p_our_staff_rel.dsl
mkdir adrs

DATE=$(date +%Y-%m-%d)

sed 's/%START_DATE%/'$DATE'/' template/0001-record-architecture-solutions.tmpl > adrs/0001-record-architecture-solutions.md