# some more ls aliases
alias ll='ls -alh'
alias la='ls -Ah'
alias l='ls -CFh'

alias llld='ll -d .*'
alias lld='ls -d .*'

alias u='cd ..'
alias b='cd -'

cl() {
    cd $@ && ls
}

cll() {
    cd $@ && ll
}

mkcl() {
    mkdir $1 && cl $1
}

alias df='df -h'
alias cdl='cl ~/learn'
alias cds='cl ~/work/sophomore1'

alias gcc='gcc -W -Wall'
alias g++='g++ -W -Wall'
alias e='emacsclient -t -a emacs'

alias looplay='mplayer -loop 0'

csb() {
    rm cscope.{files,out}
    find $(pwd) -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' > cscope.files
    #cscope -i cscope.files -b
    cscope -b
}

alias panlatex="pandoc --template=$HOME/snippets/tex/pandoc.tex --latex-engine=xelatex -t latex"

mkd2latex() {
    panlatex -f markdown -o ${1%.*}.pdf $@
}

mkd2html() {
    pandoc -s -f markdown -t html --latexmathml -o ${1%.*}.html $@
}

mkd2reveal() {
    pandoc --template=/home/charlie/snippets/pandoc-templates/default.revealjs -t revealjs -o ${1%.*}.html $@
}

panrst2html() {
    if [[ $# -ne 1 ]]; then
        echo "need input name"
        return 1
    fi
    pandoc -s -f rst -t html -o ${1%.*}.html $1
}

alias mnt='udevil mount $@'
alias umnt='udevil umount $@'

datedir() {
    mkdir -p $(date +%F)
}

datefile() {
    local ext=$1
    shift
    touch $(date +%F)$@.$ext
}

alias newsmth="luit -encoding gbk ssh wwxwwx@newsmth.net"
alias newsmth-expect='expect -c "set timeout 60; spawn luit -encoding gbk ssh newsmth.net; interact timeout 30  {send \"\000\"}; "'
