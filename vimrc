syntax on
setlocal spell spelllang=en_gb
set nospell
set nocompatible
set backspace=indent,eol,start
set backupdir=~/backup/
set history=50
set showcmd
set incsearch
set tabstop=8
set shiftwidth=8
set expandtab
"set foldcolumn=2
set ruler
set cindent
set mouse=n
set scrolloff=5
set ignorecase
set smartcase
set hid
set showmatch
set hlsearch
set autochdir
set wrap

" setting par as the paragraph formatting tool -- using gqip
"set formatprg=par\ 72

"set background=light
let $MYVIMRC="~/.vimrc"

nnoremap <silent> <F5> :TaskList<CR>
nnoremap <silent> <F6> :Project<CR>
nnoremap <silent> <F7> :set mouse=a<CR>
nnoremap <silent> <F8> :set mouse=""<CR>
nnoremap <silent> <F9> :TlistToggle<CR>
noremap <F11> :call WrapAt()<Left>
nnoremap <silent> <F12> :Explore<CR>
nnoremap <silent> <C-Tab> :bn<CR>
nnoremap <silent> <C-s-Tab> :bp<CR>

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" To search and replace the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

colorscheme gsac
"colorscheme less-tmux

autocmd BufWritePre COMMIT_EDITMSG :call WrapAt(72)
" autocmd BufWritePre *.rdb :call WrapAt(72)
autocmd BufWritePre * :%s/\s\+$//e

" We load the language specific abbreviations
autocmd FileType perl so $HOME/.vim/abb/perl.vim
"autocmd FileType c so $HOME/.vim/abb/c.vim
autocmd FileType python set textwidth=0
autocmd FileType python set formatoptions=

" We save and load the fold views
set foldmethod=indent
set viewoptions=folds,cursor
au BufWinEnter,BufRead,BufNew,BufNewFile mutt-* set textwidth=72
au BufWinEnter,BufRead,BufNew,BufNewFile *.txt set textwidth=72
au BufWinEnter,BufRead,BufNew,BufNewFile *.vorg set textwidth=72
au BufWinEnter,BufRead,BufNew,BufNewFile *.rdb set textwidth=72
au BufWinEnter,BufRead,BufNew,BufNewFile mutt-* setlocal nocindent
au BufWinEnter,BufRead,BufNew,BufNewFile *.txt setlocal nocindent
au BufWinEnter,BufRead,BufNew,BufNewFile *.vorg setlocal nocindent
au BufWinEnter,BufRead,BufNew,BufNewFile *.rdb setlocal nocindent
au BufWinEnter,BufRead,BufNew,BufNewFile mutt-* set formatoptions=awtq
au BufWinEnter,BufRead,BufNew,BufNewFile *.txt set formatoptions=awtq
au BufWinEnter,BufRead,BufNew,BufNewFile *.vorg set formatoptions=awtq
au BufWinEnter,BufRead,BufNew,BufNewFile *.rdb set formatoptions=awtq

au BufWinEnter,BufRead,BufNew,BufNewFile *.note set ft=note
au BufWinEnter,BufRead,BufNew,BufNewFile *.mom set ft=mom
au BufWinEnter,BufRead,BufNew,BufNewFile project_info* set ft=prjtmpl

au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" We set spelling for things that matter
au BufWinEnter *.txt set spell
au BufWinEnter COMMIT_EDITMSG  set spell
au BufWinEnter COMMIT_EDITMSG  setlocal nocindent

au BufRead,BufNewFile *.tjp setfiletype tjp
au BufRead,BufNewFile *.tji setfiletype tjp

if has("gui_running")
        set cul
        set guioptions-=T
        set guioptions-=m
        set guioptions-=r
        "set guifont=DejaVu\ Sans\ Mono\ 10
        set guifont=PragmataPro\ 12
        set wrap
	set lines=40
	set columns=80
        "set foldcolumn=2
        set foldmethod=syntax
	colorscheme wombat
	nnoremap <2-LeftMouse> :Utl ol<cr>
        nnoremap <silent> <C-Tab> :tabn<CR>
        nnoremap <silent> <C-s-Tab> :tabp<CR>
endif

func! WrapAt(num1)
        exe "set textwidth=" . a:num1
        set wrap
        set nocp
        let tmp = line("$")
        normal gg
        for i in range (1, tmp)
                normal gqq
                normal +
        endfor
endfunc

" for latex-suite
filetype plugin indent on
set grepprg=grep\ -nH\ $*
set iskeyword+=:
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
"augroup MyIMAPS
""        au!
"        au VimEnter *.tex source ~/.vim/after/ftplugin/tex.vim
"augroup END

" for writing mails with correct accents in Mutt
"set encoding&           " terminal charset: follows current locale
"set termencoding=
"set fileencodings=    " charset auto-sensing: disabled
"set fileencoding&    " auto-sensed charset of current buffer

" to have 256 colors
set t_Co=256

" for buftabs
"noremap <f1> :bprev<CR>
"noremap <f2> :bnext<CR>
nnoremap <S-Right> :tabn<CR>
nnoremap <S-Left> :tabp<CR>

"" tags
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
"" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview

"-------------------------------------------------------------------------------
"" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>

"vnoremap ( s()<Esc>P<Right>%
"vnoremap [ s[]<Esc>P<Right>%
"vnoremap { s{}<Esc>P<Right>%

map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>

function! DateLastDay(day)
	let day  = abs(a:day) % 7
	let dir  = a:day < 0 ? -1 : 1
	let sday = 60 * 60 * 24 * dir
	let time = localtime() + sday
	while strftime('%w', time) != day
		let time += sday
	endwh
	return strftime('%c', time)
endf

" For PHP
au BufRead,BufNewFile *.php set makeprg=php\ -a\ %
let php_sql_query=1
"let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1

" Autocompletion kick ass
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1

" URL creation
abbreviate xu <url:<Left>
abbreviate xuh <url:/home/gsacre/<Left>

" Abbreviations
abbreviate I: Intel:
abbreviate N: NOTE:
abbreviate eoi [end-of-item]

" Notes.vim
"let g:notes_directory = '/home/gsacre/SpiderOak/notes'
