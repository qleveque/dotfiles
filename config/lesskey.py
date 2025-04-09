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

CURRENT_LINE = f"|.^P{REMOVE_COLORS}"
UNTIL_COMMIT_LINE = rf"JmaKJ\eb?{ANY_COMMIT}\n|a^P head -n -1|{REMOVE_COLORS}"

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +/\^
#line-edit
\e abort
^A up
#command
gg goto-line
G goto-end \e\40
zz back-scroll
j forw-line-force
^a {NA} {CURRENT_LINE}|nvim -c 'syn off' -c 'set ls=0' -c 'set nonu'\n
yy {NA} {CURRENT_LINE}|head -1|cb copy\n
\e\e {NA} $
^q quit
# Git
l {NA} {CURRENT_LINE}|git_wrap log-commit\n
yc {NA} {CURRENT_LINE}|git_wrap log-commit copy\n
dd {NA} {CURRENT_LINE}|git_wrap log-drop\n
gd {NA} {START}{UNTIL_COMMIT_LINE}|git_wrap log-diff\n{END}
yf {NA} {START}{UNTIL_COMMIT_LINE}|git_wrap log-diff copy\n{END}
c {NA} J/{ANY_COMMIT}\n{START}{END}
C {NA} \eb?{ANY_COMMIT}\n{START}{END}
''')
