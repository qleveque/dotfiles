#!/bin/python3
import sys
IS_WSL = len(sys.argv) > 1 and sys.argv[1] == 'wsl'
C = lambda cmd: f'wsl -e sh -c "{cmd}"' if IS_WSL else cmd
GIT = lambda cmd: C(f'git-wrap {cmd}')

RESET_SEARCH = r'mS/^A^A\n\'S\emS'
SAVE = 'mO'
RESTORE = rf'\'O\emO'
NA = 'noaction'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"

BUFFER = f"|.^P{REMOVE_COLORS}"
COMMIT_PATTERN = r'\^commit |\^stash@|HEAD@\\{[0-9]\+\\}: |\^diff\$'
UNTIL_COMMIT_LINE = rf"JK\eb?{COMMIT_PATTERN}\n|O^P{REMOVE_COLORS}"

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +/\^
#line-edit
\e abort
^A up
#command
gg goto-line
G goto-end \e\40
zz back-scroll
yy {NA} {BUFFER}|{C("head -1|cb copy")}\n
^q quit
# Git
c {NA} J/{COMMIT_PATTERN}\n{RESET_SEARCH}
C {NA} \eb?{COMMIT_PATTERN}\n{RESET_SEARCH}
l {NA} {BUFFER}|{GIT("less-commit open")}\n
d {NA} {SAVE}{UNTIL_COMMIT_LINE}|{GIT("less-diff open-diff")}\n{RESET_SEARCH}{RESTORE}
yc {NA} {BUFFER}|{GIT("less-commit copy")}\n
yf {NA} {SAVE}{UNTIL_COMMIT_LINE}|{GIT("less-diff copy-file")}\n{RESET_SEARCH}{RESTORE}
''')
