#!/usr/bin/env zsh

: ${__prompt_primary_color:=cyan}
: ${__prompt_secondary_color:=magenta}
: ${__prompt_error_color:=red}

setopt PROMPT_SUBST

TRAPWINCH() {
    if zle; then
        PROMPT=$(prompt)
        zle reset-prompt
    fi
}

function prompt() {
    local last_status=$?

    local current_dir="${PWD/#$HOME/~}"

    local venv_info=""
    local stripped_venv=""
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name="${VIRTUAL_ENV:t}"
        if [[ "$venv_name" == ".venv" ]]; then
            venv_name="${VIRTUAL_ENV:h:t}/.venv"
        fi
        venv_info="(${venv_name}) "
        stripped_venv="(${venv_name}) "
    fi

    local prefix="${venv_info}%F{$__prompt_secondary_color}[${current_dir}]%f"
    local stripped_prefix="${stripped_venv}[${current_dir}]"
    
    local prompt_char='$ '
    if [ $last_status -eq 0 ]; then
        local trailer="${prompt_char}"
    else
        local trailer="%F{$__prompt_error_color}${prompt_char}%f"
    fi
    
    local suffix="%F{$__prompt_primary_color}%n@%m${trailer}%f"
    local stripped_suffix="%n@%m${prompt_char}"
    
    local full_prompt="${prefix} ${suffix}"
    local full_stripped_prompt="${stripped_prefix} ${stripped_suffix}"
    
    local expanded_stripped="${(%)full_stripped_prompt}"
    local prompt_length=${#expanded_stripped}
    local cols=${COLUMNS:-$(tput cols)}
    local wrap_threshold=$(( cols * 5 / 8 ))
    
    if [ "$prompt_length" -gt "$wrap_threshold" ]; then
        echo "${prefix}"
        echo -n "${suffix}"
    else
        echo -n "${full_prompt}"
    fi
}

precmd() {
    PROMPT=$(prompt)
}
