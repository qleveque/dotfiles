#!/bin/python3
import sys
IS_WSL = len(sys.argv) > 1 and sys.argv[1] == 'wsl'
C = lambda cmd: f'wsl -e sh -c "{cmd}"' if IS_WSL else cmd

RESET_SEARCH = r'mS/^A^A\n\'S\emS'
NA = 'noaction'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"
BUFFER = f"|.^P{REMOVE_COLORS}"
GET_COMMIT = r"head -1 | sed 's/:/ /g' | sed 's/\\(commit\\)\\?[* |]*//' | cut -d' ' -f1"
COMMIT_PATTERN = r'\^commit |stash@\\{|HEAD@\\{'

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +/\^
#line-edit
\e abort
^A up
#command
j forw-line-force
gg goto-line
G goto-end \e\40
zz back-scroll
yy {NA} {BUFFER}|{C("head -1|cb copy")}\n
^q quit
# Git
c {NA} J/{COMMIT_PATTERN}\n{RESET_SEARCH}
C {NA} J\ebK?{COMMIT_PATTERN}\n{RESET_SEARCH}
l {NA} {BUFFER}|{GET_COMMIT}|{C("xargs git-wrap o -h")}\n
yc {NA} {BUFFER}|{GET_COMMIT}|{C("cb copy")}\n
''')
