#!/bin/bash
unset -v proj
unset -v ss
unset -v bn

BRANCH_NAME=$(git branch --show-current)

USAGE="Usage: $(basename $0) [-s s_software_system] [-b branch_name] [-p bussines_name]"

while getopts 'p:s:' OPTION; do
    case "$OPTION" in
        p)
            proj=$OPTARG
            ;;
        s)
            ss=$OPTARG
            ;;
        b)
            bn=$OPTARG
            ;;
        ?)
            echo $USAGE
            exit 1
            ;;
    esac
done

if [ -z "$ss" ]; then
        echo -e "Missing -s\n$USAGE" >&2
        exit 1
fi

TASK_NAME_FROM_BRANCH=$(echo $BRANCH_NAME | sed -r 's/_.*$//')
BC_FROM_BRANCH=$(echo $BRANCH_NAME | sed -r 's/^\w+\-\d+_?//')

MAIN_REPO_BRANCH="master"

project_name=$BRANCH_NAME
need_create_branch=false

if [ ! -z "$bn" ] && [ "$TASK_NAME_FROM_BRANCH" != "$bn" ]; then
    project_name=${bn}
    if [ ! -z "$proj" ]; then
        project_name = ${project_name}_${proj}
    fi
    need_create_branch=true
    git checkout  $MAIN_REPO_BRANCH
    git pull origin $MAIN_REPO_BRANCH
else 
    bn=$TASK_NAME_FROM_BRANCH
    if [ ! -z "$BC_FROM_BRANCH" ] && [ ! -z "$proj" ] && [ "$BC_FROM_BRANCH" != "$proj" ]; then
        echo -e "Branch name does not match project name\n " >&2
        exit 1
    fi
fi

if [ -d "views/PROJ/$project_name" ]; then
    echo -e "Project ${project_name} already exists\n " >&2
    exit 1
fi

if [ "$need_create_branch" == true ]; then
    git checkout -b $project_name
fi

mkdir -p views/PROJ/$project_name;
mkdir views/PROJ/$project_name/.sequences;
touch views/PROJ/$project_name/.sequences/.keep;
sed 's/%PROJ%/'$bn'/; s/%SYSTEM%/'$ss'/' template/proj.tmpl > views/PROJ/$project_name/$bn.dsl
