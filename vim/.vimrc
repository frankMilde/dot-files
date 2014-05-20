"=== general settings === {{{
set nocompatible  " use vim defaults
set wrap
set formatprg=par\ -w76
set iskeyword+=:,_,$,%,#,@ 		" use for LaTeX, uncomment line 317 as well
"set iskeyword+=#					" use for c++ programming
set whichwrap=b,s,h,l,<,>,[,]	" move freely between files
set wildmenu									" show some autocomplete options in status bar
set wildignore=*.o,*.obj,*.exe,*~
set wildmode=list:longest,full
set display+=lastline	"show whole paragraph
set visualbell t_vb= 	" turn off error beep/flash
"set tags+=tags;$HOME	"allows to use tags
set tabstop=2     		" numbers of spaces of tab character
set shiftwidth=2  		" numbers of spaces to (auto)indent
set scrolloff=3   		" keep 3 lines when scrolling
set modeline      		" last lines in document sets vim mode
set modelines=3   		" number lines checked for mode lines
set shortmess=atI 		" Abbreviate messages
set nostartofline 		" don't jump to first character when paging
set linebreak 				" don't break words
set autowrite     		" auto saves changes when quitting and switching buffer
set autoread					" when reloading files with :checktime no dialogue pops up
set hidden 						" remember undo after quitting
set history=10000			" in the vim history are now 10.000 lines
set cursorline				" shows cursorline
set cursorcolumn			" shows cursor column
syntax on   					" syntax highlighting

set textwidth=76
set fo+=t
" Macro to show lines that are longer than 80 characters
" With the autocmds it works on more than one buffer
augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
	autocmd BufEnter * match OverLength /\%>76v.\+/
augroup END
" alternative macro to highlight overlength
"set colorcolumn=+1   " shows a red line at 81 characters
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

au FocusLost * :wa		" always save when tabbing away from vim

set viminfo='100,<500,s10		" remove the buffer limit when yank to copy and past in VIM
"the 'option is used to specify how many files for which you save marks (a-z).
"The < option controls how many lines are saved for each of the registers.
"
function! Format()
	:% s/\.  \(.\)/. \1/
	:% s/\(\<\w\+\>\)\_s*\1/\1/
	:% s/\(\<\w\+\>\)\_s*\1/\1/
	exec "set expandtab"
	exec "retab"
endfunction

"set viminfo='20,<50,s10,h
"set expandtab    " tabs are converted to spaces, use only when required
"set nobackup			" do not keep a backup file
"set ttyscroll=0  " turn off scrolling, didn't work well with PuTTY
"set novisualbell " turn off visual bell
"set nowrap 			" don't wrap lines

set showcmd	" display incomplete commands
set ruler  	" show the cursor position all the time
set number  " show line numbers
set title   " show title in console title bar
set ttyfast " smoother changes
set ls=2    " always show status line

"Make cursor move as expected with wrapped lines:
"inoremap <Down> <C-o>gj
"inoremap <Up> <C-o>gk

" vim doesnt recognized the following options of the .vimrc, as they are overridden by a plugin,
" hence this workaround will call the options in a function. Press F11 after starting vi.
map <F11> : call Initalize()<CR>
function! Initalize()
	exec "set ww=b,s,<,>,[,]"
	exec "set iskeyword+=:,_,$,%,#,@,-"
"	exec "call IMAP('`w','\omega','tex')" "doesnt work :(
"	exec "call IMAP('`h','\hbar','tex')"
endfunction
"}}}

"=== search === {{{
"set ignorecase                    " ignore case when searching
set smartcase                     " If you search for an all-lowercase string your search will be case-insensitive, but if one or more characters is uppercase the search will be case-sensitive.
set gdefault                      " always substitute globally

set hlsearch                      " highlight searches
set incsearch                     " do incremental searching (highlights while typing)
set showmatch                     " show searchresult while typing

nnoremap <leader><space> :noh<cr> " backslash space unhighlights search results
nnoremap <tab> %                  " find matching braces with tab instead of %
vnoremap <tab> %

" Turn off incremental searching for files over 10,000,000 bytes. It's too slow.
function! IncSearch()
  if line2byte(line("$")) < 10000000
    set incsearch
  else
    set noincsearch
  endif
endfunction
"}}}

"=== Print options === {{{
set printdevice=mark
set printoptions=number:y,portrait:y,paper:A4
"prints with linenumbers, landscape, on A4 paper "you can print using :hardcopy

function! Hardcopy()
	hardcopy > temp.ps
	exec 'call system("lpr -o number-up=2 -o sides=two-sided-long-edge temp.ps")'
	exec 'call system("rm temp.ps")'
endfunction
"}}}

"=== indent === {{{
set autoindent     " always set autoindenting on
set smartindent    " smart indent
set cindent        " cindent
"set noautoindent
"set nosmartindent
"set nocindent
"}}}

"=== file recognition === {{{
filetype on
filetype indent on
filetype plugin on

" assume bashscript syntax highlighting for files with no extension
autocmd BufNewFile,BufRead * if &ft == '' | set ft=sh | endif

" recognize .md as markdown files and treat accordingly
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.md set nocindent
autocmd BufNewFile,BufRead *.md set spell
autocmd BufNewFile,BufRead *.md set spelllang=en_us,de
autocmd BufNewFile,BufRead *.txt set filetype=markdown 
autocmd BufNewFile,BufRead *.txt set nocindent
autocmd BufNewFile,BufRead *.txt set spell
autocmd BufNewFile,BufRead *.txt set spelllang=en_us,de

" how to tex files
autocmd BufNewFile,BufRead *.tex set nocindent
autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.tex set spelllang=en_us,de
autocmd BufNewFile,BufRead *.tex set iskeyword+=:,-

" how to treat emails
autocmd BufNewFile,BufRead *.eml set nocindent
autocmd BufNewFile,BufRead *.eml set spell
autocmd BufNewFile,BufRead *.eml set spelllang=en_us,de
autocmd BufNewFile,BufRead *.eml set textwidth=70
"}}}

" === bash-support === {{{
let g:BASH_AuthorName   = 'Frank Milde'     
let g:BASH_AuthorRef    = 'FM'                         
let g:BASH_Email        = 'frank@mailbox.tu-berlin.de'            
let g:BASH_Company      = 'TU Berlin'
"}}}

"=== tags === {
"This will look in the current directory for "tags", and work up the tree towards HOME until one is found. IOW, you can be anywhere in your source tree instead of just the root of it.
set tags=tags;$HOME
set tags+=~/.vim/tags/cpp
"set tags=./tags;/ 				"looks up till root directory

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>	"Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>			"Open the definition in a vertical split
"}

"=== OmniCppComplete ==={
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview"
"}

"=== WORD highlights === {{{
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|BUG\|TRICKY\|WARNING\|WORKAROUND\|DEBUGGING', -1, 24)
augroup END

syn match TmlDoubleWords /\c\<\(\S\+\)\_s\+\1\ze\_s/
hi def link TmlDoubleWords ToDo
"}}}

"=== spell checking === {{{
set nospell 							" spell checking is off
"set spell									" spell checking is on
set spelllang=en_us
"set spelllang=de
"set spelllang=de,en
set spellsuggest=double,10
"set syntax spell

"set dictionary+=/usr/share/dict/words
"set dictionary+=/usr/share/dict/de-en.txt
"}}}

"=== Folds === {{{
set foldmethod=marker " this lets us put the marker in the file so that it can be shared across and stored in version control.
set foldmarker={,}   " this lets us put the marker in the file so that it can be shared across and stored in version control.
"set foldmethod=syntax " uses syntax for folding
"set foldmethod=indent " uses indendt for folding
set foldlevel=0       " default fold level, all open, set it 200 or something to make it all closed.
"}}}

"=== powerline status bar === {{{
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256
"let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'
"}}}

"=== File Explorer ==={{{
"let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1      " preview window shown in a vertically split
let g:netrw_winsize=20		 " when you preview the new file takes up 80% and the file explorer the other 20%
"}}}

"=== screen === {{{
"if running in screen, screen will change the term variable to $TERM=screen,
"which is not recognized by vim, so we change it:
if match($TERM, "screen")!=0
	"set term=urxvt
	  set term=xterm
	  "set term=uxterm-256color
	endif
"}}}

"=== preview window === {{{
au! CursorHold *.[ch] nested call PreviewWord()
func PreviewWord()
  if &previewwindow			" don't do this in the preview window
    return
  endif
  let w = expand("<cword>")		" get the word under cursor
  if w =~ '\a'			" if the word contains a letter

    " Delete any existing highlight before showing another tag
    silent! wincmd P			" jump to preview window
    if &previewwindow			" if we really get there...
      match none			" delete existing highlight
      wincmd p			" back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    try
       exe "ptag " . w
    catch
      return
    endtry

    silent! wincmd P			" jump to preview window
    if &previewwindow		" if we really get there...
	 if has("folding")
	   silent! .foldopen		" don't want a closed fold
	 endif
	 call search("$", "b")		" to end of previous line
	 let w = substitute(w, '\\', '\\\\', "")
	 call search('\<\V' . w . '\>')	" position cursor on match
	 " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
	 exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p			" back to old window
    endif
  endif
endfun
"}}}

"=== Tab merging === {{{
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
"}}}

"=== Color scheme === {{{
" colors can be found under /usr/share/vim/vimfiles/colors
if has("gui_running")
    " See ~/.gvimrc
    set guifont=Monospace\ 10  " use this font
    set lines=50       " height = 50 lines
    set columns=100        " width = 100 columns
    set background=light   " adapt colors for background
    set selectmode=mouse,key,cmd
    set keymodel=
else
    set background=dark    " adapt colors for background
    "colorscheme darkzen   " use this color scheme
    "colorscheme elflord    " use this color scheme
    "colorscheme desert    " use this color scheme
    "colorscheme symfony    " use this color scheme
    "colorscheme herald    " use this color scheme
		"colorscheme vividchalk
		"colorscheme shittles_dark
		"colorscheme wombat_256			"not found
		"colorscheme lilydjawg_dark "not found
    colorscheme my_molokai    " use this color scheme
endif
"}}}

" === Invisible Characters ==={{{
" Shortcut to rapidly toggle `set list`
nmap ,l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"}}}

"=== Keyboard mappings === {{{

" Dont have to use shift anymore
nnoremap <F12> :make<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>         " open/closes tagbar
"nnoremap <silent> <F2> :TagbarTogglePause<CR>  " freezes tagbar to current file
map <silent> <C-N> :silent noh<CR>               " turn off highlighted search
nnoremap <leader>a :%s/\s\+$//<cr>:let @/=''<CR> " \a clears trailing white spaces in file
map ,u :source $MYVIMRC<CR>                      " update the system settings from my vimrc file
map ,ns :set nospell<CR>
map ,sp :set spell<CR>
map ,w :w!<CR>
vmap ,y :redir! > ~/.vim/.myclipboard <BAR> silent echo @0 <BAR> redir END <CR>
vmap ,p :read  ~/.vim/.myclipboard <CR>
nmap ,y :redir! > ~/.vim/.myclipboard <BAR> silent echo @0 <BAR> redir END <CR>
nmap ,p :read  ~/.vim/.myclipboard <CR>
nmap ,n :cn<CR>
nmap ,m :cN<CR>

"map <F10> O/**************<CR><CR>************/#<Esc>100\|Dkk100\|DjA
map ,o :call IMAP('`w','\omega','tex')<CR>:call IMAP('`h','\hbar','tex')<CR>

" The first line sets a mapping so that pressing F4 in normal mode will
" invert the 'paste' option, and will then show the value of that option.
" The second line allows you to press F4 when in insert mode, to toggle
" 'paste' on and off. The third line enables displaying whether 'paste' is
" turned on in insert mode.
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

" this allows all window commands in insert mode and i'm not accidentally
" deleting words anymore
imap <C-w> <C-o><C-w> 

" substitute all occurrences of the word under the cursor
"  if the cursor is on the word foo and you press \s, you will see in the
"  cmd line   :%s/\<foo\>/
:nnoremap <Leader>s :% s/\<\(<C-r><C-w>\)\>/


" merge tabs with horizontal split
"nnoremap <C-.> :call MoveToNextTab()<CR>
"nnoremap <C-,> :call MoveToPrevTab()<CR>

" merge tabs and make vertical split
"map <C-m> :call MoveToNextTab()<CR><C-w>H
"map <C-n> :call MoveToPrevTab()<CR><C-w>H

" Using space as leader made vim slow
"nnoremap <space><Left> :wincmd h<CR>
"nnoremap <space><Down> :wincmd j<CR>
"nnoremap <space><Up> :wincmd k<CR>
"nnoremap <space><Right> :wincmd l<CR>

nnoremap z<Left>  :wincmd h<CR>
nnoremap z<Down>  :wincmd j<CR>
nnoremap z<Up>    :wincmd k<CR>
nnoremap z<Right> :wincmd l<CR>

nnoremap zh :wincmd h<CR>
nnoremap zj :wincmd j<CR>
nnoremap zk :wincmd k<CR>
nnoremap zl :wincmd l<CR>

vmap z<Left>  :wincmd h<CR>
vmap z<Down>  :wincmd j<CR>
vmap z<Up>    :wincmd k<CR>
vmap z<Right> :wincmd l<CR>

" Mapping vims tab movement to
nmap [1;3C :tabn<CR>  " <ALT-Right>   previous tab
nmap [1;3D :tabp<CR>  " <ALT-Left>  next tab
nmap [1;3A :tabl<CR>  " <ALT-Up>     last tab
nmap [1;3B :tabr<CR>  " <ALT-Down>   first tab
nmap [1;j :tabn<CR>  " <ALT-j>  previous tab
nmap [1;k :tabp<CR>  " <ALT-k>      next tab
nmap [1;l :tabl<CR>  " <ALT-l>      last tab
nmap [1;h :tabr<CR>  " <ALT-h>     first tab

vmap [1;3C :tabn<CR>  " <ALT-Right>   previous tab
vmap [1;3D :tabp<CR>  " <ALT-Left>  next tab
vmap [1;3A :tabl<CR>  " <ALT-Up>     last tab
vmap [1;3B :tabr<CR>  " <ALT-Down>   first tab
vmap [1;j :tabn<CR>  " <ALT-j>  previous tab
vmap [1;k :tabp<CR>  " <ALT-k>      next tab
vmap [1;l :tabl<CR>  " <ALT-l>      last tab
vmap [1;h :tabr<CR>  " <ALT-h>     first tab

inoremap <expr> [1;3C :tabn<CR>  " <ALT-Right>   previous tab
inoremap <expr> [1;3D :tabp<CR>  " <ALT-Left>  next tab
inoremap <expr> [1;3A :tabl<CR>  " <ALT-Up>     last tab
inoremap <expr> [1;3B :tabr<CR>  " <ALT-Down>   first tab
inoremap <expr> [1;j :tabn<CR>  " <ALT-j>  previous tab
inoremap <expr> [1;k :tabp<CR>  " <ALT-k>      next tab
inoremap <expr> [1;l :tabl<CR>  " <ALT-l>      last tab
inoremap <expr> [1;h :tabr<CR>  " <ALT-h>     first tab

" Force me to use hjkl instead of arrow keys (even in insert mode.. ok that
" was too hard)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>  " u need this to select when completing words
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" The following need the unimpaired plugin at:
" http://www.vim.org/scripts/script.php?script_id=1590
" Note: mapping does not work in screen

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Bubble single lines
nmap [1;5A [e
nmap [1;5B ]e
" Bubble multiple lines
vmap [1;5A	[egv
vmap [1;5B 	]egv

" Keeps visual selection when indenting lines
vmap < <gv
vmap > >gv

nmap [[ ?{<CR>w99[{
nmap ][ /}<CR>b99]}
nmap ]] j0[[%/{<CR>
nmap [] k$][%?}<CR>

" German Umlaute
imap ae ä
imap AE Ä
imap oe ö
imap OE Ö
imap ue ü
imap UE Ü
imap \ss ß

" Common command line typos
cmap Q q
cmap q1 q!
cmap Q! q!
cmap Q1 q!
cmap W w
cmap w1 w!
cmap W1 w!
cmap W! w!
cmap Tabnew tabnew
cmap Tabnext tabnext
cmap Tabprevious tabprevious

"Common typos
imap teh the

"Type dts in insert mode to expand to a date stamp output a string like 'Mon May 04 11:01:58 2009'.
:iab <expr> dts strftime("%a %b %d %T %Y")
"}}}

"=== Buffer and Tabs handling === {{{
:set switchbuf=usetab,newtab,useopen
"better Bufferhandling using bufferlist.vim
map <silent> <F3> :call BufferList()<CR>
map :bo  BufOnly<CR> "closes all buffers except the current one
"options on buffers
"let g:BufferListWidth = 25
"let g:BufferListMaxWidth = 50
"hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold
"hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE
hi BufferNormal term=NONE ctermfg=darkcyan ctermbg=black cterm=NONE

set tabpagemax=30	"max number of open tabs

" Auto align for | while typing
" Attention: there must already exists an alignment in the line before or after
"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"}}}

"=== Easymotion === {{{
let g:EasyMotion_leader_key = '\'
"}}}

"=== LaTeX === {{{
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='pdflatex'
let g:Tex_CompileRule_pdf = 'pdflatex -file-line-error -interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_UseMakefile=0
let g:tex_comment_nospell=1 "no spell check of commented tex
" if the line below is not set then it will not compile
" bibtex for pdf. It will only do it for dvi.
" We dont do dvi. : )
"let g:Tex_MultipleCompileFormats = "dvi,pdf"
"let g:TCLevel 5

" Set the warning messages to ignore.
let g:Tex_IgnoredWarnings =
			\"Underfull\n".
			\"Overfull\n".
			\"specifier changed to\n".
			\"You have requested\n".
			\"Missing number, treated as zero.\n".
			\"There were undefined references\n".
			\'Latex Warning:'."\n".
			\"Citation %.%# undefined\n".
			\'LaTeX Font Warning:'"
" This number N says that latex-suite should ignore the first N of the above.
let g:Tex_IgnoreLevel = 9


"TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
"set iskeyword=@,48-57,_,192-255,-,.,:,_,%,#
"set iskeyword+=:,_,$,%,#,@,-		"non of these are word dividers

"To get a complete compilation including bibtex, abbr, etc use:
map <F10> : call CompileRunPDF()<CR>
function! CompileRunPDF()
	exec "w"
	exec "!make"
	"exec "!pdflatex % && evince %<.pdf"
	exec "i"
endfunction

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg='grep\ -nH\ $*'
"}}}

