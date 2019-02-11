#!/usr/bin/env bash

version=v0.0.1a
command=$1

kube_path="${HOME}/.kube"

config_path="$kube_path/kswap"
kube_config_path="$kube_path/config"
subject_config="$kube_path/$command.yaml"

function help_msg {
    echo "kswap $version by Fernando Schuindt."
    cat <<"EOF"
https://github.com/fschuindt/kswap

License MIT 2019.
https://opensource.org/licenses/MIT

> Usage

Add all your DO K8s config files to the '~/.kube' path as .yaml files
(.yml won't work). Make sure you don't have anything important at the
'~/.kube/config' file, we'll use this file to store your current
config, so anything residing on it will be lost.

$ kswap
Will list all your available configs and point out the current one.
(If there's one).

$ kswap config-name
Changes the current K8s config to the chosen one.

$ kswap v
Displays kswap version.

$ kswap h
Displays this help message.

EOF
}

function touch_config {
    if [ ! -f $config_path ]; then
        echo "none" > $config_path
    fi
}

function present {
    config_name=$1
    current=$2

    if [ "$config_name" = "$current" ]; then
        echo -e "-> \e[93m$config_name\033[0m"
    else
        echo "- $config_name"
    fi
}

if [ "$command" = "h" ]; then
    help_msg
elif [ "$command" = "v" ]; then
    echo $version
elif [ -z "$command" ]; then
    touch_config
    current=$(<$config_path)

    configs="$(echo $kube_path/*.yaml)"
    config_list=(${configs// / })

    for config in "${config_list[@]}"
    do
        :
        config_name=$(basename $config .yaml)
        present $config_name $current
    done
else
    rm -f $config_path $kube_config_path
    cp $subject_config $kube_config_path
    echo $command > $config_path
    echo "Swapped to $command."
fi

