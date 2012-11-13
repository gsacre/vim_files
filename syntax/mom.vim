" mom.vim - Vim Minutes of Meeting mode. Your stuff in plain text.
" Maintainer:   Gregory SACRE <gregory.sacre@gmail.com>
" Version:      0.1

" Syntax Definition
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match subject       "SUBJECT :"
syn match date          "DATE    :"
syn match project       "PROJECT :"
syn match location      "LOCATION:"
syn match present       "PRESENT :"
syn match absent        "ABSENT  :"
syn match apsummary     "ACTION POINTS SUMMARY"
syn match agenda        "AGENDA"

syn region ap start="\[AP:\ " end="\]"

hi String guifg=#ffffff gui=bold
hi Constant gui=bold
hi Keyword gui=bold
hi Function gui=bold
hi Number gui=underline

hi def link subject           Keyword
hi def link date              String
hi def link ap                Constant
hi def link location          String
hi def link present           String
hi def link project           Function
"hi def link project           Keyword
hi def link absent            String
hi def link apsummary         String
hi def link agenda            String
hi! link Folded Comment

set textwidth=72
setlocal nocindent
set formatoptions=awtq
set spell spelllang=en_gb
