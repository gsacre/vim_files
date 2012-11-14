" prjtmpl.vim - Vim Project Template mode. Your stuff in plain text.
" Maintainer:   Gregory SACRE <gregory.sacre@gmail.com>
" Version:      0.1

" Syntax Definition
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match project       "PROJECT NAME\ *:"
syn match clientInfo    "CLIENT\ *:\|PROJECT MANAGER\ *:\|TECHNICAL LEAD\ *:\|OTHER PARTICIPANTS\ *:\|START DATE\ *:"
syn match notes         "DESCRIPTION\|NOTE"
syn match skInfo        "SOFTKINETIC PM\ *:\|SOFTWARE.*:\|HARDWARE.*:\|BUDGET\ *:"

hi String guifg=#ffffff gui=bold
hi Constant gui=bold
hi Keyword gui=bold
hi Function gui=bold
hi Number gui=underline

hi def link notes             String
hi def link clientInfo        Keyword
hi def link skInfo            Function
hi def link project           Constant
hi! link Folded Comment

set textwidth=72
setlocal nocindent
set formatoptions=awtq
set spell spelllang=en_gb
