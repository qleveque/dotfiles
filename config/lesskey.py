def r(pattern, n=1):
    """find pattern and return n lines"""
    return rf"maJ/{pattern}\nNmm{RESET}'a|mhead -{n}|{REMOVE_COLORS}"


RESET = r'/\ek\ek\n'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"
NA = 'noaction'
RUN = 'xargs bash -c '
CUT = "cut -d' ' -f"

COMMIT = r'\^commit \\w{40}'
STASH = r'\^stash@\\{[0-9]\+\\}: '
REFLOG = r'\^\\w{7,} (\\(.*\\) )?HEAD@\\{[0-9]\+\\}: '
GRAPH_COMMIT = r'\^[\\|\\* ]+ \\w{7,} - '
ANY_COMMIT = f"{COMMIT}|{STASH}|{REFLOG}|{GRAPH_COMMIT}"
READ_COMMIT_LINE = f"{r(ANY_COMMIT)}"
IDX = r'\^index \\S*\\w{7,}\\.\\.\\w{7,}'
READ_IDX_FILE = fr"{r(IDX, 3)}|grep -v ' /'|cut -c7-|{RUN}'echo $0 ${{@:$\#}}'"

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +k
#command
gg goto-line
zz back-scroll
^a {NA} mm|m{REMOVE_COLORS}|nvim -c 'syn off' -c 'set ls=0' -c 'set nonu'\n
j forw-line-force
yy {NA} ma|ahead -1|cb copy\n
# Git
\n {NA} {READ_COMMIT_LINE}|git_wrap commit-line\n
gd {NA} {READ_IDX_FILE}|git_wrap index\n
yc {NA} {READ_COMMIT_LINE}|git_wrap commit-line -c\n
yf {NA} {READ_IDX_FILE}|{CUT}2|cb copy\n
c {NA} J/{COMMIT}\nma{RESET}'a
C {NA} /{COMMIT}\nNma{RESET}'a
''')
