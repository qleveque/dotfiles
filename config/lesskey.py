#!python3
# Write ~/.lesskey

import os

RESET = r'/\ek\ek\n'
COPY = r"tr -d '\\n'|c"
NA = 'noaction'
TMUX = 'xargs -I v tmux neww '

def read(pattern):
    s = pattern.replace(r'\\K', '')
    return rf"mawj?\^{s}\nmm{RESET}'a|mhead -1|grep -oP -- '{pattern}'"

COMMIT = r'commit \\K\\w{40}'
LINE = r'\@\@ -\\K\\w\+'
FILE = r'--- a/\\K(\\w|/|\\.|-| )\+'
INDEX = r'index \\K\\w{7}\\.\\.\\w{7} '

CONTENT = rf'''#env
LESS = -irFRX --mouse --wheel-lines=1
#command
\e clear-search
gg goto-line
# Git
yc {NA} {read(COMMIT)}|{COPY}\n
yf {NA} {read(FILE)}|{COPY}\n
yl {NA} {read(LINE)}|{COPY}\n
gc {NA} {read(COMMIT)}|{TMUX}"tig show v"\n
gf {NA} {read(INDEX)}|{TMUX}"git difftool --trust-exit-code --no-prompt v"\n
'''

with open(os.path.expanduser('~/.lesskey'), 'w') as f: f.write(CONTENT)
