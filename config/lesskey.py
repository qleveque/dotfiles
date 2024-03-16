#!python3
import os

RESEARCH = r'/\ek\ek\n'
COPY = r"tr -d '\\n'|c\n"
NA = 'noaction'

def tmux_run(command):
    return rf'xargs -I v tmux neww "{command}"\n'

def read(pattern):
    search_pattern = pattern.replace(r'\\K', '')
    return rf"mawj?\^{search_pattern}\nmm{RESEARCH}'a|mhead -1|grep -oP -- '{pattern}'"

COMMIT = r'commit \\K\\w{40}'
LINE = r'\@\@ -\\K\\w\+'
FILE = r'--- a/\\K\\S\+'
INDEX = r'index \\K\\w{7}\\.\\.\\w{7} '

with open(os.path.expanduser('~/.lesskey'), 'w') as f:
    f.write(
rf'''#env
LESS = -irFRX --mouse --wheel-lines=1

#command
\e clear-search
gg goto-line

# Git
yc {NA} {read(COMMIT)}|{COPY}
yf {NA} {read(FILE)}|{COPY}
yl {NA} {read(LINE)}|{COPY}
gc {NA} {read(COMMIT)}|{tmux_run("tig show v")}
gf {NA} {read(INDEX)}|{tmux_run("git difftool --trust-exit-code --no-prompt v")}
''')
