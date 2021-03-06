function gas() {
    git add . && git commit -m "sync"
}

function less_newest() {
    less `ls -tr|tail -n 1`
}

function ws() {
    winxed setup.winxed $@
}

function dance() {
    perl bin/app.pl $@
}
function resize_images() {
    [ -z "$1" ] && echo "Usage: resize_images 50% # resize all images in \$PWD by 50%" && return
    for i in *; do convert -resize $1 "$i" "$i"; done
}
function perl_installed() {
    perl -MExtUtils::Installed -E 'say for ExtUtils::Installed->new->modules'
}
function git_smallerize() {
    for i in *; do pushd $i; git gc; popd; done
}

function smart_shuttle() {
    $HOME/git/sshuttle/sshuttle --dns -vvr $@ 0/0
}

function new_git_io() {
    [ -z "$1" ] && echo "new_git_io org/project/other urlslug" && return
    [ -z "$2" ] && echo "new_git_io org/project/other urlslug" && return
    curl -i http://git.io -F "url=https://github.com/$1" -F "code=$2"
}
function sagi() {
    sudo apt-get install $@
}

function forever() {
    while true; do $@ ;done
}

function fog() {
   # push to origin and deploy to PHPfog
   git push origin
   git push phpfog $@
}

function r() {
    [ -z "$1" ] && rvm use 1.9.3 && return
    rvm use $1
}

function hexless(){
    hexdump -C $1 |less -R
}
function tmpify() {
    scp -P 4242 $@ leto@leto.net:~/public_html/tmp/
}

function screenssh () {
    ssh -xtA $@ "\$HOME/bin/screen -D -R"
}

function git-spread () {
    git push origin $1; git push github $1
}
function dl () {
    colordiff -u $1 $2 |less -R
}

function recursive_replace () {
    [ -z "$1" ] && echo "Must search for something!" && return
    grep -R -l "$1" . | sort | uniq | xargs perl -pi -e "s/$1/$2/"
}

largest () {
    du $1 |sort -rn |head
}

k9 () {
    # this kills the most recent process if given no argument, be careful!
    kill -9 %$1
}
mount_iso () {
	mdconfig -a -t vnode -f $1 -u 1
	mount -t cd9660 /dev/md1 /mnt/iso
}
umount_iso() {
	mount -u $1
	mdconfig -d -u 1
}

# by Aaron "H-Bomb" Harsh
..to () {
   cd `pwd | perl -pe "s[(.*/[^/]*$1[^/]*/).*][\\1/]"`
}

### testing aliases
function bt () {
    perl Build.PL && 
    ./Build test --verbose 1 --test_files $1 |colortest
}
function t () {
    prove -blrv $@ | colortest
#    ./Build test --verbose 1 --test_files $@ |colortest
}
function modversion () {
    perl -M$1 -le "print $1->VERSION"
}

function grh () {
    git rebase -i head~$1
}

alias vag="vagrant"

function revagrant () {
	vagrant destroy -f $1 && vagrant up $1
}

alias convert_to_utf8="perl -MEncode -ne 'print encode_utf8(encode_utf8(eval { decode_utf8(\$_) } || decode(q{cp-1252}, \$_)))'"

alias tapir="parrot t/harness.pir t/*.t"
alias pg="psql85"
alias pp0="patch -p0"
alias pp1="patch -p1"
alias new_plumage="make realclean; parrot_nqp Configure.nqp; make"
alias test_new_plumage="new_plumage && make test"
alias nqp=~/git/nqp-rx/parrot_install/bin/nqp
alias smolder_parrot="sup && new_parrot && make smolder_test"
alias smolder_parrot_optimize="sup && new_parrot_optimize && make smolder_test"
alias new_rakudo="git fetch --all; git rebase origin/master ; perl Configure.pl --gen-parrot; make install"

alias plv="prove -lrv"
alias cg='valgrind --dsymutil=yes --dump-instr=yes --trace-jump=yes'
alias rot13="perl -pe 'y/a-zA-Z/n-za-mN-ZA-M/'"

###### git aliases

#eval "$(hub alias -s)"
alias g=git
alias gp="git push"
alias vgc="vi .git/config"

function sha1 () {
    [ -z "$1" ] && SHA=HEAD
    git rev-parse $SHA
}

alias grc="git rebase --continue"
alias glp="git log -p"
alias gs="git status"
alias undo="git reset HEAD^"
alias gd="git diff --submodule --cached -a --diff-filter=ACDTMR"
alias gdc="git diff --submodule --cached"
alias gdh="git diff --submodule --diff-filter=ACDTMR HEAD"
alias gca="git commit -a"
alias gsa="git status -u"
alias gco="git checkout"
alias gcom="git checkout master"
alias gmom="git merge origin/master"
alias ga="git add"
alias gc="git clone"
alias gb="git branch"
alias gba="git branch -a"
alias gcb="git checkout -b "
alias gpb="git pull --rebase"
alias grl="git rev-list"
### bash aliases

alias p6topir="~/git/rakudo/perl6 --target=pir"
alias p="perl -d -e0"
alias pd="perldoc"
alias perl_list_modules="perl -MCPAN -e 'CPAN::Shell->r'"
alias pdF="perldoc -F"
alias jpg_resize_all='for i in `ls`; do jpg_resize $i; done'
alias wwwmech="perl -MWWW::Mechanize::Shell -eshell"
alias update_minicpan="minicpan -r http://www.cpan.org -l /usr/minicpan"
alias slist="screen -list"
alias sb="sudo bash"
alias dh="df -h"
alias lt="ls -latr"
alias lsd="ls -lad"
alias rf="rm -rf "
alias ll="ls -la"
alias la="ls -a"
alias date="date '+ %A %B %d %X %Y'"
alias tz="tar zxvvpf"
alias lg="ls -al | grep"
alias vi=vim
alias v=vim
alias vb="vim -O ~/.bashrc ~/.bashrc.aliases; source ~/.bashrc"
alias vv="vim ~/.vimrc"
alias tdump="tcpdump -nnXSs 0"
alias screenshot="xwd -display :0 -root > screenshot.dmp"
alias h="history|tail -n 25"
#alias hg="history|grep "
alias m=make
alias mt="make test"
alias mit="make install test"
alias mj="nice -n20 make -j"
alias l=less
alias fixssh='source ~/.sshvars'
alias sx="ssh -XA"
alias ..='cd ..'
alias 2..='cd $up2'
alias 3..='cd $up3'
alias 4..='cd $up4'
alias 5..='cd $up5'
alias 6..='cd $up6'
alias 7..='cd $up7'
alias 8..='cd $up8'

alias parrotsh="perl ~/git/parrot/tools/dev/parrot_shell.pl"

alias gdb_latest="run_match_latest.pl gdb"
### testing aliases
alias xt="t xt/*"
alias tcover="./Build testcover --verbose 1 |colortest"
alias pb="perl Build.PL"
alias tlikenew="pb && ./Build clean && pb && cpanm --installdeps . && ./Build && t"
alias mtlikenew="make clean; perl Makefile.PL && make && make test"
alias clean_build_check="tlikenew && ./Build dist && check_dist"
alias perlconfig="perl -e 'use Config;use Data::Dumper;print Dumper \%Config;'"
####### svn aliases
alias colorsvn=svn
alias sdl="svn diff| colordiff|less -R"
alias sup='colorsvn up'
alias ssa="colorsvn status"
alias ss="svn status |grep -v ^?| grep -v '\.swp$'|grep -v '\.swo$' |grep -v '~$' |grep -v '\._'"
alias ssc="svn status |grep -v '\.swp$' |grep -v '~$' |grep -v '\._' |grep '^C'"
alias sa="colorsvn add"
alias si="colorsvn info"
alias sl="colorsvn log"
alias sco="colorsvn co"
alias svn_newdirs="svn mkdir tags trunk branches"
alias sv=svnversion
alias svn_delete_unknown="svn stat | grep '^?' | sed -e 's/^\? *//' | xargs svn --force del"
alias svn_delete_nonexistent="svn stat | grep '^!' | sed -e 's/^\! *//' | xargs svn --force del"

alias plv="prove -lrv"

alias new_pg="make clean; ./configure --prefix=$HOME --with-perl --enable-debug --enable-cassert --with-libxml"

# parrot stuff
alias new_system_parrot="make realclean; perl Configure.pl --ccflags=-g --optimize && nice -n20 make -j$TEST_JOBS"

alias psh="perl tools/dev/parrot_shell.pl"
alias j=jobs
alias f=fg
# this should only happen on debian-ish systems
#alias ack=ack-grep

alias new_libgit2="rm -rf build; mkdir build && cd build && cmake -DBUILD_CLAY=ON .. && make -j3"
alias install_libgit2="cd build && sudo cmake --build . --target install && cd .."

alias be="bundle exec"
alias rspec="rspec --format=doc --color"

alias fanslow='aticonfig --pplib-cmd "set fanspeed 0 50"'
alias fanfast='aticonfig --pplib-cmd "set fanspeed 0 90"'

# DoD-compliant 7-pass secure deletion of files with a pass of zeros aferward
alias erase="srm -rmfz"
