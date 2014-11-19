"===========================================================================
"
"          File:  .vimrc
" 
"   Description:  Suggestion for a personal configuration file ~/.vimrc
"                 When opening vim, run ':NeoBundleInstall', and all
"                 necessary plugins will be installed.
" 
"   VIM Version:  7.0+
"        Author:  Frank Milde (fm), frank.milde (at) posteo.de
"  Organization:  
"       Version:  2.0
"       Created:  Sat Nov 08 13:24:07 2014
"      Revision:  Fri Nov 14 14:42:53 2014
"       License:  Copyright (c) 2014, Frank Milde
"===========================================================================

"=== pre-setup ==={{{
if has('vim_starting')
	set nocompatible " Be iMproved
	set runtimepath+=~/.vim/bundle/neobundle.vim/ " NeoBundle, required
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

filetype plugin indent on " NeoBundle, required
NeoBundleCheck " NeoBundle, required

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
        let g:make = 'make'
endif
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': g:make}}
"}}}

"=== stand alone bundles === {{{
NeoBundle 'tpope/vim-surround'
NeoBundle 'jamessan/vim-gnupg'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'fatih/vim-go'
NeoBundle 'https://bitbucket.org/abudden/taghighlight'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'frankMilde/customized-c-support'
NeoBundle 'frankMilde/customized-awk-support'
"}}}

"=== general settings === {{{
set nocompatible              " use vim defaults
set browsedir=current         " which directory to use for the file browser
set iskeyword+=:,_,$,%,#,@ 		" use for LaTeX, uncomment line 317 as well
"set iskeyword+=#					    " use for c++ programming
set whichwrap=b,s,h,l,<,>,[,]	" move freely between files
set wildmenu									" show some autocomplete options in status bar
set wildignore=*.o,*.obj,*.exe,*~
set wildmode=list:longest,full
set display+=lastline	"show whole paragraph
set visualbell t_vb= 	" turn off error beep/flash
set novisualbell      " turn off visual bell
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
au FocusLost * :wa		" always save when tabbing away from vim
set showcmd	          " display incomplete commands
set ruler  	          " show the cursor position all the time
set number            " show line numbers
set title             " show title in console title bar
set ttyfast           " smoother changes
set ls=2              " always show status line

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"}}}

" === air-line (bundle) === {{{
set encoding=utf-8
set t_Co=256

" https://github.com/bling/vim-airline/blob/master/doc/airline.txt
NeoBundle 'bling/vim-airline'

" when only one tab is open, show all of the open buffers:
let g:airline_powerline_fonts = 1

let g:airline_theme             = 'badwolf'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

" dict of configurably unicode symbols.
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_alt_sep      = '⮁'
"let g:airline_right_alt_sep     = '⮃'
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'PASTE'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = ''

let g:airline#extensions#default#layout = [
\ [ 'a', 'b', 'c' ],
\ [ 'x', 'y', 'z']
\ ]
"\ [ 'x', 'y', 'z', 'warning' ]
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
" enable/disable fugitive/lawrencium integration >
let g:airline#extensions#branch#enabled = 1
" change the text for when no branch is detected >
let g:airline#extensions#branch#empty_message = ''

let g:airline = 1
" }}}
" === bash-support (bundle) === {{{
NeoBundle 'frankMilde/customized-bash-support'
"let g:BASH_AuthorName   = ''
"let g:BASH_AuthorRef    = ''
"let g:BASH_Email        = ''
"let g:BASH_Company      = ''
"}}}
"=== bufOnly and bufferlist (bundle) ==={{{
NeoBundle 'schickling/vim-bufonly'

:set switchbuf=usetab,newtab,useopen
map :bo  BufOnly<CR> "closes all buffers except the current one

NeoBundle 'roblillack/vim-bufferlist'

map <silent> <F3> :call BufferList()<CR>

let g:BufferListWidth = 25
let g:BufferListMaxWidth = 50
hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold
hi BufferNormal term=NONE ctermfg=darkcyan ctermbg=black cterm=NONE

" remove the buffer limit when yank to copy and past in VIM the 'option is
" used to specify how many files for which you save marks (a-z).  The <
" option controls how many lines are saved for each of the registers.
set viminfo='100,<500,s10
"}}}
" === clipboard ==={{{
" doesn't work yet. Requires rebuild with features clipboard, see
" https://blog.dbrgn.ch/2012/10/23/recompile-vim-on-arch-linux/
" https://bbs.archlinux.org/viewtopic.php?id=142179
" set clipboard=unnamed
" if has('unnamedplus')
"   set clipboard=unnamed,unnamedplus
" endif
" }}}
"=== color scheme === {{{
set background=dark    " adapt colors for background

" Installed colors in your system can be found under 
" /usr/share/vim/vimfiles/colors
" Nice color schemes are
"colorscheme darkzen
"colorscheme elflord
"colorscheme desert
"colorscheme symfony
"colorscheme herald
"colorscheme vividchalk
"colorscheme shittles_dark
"colorscheme wombat_25
"colorscheme lilydjawg_dark
"colorscheme custom_molokai

NeoBundle 'tomasr/molokai'
colorscheme molokai

" This is a slight modification of the Molokai color scheme
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=202 ctermbg=236    cterm=bold
   hi Identifier      ctermfg=208                cterm=bold
   hi VisualNOS                   ctermbg=94
   hi Visual                      ctermbg=130	
   hi Comment         ctermfg=61
   hi CursorLine                  ctermbg=237   cterm=none
   hi CursorColumn                ctermbg=237
   hi LineNr          ctermfg=250 ctermbg=234
"
	 "markdown highlights
   hi markdownCode     ctermbg=237   cterm=none  
	 hi markdownBold                              cterm=bold
"end

if &term =~ "xterm\\|rxvt"
	" use an orange cursor in insert mode
	let &t_SI = "\<Esc>]12;blue\x7"
	" use a red cursor otherwise
	let &t_EI = "\<Esc>]12;green\x7"
	silent !echo -ne "\033]12;green\007"
	" reset cursor when vim exits
	autocmd VimLeave * silent !echo -ne "\033]112\007"
	" use \003]12;gray\007 for gnome-terminal
endif
"}}}
"=== easymotion (bundle) === {{{
NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '\'
"}}}
"=== file recognition === {{{
filetype on
filetype indent on
filetype plugin on

" assume bashscript syntax highlighting for files with no extension
autocmd BufNewFile,BufRead * if &ft == '' | set ft=sh | endif

" gnuplot files
autocmd BufNewFile,BufRead *.gnu set ft=gnuplot
autocmd BufNewFile,BufRead *.plot set ft=gnuplot
autocmd BufNewFile,BufRead *.plt set ft=gnuplot
autocmd BufNewFile,BufRead *.gnuplot set ft=gnuplot


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
autocmd BufNewFile,BufRead *.eml set noautoindent
autocmd BufNewFile,BufRead *.eml set spell
autocmd BufNewFile,BufRead *.eml set spelllang=en_us,de
autocmd BufNewFile,BufRead *.eml set textwidth=70
autocmd BufNewFile,BufRead *.eml set fileencodings=iso8859-1,utf-8
autocmd BufNewFile,BufRead *.eml iabbr vllt vielleicht
autocmd BufNewFile,BufRead *.eml iabbr vg Viele Grüße,<CR>Frank
"}}}
"=== file explorer ==={{{
"let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1      " preview window shown in a vertically split
let g:netrw_winsize=20		 " when you preview the new file takes up 80% and the file explorer the other 20%
"}}}
"=== folds === {{{
set foldmethod=marker " this lets us put the marker in the file so that it can be shared across and stored in version control.
set foldmarker={,}    " this lets us put the marker in the file so that it can be shared across and stored in version control.
"set foldmethod=syntax " uses syntax for folding
"set foldmethod=indent " uses indendt for folding
set foldlevel=0       " default fold level, all open, set it 200 or something to make it all closed.
"}}}
"=== indent === {{{
set autoindent     " always set autoindenting on
set smartindent    " smart indent
set cindent        " cindent
"set noautoindent
"set nosmartindent
"set nocindent
"}}}
" === invisible characters ==={{{
" Shortcut to rapidly toggle `set list`
nmap ,l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"}}}
"=== keyboard mappings === {{{
nnoremap <F12> :make<CR>
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

" Navigate the pop-up menu of the word completion with j and k
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

" German Umlaute
imap ae ä
imap AE Ä
imap oe ö
imap OE Ö
imap ue ü
imap UE Ü
imap sss ß

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
cmap Set set

"Common typos
imap teh the

"Type dts in insert mode to expand to a date stamp output a string like 'Mon May 04 11:01:58 2009'.
:iab <expr> dts strftime("%a %b %d %T %Y")
"}}}
"=== laTeX (bundle)=== {{{
NeoBundle 'frankMilde/customized-latex-support'

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
" all the figure labels. Very useful! }
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
"=== plugins to look into ==={{{
"https://github.com/SirVer/ultisnips

"https://launchpad.net/rubber/
"NeoBundle 'tpope/vim-fugitive'
"https://github.com/Rip-Rip/clang_complete
"http://www.cgtk.co.uk/vim-scripts/taghighlight/install-guide

"http://www.farseer.cn/config/2013/08/02/replace-deprecated-vim-plugins-with-modern-alternatives/
"https://code.google.com/p/go-wiki/wiki/IDEsAndTextEditorPlugins
"https://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
"
" http://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/
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
"=== print options === {{{
"set printdevice=mark
"set printoptions=number:y,portrait:y,paper:A4
"prints with linenumbers, landscape, on A4 paper "you can print using :hardcopy

"function! Hardcopy()
"	hardcopy > temp.ps
"	exec 'call system("lpr -o number-up=2 -o sides=two-sided-long-edge temp.ps")'
"	exec 'call system("rm temp.ps")'
"endfunction
"}}}
"=== screen === {{{
"if running in screen, screen will change the term variable to $TERM=screen,
"which is not recognized by vim, so we change it:
if match($TERM, "screen")!=0
	"set term=urxvt
	  set term=st-256color
	  "set term=uxterm-256color
	endif
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
"=== spell checking === {{{
"set nospell 							" spell checking is off
set spell									" spell checking is on
"set spelllang=en_us
"set spelllang=de
set spelllang=de,en_us
set spellsuggest=double,10
"set syntax spell

"set dictionary+=/usr/share/dict/words
"set dictionary+=/usr/share/dict/de-en.txt
"}}}
" === syntastic (bundle) === {{{
NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 0
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = " -std=c++11"
if has("unix")
let g:syntastic_error_symbol = "█"
let g:syntastic_style_error_symbol = ">"
let g:syntastic_warning_symbol = "█"
let g:syntastic_style_warning_symbol = ">"
else
let g:syntastic_error_symbol = "X"
let g:syntastic_style_error_symbol = ">"
let g:syntastic_warning_symbol = "!"
let g:syntastic_style_warning_symbol = ">"
endif
"}}}
"=== tab handling === {{{
set tabpagemax=30	"max number of open tabs

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
"}}}
"=== tabular (bundle) ==={{{
NeoBundle 'godlygeek/tabular'

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
"=== tags === {
"This will look in the current directory for "tags", and work up the tree
"towards HOME until one is found. IOW, you can be anywhere in your source
"tree instead of just the root of it.
set tags=tags;$HOME
set tags+=~/.vim/tags/cpp
"set tags=./tags;/ 				"looks up till root directory

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>	"Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>			"Open the definition in a vertical split
"}
"=== tagbar (bundle) ==={{{
NeoBundle 'majutsushi/tagbar'

nnoremap <silent> <F2> :TagbarToggle<CR>         " open/closes tagbar
inoremap <silent> <F2><ESC> :TagbarToggle<CR>
"nnoremap <silent> <F2> :TagbarTogglePause<CR>  " freezes tagbar to current file
"noremap <F2> :TagbarToggle<CR>
"inoremap <F2> <ESC>:TagbarToggle<CR>

"This will look in the current directory for "tags", and work up the tree
"towards HOME until one is found. IOW, you can be anywhere in your source
"tree instead of just the root of it.
set tags=tags;$HOME
set tags+=~/.vim/tags/cpp
"set tags=./tags;/ 				"looks up till root directory

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>	"Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>			"Open the definition in a vertical split


let g:tagbar_type_vimwiki = {
            \ 'ctagstype' : 'wiki',
            \ 'kinds'     : [
            \ 'h:headers'
            \ ]
            \ }
let g:tagbar_type_mkd= {
            \ 'ctagstype' : 'md',
            \ 'kinds' : [
            \ 'h:headings'
            \ ],
            \ 'sort' : 0,
            \ }
let g:tagbar_type_css= {
            \ 'ctagstype' : 'css',
            \ 'kinds' : [
            \ 'c:classes',
            \ 'i:ids',
            \ 't:tags',
            \ 'm:media',
            \ 'f:fonts',
            \ 'k:keyframes'
            \ ],
            \ 'sort' : 0,
            \ }
let g:tagbar_type_html= {
            \ 'ctagstype' : 'html',
            \ 'kinds'     : [
            \ 'i:ids',
            \ 'c:classes',
            \ ]
            \ }
let g:tagbar_type_vhdl = {
            \ 'ctagstype': 'vhdl',
            \ 'kinds' : [
            \'d:prototypes',
            \'b:package bodies',
            \'e:entities',
            \'a:architectures',
            \'t:types',
            \'p:processes',
            \'f:functions',
            \'r:procedures',
            \'c:constants',
            \'T:subtypes',
            \'r:records',
            \'C:components',
            \'P:packages',
            \'l:locals'
            \]
            \}
"requires gotags (similar to ctags) via
"go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
"}}}
"=== text layout ==={{{
set wrap
set formatprg=par\ -w76
set textwidth=76
set fo+=t
" Macro to show lines that are longer than 80 characters
" With the autocmds it works on more than one buffer
augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=black guibg=#111111
	autocmd BufEnter * match OverLength /\%>76v.\+/
augroup END
" alternative macro to highlight overlength
"set colorcolumn=+1   " shows a red line at 81 characters
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" calling Format will change double spaces into single spaces (double spaces
" occurr, when joining lines with J).
" It will also format all tabs to spaces
function! Format()
	:% s/\.  \(.\)/. \1/
	:% s/\(\<\w\+\>\)\_s*\1/\1/
	:% s/\(\<\w\+\>\)\_s*\1/\1/
	exec "set expandtab"
	exec "retab"
endfunction
"}}}
"=== un-impaired (bundle) === {{{
NeoBundle 'tpope/vim-unimpaired'

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
" }}}
"=== word highlights === {{{
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|BUG\|REMARK\|TRICKY\|WARNING\|WORKAROUND\|DEBUGGING', -1, 24)
augroup END

syn match TmlDoubleWords /\c\<\(\S\+\)\_s\+\1\ze\_s/
hi def link TmlDoubleWords ToDo
"}}}
"=== vim-clang-format (bundle) ==={{{
NeoBundle 'rhysd/vim-clang-format'

" for possible options see
" http://clang.llvm.org/docs/ClangFormatStyleOptions.html
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "AlwaysBreakAfterDefinitionReturnType" : "true",
            \ "Standard" : "C++11",
            \ "ColumnLimit" : "76",
            \ "BreakBeforeBraces" : "Attach"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
"}}}
"=== autocomplete brackets (not used) ==={{{
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
""
"vnoremap ( s()<Esc>P
"vnoremap [ s[]<Esc>P
"vnoremap { s{}<Esc>P
"}}}
