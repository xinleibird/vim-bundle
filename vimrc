" MIT License. Copyright (c) 2013 Xin Lei. <xinleibird@gmail.com>
" vim: et ts=4 sts=4 sw=4


" Environment {{{
" ===========

" Basics
" ------
set nocompatible                        " NO compatible vi

if v:progname=~?"evim"
    finish
endif

" Setup pathogen support
" ----------------------
runtime bundle/Pathogen/autoload/pathogen.vim

if $TERM == 'linux'
    let g:pathogen_disabled = ["LightLine", "LightLineExtension"]
else
    let g:pathogen_disabled = ["StatLine"]
    if has("win32")
        let g:pathogen_disabled = ["Fcitx"]
    endif
endif
execute pathogen#infect()
execute pathogen#interpose('bundle/Html5')
execute pathogen#interpose('bundle/Util')

" }}}

" Encoding {{{
" ========

" encoding
" --------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileformats=unix,dos,mac
set fileformat=unix
set nobomb

" }}}

" General {{{
" =======

" No menu, no scroll bar
" ----------------------
if has("gui_running")
    set guiheadroom=0
    set guioptions=agi
endif

" Other
" -----
if &t_Co > 2 || has("gui_running")
    syntax on                           " syntax
    set hlsearch                        " search highlight
endif

set incsearch                           " real time search

if has('mouse')
    set mouse=a                         " all mode
    set mousehide                       " hide mouse when typing
endif

set history=500                         " history
set nobackup
set backspace=indent,eol,start          " backspace delete
set ruler                               " ruler
set number                              " line number
set showcmd                             " cmd complete

" Ignore file type
" ----------------
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,tags,tags-cn

" }}}

" Vim Appearance {{{
" ======

" Windows possion
" ---------------
if has("win32") && has("gui_running")
    winpos 17 21
    set lines=51 columns=232
endif

" Font
" ----
if has("gui_running")
    if has("win32")
        set guifont=Consolas:h11
        set guifontwide=XHei_Nokia_Mono:h10
    else
        set guifont=Consolas\ 12
    endif
endif

" Color scheme
" ------------
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
    set background=dark
    colorscheme jellybeans
    let g:jellybeans_background_color_256 = "None"
endif

if has("gui_running")
    set background=light
    colorscheme github
endif

if &term is# "linux"
    set background=dark
    colorscheme jellybeans
    let g:jellybeans_use_lowcolor_black = 0
endif

syntax enable

" }}}

" Formatting {{{
" ==========

" Normal
" ------
set confirm                             "set confirm
set iskeyword+=_,$,@,%,#,-
set showmatch
set matchtime=5

" Indent
" ------
set autoindent
set smartindent
set cindent
filetype plugin indent on               "indent

" Tab
" ---
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Undo
" ----
if has("persistent_undo")
    set undofile
    set undolevels=1000
    set undodir=~/.undodir
endif

" Fcitx setting
" -------------
if has("unix")
    set imdisable
endif

" Other
" -----
set wrap
set laststatus=2
set wildmenu
set autoread
set autowrite
set list
set listchars=tab:>-,extends:»,precedes:«,trail:\ ,nbsp:+
" }}}

" Key mapping {{{
" ===========

" Normal
" ------
noremap <silent> <leader>= <ESC>mRgg=G`R<ESC>

" Syntastic
" ---------
noremap <leader>st :SyntasticToggleMode<CR>

" Tagbar
" ------
noremap <silent> <F9> :TagbarToggle<CR>

" CtrlP
" -----
noremap <C-W><C-U> :CtrlPMRU<CR>
nnoremap <C-W>u :CtrlPMRU<CR>

noremap <C-W><C-B> :CtrlPBuffer<CR>
nnoremap <C-W>b :CtrlPBuffer<CR>

" Eclim
" -----
noremap <leader><leader><Enter> :JavaImportOrganize<CR>
noremap <F5> :ProjectRefresh<CR>

" Matchem
" -------
" imap <C-L> <Plug>MatchemSkipNext
" imap <C-J> <Plug>MatchemSkipAll
" let g:MatchemEndOfLineMapping = 1
" let g:MatchemExpandCrEndChars = ['}', ']', '>', ')']

" Zeal
" ----
nnoremap gz :!zeal --query "<cword>"&<CR> :redraw!<CR>

" Virtual search
vnoremap * y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap # y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" Winpos
nnoremap <silent> <C-Left> :winpos 17 21<CR>:set lines=51 columns=114<CR>
nnoremap <silent> <C-Up> :winpos 17 21<CR>:set lines=51 columns=232<CR>
nnoremap <silent> <C-Right> :winpos 961 21<CR>:set lines=51 columns=114<CR>

" }}}

" Plug-in global setting {{{
" ======================

" YouCompleteMe setting
" ---------------------
let g:ycm_key_list_select_completion = ['<TAB>', '<PageUp>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<PageDown>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_global_ycm_extra_conf =
            \ '/home/xinlei/.vim/bundle/YouCompleteMe/
            \third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'tree' : 1,
            \ 'mail' : 1
            \}

" Tagbar
" ------
let g:tagbar_width = 30
let g:tagbar_sort = 0
let g:tagbar_iconchars = ['▸', '▾']

" Syntastic
" ---------
let g:syntastic_error_symbol = "x"
let g:syntastic_warning_symbol = "!"

" Python highlighting
" -------------------
let python_highlight_all = 1
let python_space_error_highlight = 0
let b:python_version_2 = 1

" Tagbar setting
" --------------
let g:tagbar_type_rst = {
            \ 'ctagstype': 'rst',
            \ 'ctagsbin' : '/home/xinlei/.vim/bundle/Rst2Ctags/rst2ctags.py',
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
            \ 's:sections',
            \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
            \ 's' : 'section',
            \ },
            \ 'sort': 0,
            \ }

let g:tagbar_type_css = {
            \ 'ctagstype' : 'css',
            \ 'kinds' : [
            \ 'v:variables',
            \ 'c:classes',
            \ 'i:identities',
            \ 't:tags',
            \ 'm:medias'
            \ ]
            \}

let g:tagbar_type_less = {
            \ 'ctagstype' : 'css',
            \ 'kinds' : [
            \ 'v:variables',
            \ 'c:classes',
            \ 'i:identities',
            \ 't:tags',
            \ 'm:medias'
            \ ]
            \}

let g:tagbar_type_scss = {
            \ 'ctagstype' : 'css',
            \ 'kinds' : [
            \ 'v:variables',
            \ 'c:classes',
            \ 'i:identities',
            \ 't:tags',
            \ 'm:medias'
            \ ]
            \}

" Markdown2Ctags
" --------------
let g:tagbar_type_markdown = {
            \ 'ctagstype': 'markdown',
            \ 'ctagsbin' :
            \ '/home/xinlei/.vim/bundle/Markdown2Ctags/markdown2ctags.py',
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
            \ 's:sections',
            \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
            \ 's' : 'section',
            \ },
            \ 'sort': 0,
            \ }

" Ruby
" ----
let g:tagbar_type_ruby = {
            \ 'kinds' : [
            \ 'm:modules',
            \ 'c:classes',
            \ 'd:describes',
            \ 'C:contexts',
            \ 'f:methods',
            \ 'F:singleton methods'
            \ ]
            \ }

" Vim-markdown
" ------------
let g:markdown_fenced_languages = ["ruby", "python", "java", "sh", "c", "cpp",
            \ "vim"]

" CtrlP
" -----
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_use_caching = 1
let g:ctrlp_root_markers = ['.project']
let g:ctrlp_lazy_update = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
            \'dir':'
            \Video\|Music\|\Picture\|\.git\|\.hg\|\.svn\|_darcs\|\.bzr\|\.cdv\|\~\.dep\|
            \\~\.dot\|\~\.nib\|\~\.plst\|\.pc\|_MTN\|blib\|CVS\|RCS\|
            \SCCS\|_sgbak\|autom4te\.cache\|cover_db\|_build\|IntelGraphicsProfiles\|
            \Searches
            \',
            \'file':'
            \\~$\|#.+#$\|[._].*\.swp$\|core\.\d+$\|\.exe$\|\.so$\|\.bak$\|
            \\.png$\|\.jpg$\|\.jpeg$\|\.swf$\|\.gif$\|\.zip$\|\.rar$\|\.tar$\|
            \\.gz$\|\.bz2$\|\.jar$\|.7z$\|
            \\.xmi$\|\.class$\|\.classpath$\|\.project$\|\.svg$\|\.ico$\|\.bmp\|
            \\.pdf$\|\.out$\|\.chm$\|\.deb$\|\.fskin$\|\.ttf$\|\.dll$\|\.jnilib$\|\.dylib$\|
            \\.contact$\|.regtrans-ms$\|.blf$\|desktop.ini$\|.DAT\|.link\|ntuser.ini\|.url
            \'}

" CtrlP Matcher Settings
" ----------------------
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Java Highlight
" --------------
" let java_highlight_java_lang_ids=1
" let java_highlight_functions="style"

" Eclim
" -----
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimHtmlValidate=0
let g:EclimCssValidate=0
let g:EclimXmlValidate=0
let g:EclimPhpIndentDisabled=1
let g:EclimCssIndentDisabled=1
let g:EclimDtdIndentDisabled=1
let g:EclimXmlIndentDisabled=1
let g:EclimJavascriptIndentDisabled=1
let g:EclimHtmlIndentDisabled=1

" Php Indenting
" -------------
let g:PHP_default_indenting = 0

" Html Indenting
" --------------
let g:html_indent_inctags = "head,body,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" IndentGuides
" ------------
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" }}}

" Utility function {{{
" ================

" Windows maximum
" ---------------
function MaxinumGvimWindow()
    if has("gui_running")
        silent exec "!wmctrl -i -r " . v:windowid .
                    \ " -b add,maximized_vert,maximized_horz"
    endif
endfunction

" if has('gui_running') && !exists('s:loaded_maxinum_gvim_window')
"     let s:loaded_maxinum_gvim_window = 1
"     autocmd VimEnter * :call MaxinumGvimWindow()
" endif

" Eclim projects tree toggle
" --------------------------
function! ToggleEclimProjectsTree()
    if !exists('s:tree_loaded')
        let s:tree_loaded = 0
    endif
    if s:tree_loaded == 0
        :ProjectsTree
        if &ft == 'tree'
            let s:tree_loaded = 1
            :wincmd p
        else
            let avaiableEclim = eclim#EclimAvailable()
            if avaiableEclim
                echo "Please confirm the project is created already!"
            endif
        endif
    else
        call eclim#project#tree#ProjectTreeClose()
        let s:tree_loaded = 0
    endif
endfunction
nmap <silent> <F4> <ESC>:call ToggleEclimProjectsTree()<CR>

" Remove trailing whitespace
" --------------------------
function RemoveTrailingWhitespace()
    let b:curcol = col(".")
    let b:curline = line(".")
    silent! %s/\s\+$//
    silent! %s/\(\s*\n\)\+\%$//
    call cursor(b:curline, b:curcol)
endfunction
noremap <silent> <leader><Space> :call RemoveTrailingWhitespace()<CR>

" Gollum auto commit
" ------------------
function! AutoCommitGollum()
    :w
    !cd %:h && git add -A && git commit -m 'update'
    :redraw
endfunction

if has("autocmd") && !exists("s:loaded_markdown_make")
    let s:loaded_markdown_make = 1
    autocmd FileType markdown,rst
                \ command! -buffer Gollum :call AutoCommitGollum()
    autocmd FileType markdown,rst let &l:makeprg=
                \"cd %:h && git add -A && git commit -m 'update'"
endif

" OpenIt()
" -------------------
" function! OpenIt()
"     let file = expand('%:p')
"     let url = 'file://' . file
"     call eclim#web#OpenUrl(url)
" endfunction

" " Start
" if has("autocmd") && !exists("s:loaded_open_it")
"     let s:loaded_open_it = 1
"     autocmd FileType html,xhtml
"                 \ command! -complete=file -buffer Start :call OpenIt()
" endif

" }}}

" Auto Group {{{
" ==========

" Set conf filetype
" -----------------
if has("autocmd")
    augroup bufReadGroup
        autocmd!
        " set conf filetype
        autocmd BufNewFile,BufRead *.conf
                    \ if &ft =~# '^\%(conf\|modula2\)$' |
                    \   set ft=conf |
                    \ else |
                    \   setf conf |
                    \ endif
        autocmd! BufWritePre ~/.undodir/* setlocal noundofile
    augroup END
endif

" Astyle, autopep8, JavaFormat, ruby type, commentstring, colorcolumn, synmaxcol
" ------------------------------------------------------------------------------
if has("autocmd")
    augroup filetypeGroup
        autocmd!
        " autocmd FileType java setlocal
        "             \ equalprg=astyle
        "             \\ -A2s4CSLwYm2pHUyjcxy\ --mode=java
        autocmd FileType java
                    \ noremap <buffer> <leader><leader>= :%JavaFormat<CR>
        " autocmd FileType c,cpp setlocal
        "             \ equalprg=astyle
        "             \\ -A2s4CSNLwYm2M80pHUk3W3yjcxyxC80\ --mode=c
        autocmd FileType python setlocal
                    \ equalprg=autopep8\ --ignore=W191\ /dev/stdin
        autocmd FileType ruby,plantuml setlocal
                    \ tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType php,java,c,cpp setlocal cinoptions=l1j1
        autocmd FileType php,apache,conf,cfg,cmake,desktop,
                    \dnsmasq,gitconfig,gtkrc,upstart
                    \ setlocal commentstring=#\ %s
        autocmd FileType c
                    \ setlocal commentstring=//\ %s
    augroup END
endif

" Terminal ttimeout
" -----------------
if !has('gui_running')
    set ttimeoutlen=100
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Go to the last post when you open the buffer
" --------------------------------------------
if has("autocmd")
    augroup vimrcEx
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1
                    \ && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
endif

" MAYBE can improve performance....
" ---------------------------------
if has("autocmd")
    augroup performanceGroup
        autocmd!
        autocmd BufEnter * :syntax sync minlines=1024 maxlines=4096
    augroup END
endif

" }}}
