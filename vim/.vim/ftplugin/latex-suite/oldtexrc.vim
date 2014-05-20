TexLet g:Tex_CompileRule_bib = g:Tex_BibtexFlavor . ' $*'
" Set Tex_UseMakefile to 1 if you want to account for the presence of a Makefile
" when deciding how to compile
TexLet g:Tex_UseMakefile = 1

" NOTE: The values of g:Tex_Flavor and g:Tex_CompilerFlags are provided as a
"       way to make compiler/tex.vim standalone. i.e independent of the rest
"       of latex-suite. These variables are NOT used if you have already
"       defined g:Tex_CompileRule_dvi above.
"
" specifies the current latex flavor.
TexLet g:Tex_Flavor = 'latex'

" specifies the BibTeX flavor and if necessary options. If you use $* in this
" setting, it will be replaced by the *root* of the main file name, i.e, if
" the main file is "thesis.tex", $* will be "thesis".
TexLet g:Tex_BibtexFlavor = 'bibtex $*'

" specifies the MakeIndedx flavor and if necessary options. $* will be
" replaced by the *root* of the main file name. See above.
TexLet g:Tex_MakeIndexFlavor = 'makeindex $*.idx'

" By default the program described by g:Tex_Flavor above is called with the
" flags '--src-specials --interaction=nonstopmode'. If your particular version
" of latex does not accept these arguments, you will need to set this variable
" to the appropriate value.
" NOTE: leave commented for using the default flags.
" TODO: Is it necessary (or even desirable) to use 2 variables to specify a
"       flavor and flags seperately? --SA
" TexLet g:Tex_CompilerFlags = ''

" If disabled (set to 0) LaTeX-Suite doesn't go immediately to warnings or
" errors after compilation
TexLet g:Tex_GotoError = 1

" If set to 1, then latex-suite shows the context of the error in a preview
" window beneath the window showing the actual errors.
TexLet g:Tex_ShowErrorContext = 1

" Remove temp files created during part compilations when vim exits.
TexLet g:Tex_RemoveTempFiles = 1

" }}}
" ==============================================================================
" Project: how to deal with multi file projects via latex-suite {{{

" Use a valid vim expression here if you want to customize the way latex-suite
" searches for a master file from within another file.
"TexLet g:Tex_MainFileExpression = ''

" }}}
" ===================


