" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" some credits go to: https://github.com/mcantor/dotfiles/blob/master/vim/.vimrc
set nocompatible
source $VIMRUNTIME/vimrc_example.vim

" {{{ BASIC SETTINGS
set backspace=indent,eol,start
set backupdir=~/backup/
set undodir=~/undodir/
set viewdir=~/.vim/view/
set history=500
set showcmd
set incsearch
set tabstop=8
set shiftwidth=8
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
set cul

" Displays the lines based on the current highlighted line.
" Really useful to know how many lines to copy or delete from.
set relativenumber
"set foldmethod=indent
"set viewoptions=folds,cursor

" I don't want to have all the *bars
set guioptions-=T "toolbar
set guioptions-=m "menubar
set guioptions-=r "rulerbar

" Set the font if I can
set guifont=Consolas:h12

" To have an easier to read document
set linespace=8

" Initial window display
set lines=30
set columns=90

" To get all the nice little characters displayed
set fileencodings=utf-8

" For clever completion with the :find command
set path+=**

" Window display
set showcmd ruler laststatus=2

" Splits
set splitright

" Session saving
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,localoptions

" Status line
set statusline=%!MyStatusLine()

colorscheme lucario

" }}}

" {{{ VARIABLES
let $MYVIMRC="~/_vimrc"
let $SNIPPETS="C:/Users/gsa/Downloads/gVimPortable/Data/settings/.vim/plugged/vim-snippets/snippets"
" }}}

" {{{ AUTOCOMMANDS
" Make the modification indicator [+] white on red background
au ColorScheme * hi User1 gui=bold term=bold cterm=bold guifg=white guibg=red ctermfg=white ctermbg=red

" Tweak the color of the fold display column
au ColorScheme * hi FoldColumn cterm=bold ctermbg=233 ctermfg=146

autocmd BufWritePre COMMIT_EDITMSG :call WrapAt(72)
" autocmd BufWritePre *.rdb :call WrapAt(72)
autocmd BufWritePre * :%s/\s\+$//e

" We load the language specific abbreviations
autocmd FileType perl so $HOME/.vim/abb/perl.vim
"autocmd FileType c so $HOME/.vim/abb/c.vim
autocmd FileType python set textwidth=0
autocmd FileType python set formatoptions=

" We save and load the fold views
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

autocmd BufNewFile,BufRead *.csv setf csv
autocmd BufNewFile,BufRead *.tsv setf csv
autocmd BufNewFile,BufRead *.tsv Delimiter \t
autocmd BufNewFile,BufRead *.tsv setlocal ts=20 sw=25

" Change the status line based on the insert mode type
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=#66747f
" }}}

" {{{ KEY MAPPINS
noremap <F11> :call WrapAt()<Left>
nnoremap <silent> <C-Tab> :bn<CR>
nnoremap <silent> <C-s-Tab> :bp<CR>
" To search and replace the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"Regular expression magic mode
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Easy quickfix navigation
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" camelCase => camel_case
vnoremap ,case :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

" Session mappings
nnoremap ,s :mksession! Session.vim<CR>

" Sane pasting
command! Paste call SmartPaste()
" }}}

" {{{ PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'kalafut/vim-taskjuggler'

" {{{ SnipMate
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'

" Shows the snippet description in the popup menu
let g:snipMate = {}
let g:snipMate.description_in_completion = 1

" }}}

Plug 'dsummersl/wikia-csv'
"Plug 'itchyny/lightline.vim'

" {{{ NERDTree
"     ========

Plug 'scrooloose/nerdtree'

" OPTIONS:

" Get rid of objects in C projects
let NERDTreeIgnore=['\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']
let NERDTreeWinSize=20

" }}}

" {{{ netrw: Configuration
"     ====================

let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
" hide gitignore'd files
let g:netrw_list_hide=netrw_gitignore#Hide()
" hide dotfiles by default (this is the string toggled by netrw-gh)
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}

call plug#end()
" }}}

" {{{ FUNCTIONS
set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

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

" Function that takes the S-Clinica XML file and turns is into a human
" readable document.
func! SClinicaConfDoc()
	exe '%s/&lt;/</ge|%s/&gt;/>/ge|%s/<KeyValueOfstringstring><Key>//ge|%s/<\/Key><Value>/: /ge|%s/<\/Value><\/KeyValueOfstringstring>/\r/ge|%s/<\/Key><Value\/><\/KeyValueOfstringstring>/: \r/ge|%s/<\/KeyValueOfstringstring>//ge|%s/&amp;#13;&amp;#10;/\r/ge|%s/&amp;#xD;//ge|%s/<MaskPath>/Mask: /ge|%s/<\/MaskPath>//ge|%s/\v\<GenericClass[ [:alnum:]=":/._-]+\>//ge|%s/\v\<Object.+Value\>Not//ge|%s/\v\<\/Arr.+$//ge'
endfunc
command! SClinicaConfDoc call SClinicaConfDoc()

" MyStatusLine() {{{
function! MyStatusLine()
	let statusline = ""
	" Filename (F -> full, f -> relative)
	let statusline .= "%f"
	" Buffer flags
	let statusline .= "%( %h%1*%m%*%r%w%) "
	" File format and type
	let statusline .= "(%{&ff}%(\/%Y%))"
	" Left/right separator
	let statusline .= "%="
	" Line & column
	let statusline .= "(%l,%c%V) "
	" Character under cursor (decimal)
	let statusline .= "%03.3b "
	" Character under cursor (hexadecimal)
	let statusline .= "0x%02.2B "
	" File progress
	let statusline .= "| %P/%L"
	return statusline
endfunction
" }}}

" {{{ Sane Pasting
function! SmartPaste()
	setl paste
	normal "+p
	setl nopaste
endfunction
" }}}

" {{{ Change the insert status line
function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		hi statusline guibg=#66d9ef
	elseif a:mode == 'r'
		hi statusline guibg=#ca94ff
	else
		hi statusline guibg=#ff6541
	endif
endfunction
" }}}
" }}}
