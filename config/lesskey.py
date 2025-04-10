RESET_SEARCH = r'mS/^A^A\n\'S\emS'
START = 'mO'
END = rf'{RESET_SEARCH}\'O\emO'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"
NA = 'noaction'

COMMIT = r'\^commit \\w{40}'
STASH = r'\^stash@\\{[0-9]\+\\}: '
REFLOG = r'\^\\w{6} (\\(.*\\) )?HEAD@\\{[0-9]\+\\}: '
GRAPH_COMMIT = r'\^([\\|\\*] )+\\w{6} '
ANY_COMMIT = f"{COMMIT}|{STASH}|{REFLOG}|{GRAPH_COMMIT}"

BUFFER = f"|.^P{REMOVE_COLORS}"
COMMIT = f"{BUFFER}|git_wrap log-commit"
UNTIL_COMMIT_LINE = rf"JK\eb?{ANY_COMMIT}\n|O^P{REMOVE_COLORS}"

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
^a {NA} {BUFFER}|nvim -c 'syn off' -c 'set ls=0' -c 'set nonu'\n
yy {NA} {BUFFER}|head -1|cb copy\n
\e\e {NA} $
^q quit
# Git
l {NA} {COMMIT}|xargs gitrs show\n
yc {NA} {COMMIT}|cb copy\n
dd {NA} {COMMIT}|xargs stash drop\n
R {NA} {COMMIT}|xargs -i git rebase -i {{}}\^\n
gd {NA} {START}{UNTIL_COMMIT_LINE}|git_wrap log-diff\n{END}
yf {NA} {START}{UNTIL_COMMIT_LINE}|git_wrap log-diff copy\n{END}
c {NA} J/{ANY_COMMIT}\n{RESET_SEARCH}
C {NA} \eb?{ANY_COMMIT}\n{RESET_SEARCH}
''')
