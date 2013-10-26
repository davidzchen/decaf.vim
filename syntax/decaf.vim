" Vim syntax file
" Language:    Decaf
" Maintainer:  David Z. Chen <david@davidzchen.com>
" URL:         https://github.com/davidzchen/decaf.vim
" Last Change: 2013 Oct 26

" Quit when a syntax file was already loaded.
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax='decaf'
  syn region decafFold start="{" end="}" transparent fold
endif

let s:cpo_save = &cpo
set cpo&vim

if version < 508
  command! -nargs=+ DecafHiLink hi link <args>
else
  command! -nargs=+ DecafHiLink hi def link <args>
endif

" Keywords
syn keyword decafType          void bool int double string
syn keyword decafStorage       class interface
syn keyword decafModifier      extends implements
syn keyword decafRepeat        while for
syn keyword decafConditional   if else switch
syn keyword decafConstant      null true false 
syn keyword decafTypedef       this
syn keyword decafOperator      new NewArray Print ReadInteger ReadLine
syn keyword decafLabel         case default

" Comments
syn cluster decafCommentGroup  contains=decafTodo
syn keyword decafTodo          contained TODO FIXME XXX NOTE

" Comment Strings (ported from c.vim)
if exists("decaf_comment_strings")
  syn match  	decafCommentSkip		contained "^\s*\*\($\|\s\+\)"
  syn region 	decafCommentString	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=decafSpecialChar,decafCommentSkip
  syn region 	decafComment2String	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=decafSpecialChar
  syn cluster 	decafCommentStringGroup 	contains=decafCommentString,decafCharacter,decafNumber

  syn region 	decafCommentL		start="//" end="$" keepend contains=@decafCommentGroup,decafComment2String,decafCharacter,decafNumber,decafSpaceError,@Spell
  syn region 	decafComment		matchgroup=decafCommentStart start="/\*" end="\*/" contains=@decafCommentGroup,@decafCommentStringGroup,decafCommentStartError,decafSpaceError,@Spell extend
else
  syn region	decafCommentL		start="//" end="$" keepend contains=@decafCommentGroup,decafSpaceError,@Spell
  syn region	decafComment		matchgroup=decafCommentStart start="/\*" end="\*/" contains=@decafCommentGroup,decafCommentStartError,decafSpaceError,@Spell
endif
" match comment errors
syntax match decafCommentError 		display "\*/"
syntax match decafCommentStartError 	display "/\*"me=e-1 contained
" match the special comment /**/
syn match   decafComment		 	"/\*\*/"

" Strings and constants (borrowed from vim-decaf)
syn match   decafSpecialError		contained "\\."
syn match   decafSpecialCharError	contained "[^']"
syn match   decafSpecialChar		contained +\\["\\'0abfnrtvx]+
syn region  decafString			start=+"+  end=+"+ end=+$+ contains=decafSpecialChar,decafSpecialError,decafUnicodeNumber,@Spell
syn match   decafCharacter		"'[^']*'" contains=decafSpecialChar,decafSpecialCharError
syn match   decafCharacter		"'\\''" contains=decafSpecialChar
syn match   decafCharacter		"'[^\\]'"
syn match   decafNumber			display "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   decafNumber			display "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   decafNumber			display "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   decafNumber			display "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

if version >= 508 || !exists("did_decaf_syn_inits")
  if version < 508
    let did_decaf_syn_inits = 1
  endif

  DecafHiLink decafType             Type
  DecafHiLink decafStorage          StorageClass
  DecafHiLink decafModifier         StorageClass
  DecafHiLink decafRepeat           Repeat
  DecafHiLink decafConditional      Conditional
  DecafHiLink decafConstant         Constant
  DecafHiLink decafTypedef          Statement
  DecafHiLink decafOperator         Statement
  DecafHiLink decafLabel            Label
  
  DecafHiLink decafCommentL         decafComment
  DecafHiLink decafCommentStart     decafComment
  DecafHiLink decafCommentSkip      decafComment
  DecafHiLink decafComment          Comment

  DecafHiLink decafSpecialError     Error
  DecafHiLink decafSpecialCharError Error
  DecafHiLink decafSpecialChar      SpecialChar
  DecafHiLink decafString           String
  DecafHiLink decafCharacter        Character
  DecafHiLink decafNumber           Number
endif

delcommand DecafHiLink

let b:current_syntax = "decaf"

if main_syntax == "decaf"
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save
