" note.vim - Vim note mode. Your stuff in plain text.
" Maintainer:   Gregory SACRE <gregory.sacre@gmail.com>
" Version:      0.1

" Syntax Definition
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match object        "OBJECT\ *:"
syn match date          "DATE\ *:"
syn match project       "PROJECT\ *:"
syn match title         "\n^[A-Z\ \.]\+\n"

hi Function gui=bold
hi Constant gui=bold
hi Keyword gui=bold
hi Number gui=underline
hi String guifg=#ffffff gui=bold

hi def link object            Keyword
hi def link date              Function
hi def link project           Constant
hi def link title             String
hi! link Folded Comment

set textwidth=72
setlocal nocindent
set formatoptions=awtq
