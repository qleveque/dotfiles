" Vim syntax file
" Language: Oberon2
" Version: 0.1
" Last Change:	2019.27.09
" Maintainer:  Andrea Peter <andrea.peter@bluebotics.com>
" Previous Maintainer:
"
" Contributors:
"

" quit if a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" not sure this is valid
syn sync fromstart

syn keyword oberon2Boolean TRUE FALSE

syn keyword oberon2Conditional IF THEN ELSE ELSIF

syn keyword oberonConstant NIL

syn keyword oberon2Keyword IS TO BEGIN TYPE CASE MOD CONST
syn keyword oberon2Keyword MODULE VAR DIV OF WITH ELSE OR ELSIF
syn keyword oberon2Keyword POINTER END PROCEDURE EXIT RECORD IF IMPORT
syn keyword oberon2Keyword RETURN IN THEN

syn keyword oberon2Loop FOR WHILE DO LOOP REPEAT UNTIL

syn keyword oberon2Type ARRAY CHAR BOOLEAN SHORTINT INTEGER LONGINT REAL SET LONGREAL

syn keyword oberon2StdFunc ABS ODD CAP ASH LEN ORD CHR SHORT LONG ENTIER DEC INC
syn keyword oberon2StdFunc ADEC INCL EXCL COPY NEW HALT

syn match oberon2SystemFunc "SYSTEM.\%(ADR\|BIT\|CC\|LSH\|ROT\|VAL\|GETREG\|PUTREG\|GET\|PUT\|MOVE\|NEW\)"

syn keyword oberon2Statement PROCEDURE

syn keyword oberon2Todo contained	TODO FIXME


" Strings
syn region oberon2String start=+"+ end=+"+ contains=oberon2StringEscape
syn match oberon2StringEscape	contained "\\\""

" Comments
syn region oberon2Comment start="(\*"  end="\*)" contains=oberon2Todo,oberon2Comment

" Style comments
" TODO choose from one of these two
"syn region oberon2Styled concealends matchgroup=oberon2StyleTag start="(\*%\%(Syntax\d\+[A-Za-z]\=.Scn.Fnt\)\= \=0[0-9a-fA-F]00%\*)\t\=" end="(\*%\%(Syntax\d\+[A-Za-z]\=.Scn.Fnt\)\= 0[0-9a-fA-F]00%\*)" containedin=oberon2Comment contains=ALL
syn region oberon2Styled concealends matchgroup=oberon2StyleTag start="(\*%\%(Syntax\d\+[A-Za-z]\=.Scn.Fnt\)\= \=0[0-9a-fA-F]00%\*)\t\=" end="(\*%\%(Syntax\d\+[A-Za-z]\=.Scn.Fnt\)\= 0[0-9a-fA-F]00%\*)" contains=ALL
" TODO delete this if syntax is OK 13.11.2019
"hi oberon2Styled term=bold cterm=bold
hi oberon2StyleTag term=bold cterm=bold

"syn match oberon2StyleTag "(\*% 0[0-9a-fA-F]00%\*)\t" conceal cchar=~
"hi def link oberon2StyleTag Error

"syn match oberon2StyleTag "(\*%\%(Syntax\d\+.Scn.Fnt\)\= 0[0-9a-fA-F]00%\*)" conceal cchar=~

" Numbers
syn match  oberon2Number	"-\=\<\d\+\>"
syn match  oberon2Float		"-\=\<\d\+\.\d\+\>"
syn match  oberon2Float		"-\=\<\d\+\.\d\+[DE][+-]\=\d\+\>"
syn match  oberon2HexNumber	"[0-9a-fA-F]\+H\>"

hi def link oberon2Boolean	Boolean
hi def link oberon2Comment	Comment
hi def link oberon2Conditional	Conditional
hi def link oberonConstant	Constant
hi def link oberon2Float	Float
hi def link oberon2HexNumber	Number
hi def link oberon2Keyword	Keyword
hi def link oberon2Loop		Repeat
hi def link oberon2Number	Number
hi def link oberon2StdFunc	Function
hi def link oberon2Statement	Statement
hi def link oberon2String	String
hi def link oberon2SystemFunc	Function
hi def link oberon2Todo		Todo
hi def link oberon2Type		Type

let b:current_syntax = "oberon2"

" vim: ts=8 sw=2

" Hide oberon colors
set conceallevel=3

