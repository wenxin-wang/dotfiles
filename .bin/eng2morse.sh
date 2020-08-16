#!/bin/bash

declare -A morse
morse=(
    [A]=".-" [B]="-..." [C]="-.-." [D]="-.." [E]="." [F]="..-." [G]="--."
    [H]="...." [I]=".." [J]=".---" [K]="-.-" [L]=".-.." [M]="--" [N]="-."
    [O]="---" [P]=".--." [Q]="--.-" [R]=".-." [S]="..." [T]="-" [U]="..-"
    [V]="...-" [W]=".--" [X]="-..-" [Y]="-.--" [Z]="--.."
    [0]="-----" [1]=".----" [2]="..---" [3]="...--" [4]="....-"
    [5]="....." [6]="-...." [7]="--..." [8]="---.." [9]="----."
    ['.']=".-.-.-" [',']="--..--" ['?']="..--.." ['`']=".----."
    ['!']="-.-.--" ['/']="-..-." ['(']="-.--." [')']="-.--.-"
    ['&']=".-..." [':']="---..." [';']="-.-.-." ['=']="-...-"
    ['+']=".-.-." ['-']="-....-" ['_']="..--.-" ['"']=".-..-."
    ['$']="...-..-" ['@']=".--.-."
)

if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    while IFS="" read -r -n 1 char; do
        printf "%s " ${morse[$char]:-"	"}
    done < <(printf %s "$1" | tr 'a-z' 'A-Z') # heredoc adds a newline
fi
