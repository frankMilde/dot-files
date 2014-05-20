" LaTeX filetype plugin
" Language:     LaTeX (ft=tex)
" Maintainer:   Benji Fisher, Ph.D. <benji@member.AMS.org>
" Version:	1.4
" Last Change:	Wed 19 Apr 2006
"  URL:		http://www.vim.org/script.php?script_id=411

" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

" Start with plain TeX.  This will also define b:did_ftplugin .
source $VIMRUNTIME/ftplugin/plaintex.vim

" Avoid problems if running in 'compatible' mode.
let s:save_cpo = &cpo
set cpo&vim

let b:undo_ftplugin .= "| setl inex<"

" Allow "[d" to be used to find a macro definition:
" Recognize plain TeX \def as well as LaTeX \newcommand and \renewcommand .
" I may as well add the AMS-LaTeX DeclareMathOperator as well.
let &l:define .= '\|\\\(re\)\=new\(boolean\|command\|counter\|environment\|font'
	\ . '\|if\|length\|savebox\|theorem\(style\)\=\)\s*\*\=\s*{\='
	\ . '\|DeclareMathOperator\s*{\=\s*'

" Tell Vim how to recognize LaTeX \include{foo} and plain \input bar :
let &l:include .= '\|\\include{'
" On some file systems, "{" and "}" are inluded in 'isfname'.  In case the
" TeX file has \include{fname} (LaTeX only), strip everything except "fname".
let &l:includeexpr = "substitute(v:fname, '^.\\{-}{\\|}.*', '', 'g')"

" The following lines enable the macros/matchit.vim plugin for
" extended matching with the % key.
" ftplugin/plaintex.vim already defines b:match_skip and b:match_ignorecase
" and matches \(, \), \[, \], \{, and \} .
if exists("loaded_matchit")
  let b:match_words .= ',\\begin\s*\({\a\+\*\=}\):\\end\s*\1'
endif " exists("loaded_matchit")

let &cpo = s:save_cpo

let g:Tex_Env_section = "\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% section \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\\section{<++>}<++>\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% section \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR><++> "

" vim:sts=2:sw=2:

"Franks change Mon Jan 25 18:21:31 2010
"setlocal efm+=%E%f:%l:\ %m
":call IMAP('EAL', "\\begin{align}\<CR><++> &= <++>\\nt\\\\\<CR><++> &= <++>\<CR>\\label{eq:<++>}\<CR>\\end{align}<++>", 'tex')
:call IMAP('EAL', "\\begin{align}\<CR><++> &= <++>,\\nt\\\\\<CR><++> &= <++>,\\nt\\\\\<CR><++> &= <++>\<CR>\\label{eq:<++>}\<CR>\\end{align}<++>", 'tex')
"Framed Equation
:call IMAP('FEQ', "\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% Equation \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\\begin{FramedEqn}\<CR><++>\\nt\<CR>\\end{FramedEqn}\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% Equation \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\<CR>\\noindent\<CR><++> ", 'tex')
"Colorbox
:call IMAP('CB', "\\begin{center}\<CR>\\colorbox{hellgrau}{\<CR>\\begin{minipage}{0.9\\linewidth}\<CR>\\emph{<++>}\<CR>\\end{minipage}\<CR>}\<CR>\\end{center}\<CR><++> ", 'tex')
:call IMAP('INT', "\\int{\\!\\! \\dd^{<++>}\\;\\;<++>} ", 'tex')
:call IMAP('{}', "{ <++> } <++> ", 'tex')
:call IMAP('LR', "\\left( <++> \\right) <++>", 'tex')
:call IMAP('`w', '\\omega', 'tex')
:call IMAP('`W', '\\Omega', 'tex')
:call IMAP('EQR', "Eq.\~\\eqref{eq:<++>} <++>", 'tex')
:call IMAP('FIGR', "Fig.\~\\ref{fig:<++>} <++>", 'tex')
:call IMAP('REF', "Ref.\~\\cite{<++>} <++>", 'tex')
:call IMAP('CITE', "[\\cite{<++>}] <++>", 'tex')
:call IMAP('qm', "quantum", 'tex')
"Own figure env 1
:call IMAP('EF', "\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% Start Figure \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\\begin{figure}[tb!]\<CR>\\begin{center}\<CR>\\includegraphics[width=\\textwidth]{figures\/<++>.pdf}\<CR>\\caption[<++>]{<++>}\<CR>\\label{fig:<++>}\<CR>\\end{center}\<CR>\\end{figure}\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\%  End Figure  \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR><++> " ,'tex')
"Own figure env 2 with side caption
:call IMAP('CF',"\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% Start Figure \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\\captionstyle{normal}\<CR>\\begin{figure}[tb!]\<CR>\\begin{minipage}{0.618\\textwidth}\<CR>\\begin{center}\<CR>\\includegraphics[width=0.7\\textwidth]{figures\/<++>.pdf}\<CR>\\end{center}\<CR>\\end{minipage}\<CR>\\begin{minipage}{0.382\\textwidth}\<CR>\\begin{center}\<CR>\\caption[<++>]{<++>}\<CR>\\label{fig:<++>}\<CR>\\end{center}\<CR>\\end{minipage}\<CR>\\end{figure}\<CR>\\captionstyle{hang}\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\%  End Figure  \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR><++> ", 'tex')

:call IMAP('WF',"\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\% Start Figure \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\\begin{warpfigure}[15]{rH}{0.45\\textwidth}\<CR>\\includegraphics[width=0.45\\textwidth]{figures\/<++>.pdf}\<CR>\\caption[<++>]{<++>}\<CR>\\label{fig:<++>}\<CR>\\end{wrapfigure}\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR>\%\%\%  End Figure  \%\%\%\<CR>\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\%\<CR><++> ", 'tex')


