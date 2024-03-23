RESET = r'/\ek\ek\n'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g'"
NA = 'noaction'
RUN = 'xargs bash -c '
CUT=r"tr '\\n' ' '|cut -d ' ' -f"

def read(pattern, n = 1):
    return rf"mawj?{pattern}\nmm{RESET}'a|mhead -{n}|{REMOVE_COLORS}"

COMMIT = r'\^commit \\w{40}'
READ_COMMIT = f"{read(COMMIT)}|{CUT}2"
INDEX = r'\^index \\w{7}\\.\\.\\w{7}'
READ_INDEX_AND_FILE = rf"{read(INDEX, 3)}|sed -r 's| [0-9]\+$||;s| [ab]/| |'|grep -v ' /dev/null'|{CUT}2,4"

print(rf'''#env
LESS = -irFRX --mouse --wheel-lines=1
#command
\e clear-search
gg goto-line
# Git
gc {NA} {READ_COMMIT}|{RUN}'tmux neww "tig show $0"'\n
yc {NA} {READ_COMMIT}|c\n
gf {NA} {READ_INDEX_AND_FILE}|{RUN}'tmux neww -e FILE="$PWD/$1" "git difftool --trust-exit-code -y $0"'\n
yf {NA} {READ_INDEX_AND_FILE}|{CUT}2|c\n''')
