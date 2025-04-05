def r(pattern, n='1'):
    """find pattern and return n lines"""
    return rf"JmaJK\eb?{pattern}\n|a^P head -n {n}|{REMOVE_COLORS}"

RESET_SEARCH = r'/^A^A\n'
START = 'mo'
END = rf'{RESET_SEARCH}\'o\ema\emo'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"
NA = 'noaction'
RUN = 'xargs bash -c '
CUT = "cut -d' ' -f"

COMMIT = r'\^commit \\w{40}'
STASH = r'\^stash@\\{[0-9]\+\\}: '
REFLOG = r'\^\\w{6} (\\(.*\\) )?HEAD@\\{[0-9]\+\\}: '
GRAPH_COMMIT = r'\^([\\|\\*] )+\\w{6} '
ANY_COMMIT = f"{COMMIT}|{STASH}|{REFLOG}|{GRAPH_COMMIT}"

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +/\^
#command
gg goto-line
G goto-end
zz back-scroll
j forw-line-force
^a {NA} |.^P{REMOVE_COLORS}|nvim -c 'syn off' -c 'set ls=0' -c 'set nonu'\n
yy {NA} |.^Phead -1|{REMOVE_COLORS}|cb copy\n
# Git
l {NA} {START}{r(ANY_COMMIT)}|git_wrap log-commit\n{END}
gd {NA} {START}{r(COMMIT, '-1')}|git_wrap log-diff\n{END}
yc {NA} {START}{r(ANY_COMMIT)}|git_wrap log-commit -c\n{END}
yf {NA} {START}{r(COMMIT, '-1')}|git_wrap log-diff -c\n{END}
c {NA} J/{COMMIT}\n{START}{END}
C {NA} \eb?{COMMIT}\n{START}{END}
\e\e {NA} $
#line-edit
\e abort
^A up
''')
