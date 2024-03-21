def _(s):
    for c in r'\^+@':
        s = s.replace(c, rf'\{c}')
    return s

COMMIT = _(r'commit \w{40}')
LINE = _(r'@@ -\w+')
FILE = _(r'--- a/(\w|/|\.|-| )+')
INDEX = _(r'index \w{7}\.\.\w{7}')

REMOVE_COLORS = r"sed -r 's/\\x1B\\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g'"
RESET = r'/\ek\ek\n'
COPY = r"tr -d '\\n'|c"
NA = 'noaction'
DIFFTOOL = 'git difftool --trust-exit-code --no-prompt'
XARGS = 'xargs bash -c '
CUT=r"tr '\\n' ' '|cut -d ' ' -f"

def read(pattern, n = 1):
    return rf"mawj?\^{pattern}\nmm{RESET}'a|mhead -{n}|{REMOVE_COLORS}"

print(rf'''#env
LESS = -irFRX --mouse --wheel-lines=1
#command
\e clear-search
gg goto-line
# Git
yc {NA} {read(COMMIT)}|{CUT}2|{COPY}\n
yf {NA} {read(FILE)}|cut -c 7-|{COPY}\n
yl {NA} {read(LINE)}|grep -o '[0-9]\\+'|{CUT}1|{COPY}\n
gc {NA} {read(COMMIT)}|{CUT}2|{XARGS}'tmux neww "tig show $0"'\n
gf {NA} {read(INDEX, 2)}|{CUT}2,5|{XARGS}'tmux neww -e FILE="$PWD/${{1:2}}" "{DIFFTOOL} ${{0}}"'\n
''')
