"TODO: ORGANIZE
"      Check OS and apply settings based on that
set nocompatible
filetype off

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

"========================================================================= }}}
 " Vundle Bundles {{{1
"============================================================================

" Required Plugins
Bundle 'gmarik/vundle'

" Bundles
"Invoke with :Tab /<regex> and this will align things for you!
Bundle 'godlygeek/tabular'
"python extensions: <ldr>b for breakpoint
Bundle 'klen/python-mode' 
"pound searches for other instances of word under cursor, <leader>* does something too
Bundle 'nelstrom/vim-visual-star-search'
"file browser mapped to <leader>n
Bundle 'scrooloose/nerdtree'
"for repeating non native commands with .
Bundle 'tpope/vim-repeat'
"for adding and subtracting dates
Bundle 'tpope/vim-speeddating'
"good for changing quotes and stuff cs, ds
Bundle 'tpope/vim-surround'
"Quote and brace auto-closer, nice
Bundle 'Raimondi/delimitMate'
"Bundle 'Townk/vim-autoclose'
"js addons
"Bundle 'pangloss/vim-javascript'
"Bottom toolbar
Bundle 'bling/vim-airline'
"Top buffer toolbar
Bundle 'bling/vim-bufferline'
"Puppet stuff
"Bundle 'puppetlabs/puppet-syntax-vim'
"framework for code errors and checking in file
Bundle 'scrooloose/syntastic'
"quick markup, will learn someday, off for now
"Bundle 'tristen/vim-sparkup'
"json utils
"Bundle 'elzr/vim-json'
"little utils that make everything smoother
Bundle 'MarcWeber/vim-addon-mw-utils'
"random library functions to make stuff easier
"Bundle 'tomtom/tlib_vim'
"python autocompletion and documentation
Bundle 'davidhalter/jedi-vim'
"git integration :G<command>
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
"powershell stuff
Bundle 'PProvost/vim-ps1'
""break bad arrowing habits
Bundle 'takac/vim-hardtime'
"Move around easier in a file with \ (w, s)
Bundle 'Lokaltog/vim-easymotion'
"stuff expansion!
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'tpope/vim-dispatch'
Bundle 'vim-scripts/tpp.vim'
Bundle 'sjl/vitality.vim'
"All of the colors
Bundle 'flazz/vim-colorschemes'
"neat visuals on undoing stuff, mapped to <ldr>u
Bundle 'mbbill/undotree'
"Autocompletes
if filereadable(expand('$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_client_support.so'))
    Bundle 'Valloric/YouCompleteMe'
    let g:ycm_auto_trigger = 1
    let g:ycm_filetype_whitelist = { '*': 1 }
    let g:ycm_warning_symbol = '!!'
    let g:ycm_min_num_of_chars_for_completion = 3
    let g:ycm_global_ycm_extra_conf = expand('$HOME/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py')
    let g:ycm_enable_diagnostic_highlighting = 0
else
    if has('Lua') and !has('macunix')
        Bundle 'Shougo/neocomplete.vim'
        nnoremap <leader>c :NeoCompleteDisable!<CR>

        " Use neocomplete.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
        let g:neocomplete#enable_auto_select = 1
        let g:neocomplete#max_keyword_width = 75
        let g:neocomplete#auto_completion_start_length = 4
        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
        "return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplete#close_popup()
        inoremap <expr><C-e>  neocomplete#cancel_popup()
    endif
endif

filetype plugin indent on
colorscheme charged-256

syntax on
" Enable mouse support in console
if has('mouse')
    set mouse=a
    if (&term =~ "xterm" || &term =~ "screen" || &term =~ "urxvt")
        " for some reason, doing this directly with 'set ttymouse=xterm2'
        " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
        " makes tmux enter copy mode instead of selecting or scrolling
        " inside Vim -- but luckily, setting it up from within autocmds
        " works
        autocmd VimEnter * set ttymouse=xterm2
        autocmd FocusGained * set ttymouse=xterm2
        autocmd BufEnter * set ttymouse=xterm2
    endif
endif

set backup              " Keep backup file after overwriting a file
set backupdir=~/.vim-bak/backup
set swapfile            " Allow creation of .swp swap files
set writebackup         " Make a backup file before overwriting a file
if exists('+undofile')  " Have Vim save undo history to file and restore it on open
    set undofile
endif
" From Erik Harmon's vimrc
" Cache things to our homedir, not random places
if isdirectory(expand('$HOME/.vim-bak'))
    if &directory =~# '^\.,'
       set directory^=$HOME/.vim-bak/swap//
    endif
    if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
        set undodir^=$HOME/.vim-bak/undo//
    endif
endif

" Newish
set history=9999 " big old history
set timeoutlen=300 " super low delay (works for me)
set formatoptions+=n " Recognize numbered lists
set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s* "and bullets, too
set viminfo+=! " Store upper-case registers in viminfo
set nomore " Short nomore

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer



""" relativenumber is a Vim 7.3 option
""" If the option doesn't exist, fall back to just absolute line numbers
if exists('+relativenumber') && (version >= 704) || (version == 703) && has("patch1115")
    set relativenumber  " Display how far away each line is from the current one by default
    set number          " When used with relativenumber, the absolute line of the current

elseif exists('+relativenumber')
    set relativenumber  "Display how far away each line is from the current one by default

    " Switch to absolute line numbers whenever Vim loses focus
    autocmd FocusLost * :set number
    autocmd FocusGained * :set relativenumber

    " Use absolute line numbers when in insert mode and relative numbers when in normal mode
    autocmd InsertEnter * :set norelativenumber | set number
    autocmd InsertLeave * :set relativenumber

else
    set number          " Show absolute line numbers
endif

set title               " Show title in console title bar
set guioptions=em       " e ensures tab bar is displayed in GUI; m ensures menu bar is displayed
set showcmd             " Display commands as they are typed
set cmdheight=1         " Set the commandbar height -- default
set showtabline=0       " Display tab line even if single file opened
set guitablabel=%t      " Display buffer name on tab label
set nohidden            " When I close a tab, remove from buffer
set tm=500              " Set tooltip menu
let mapleader = ","

set ttyscroll=0         " Number of lines to scroll; 0 for terminals where scrolling is slow and redrawing is fast
set ttyfast             " Fast terminal connection; more chars will be sent to screen for redrawing
set nostartofline       " Do not jump to first character with page navigation commands

set encoding=utf-8      " Default to UTF-8 encoding
set termencoding=utf-8
set fileencoding=utf-8
set fileformats=unix,dos,mac    " Default file formats

"set cindent             " No need to set cindent since it is automatic for C-based files
"set smartindent         " Smartindent: auto inserts one extra level of indentation for C-like files.
set autoindent          " Autoindent: auto indents a new line to the same indentation used by previous line
set wrap              " wrap lines
"set tw=500              " Word wrapping text width
set linespace=0         " Don't insert any extra pixel lines between rows
set linebreak

set expandtab           " Default tabs into spaces
set shiftwidth=4        " Auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=4       " When hitting a tab or backspace- spaces should a tab should be
set tabstop=8           " Vim's default tabstop is 8
set smarttab            " A <Tab> in front of a line inserts blanks according to settings; <BS> deletes a shiftwidth

set ignorecase          " Ignore case when searching
set smartcase           " If there are caps, go case-sensitive
set infercase           " Case inferred by default
set hlsearch            " Highlight search things
set incsearch           " Make search act like search in modern browsers

set showmatch           " Show matching brackets
set matchtime=1         " How many tenths of a second to show matching paren with showmatch set
let g:matchparen_insert_timeout=5   " Default is 60 will lag for extremely large files

set magic               " Set magic on, for regular expressions
set grepprg=/bin/grep\ -nH  " Vim grep

set esckeys             " Function keys that start with <Esc> are recognized in insert mode
set list                " List mode: show special characters -- what is displayed is changed by listchars
set listchars=tab:>-,trail:-    ",eol:¬ or eol:$
" Display tabs to know we put them/ where we want them

"set clipboard^=unnamed  " Share Window's clipboard
set formatoptions=rw    " Automatically insert command leader on return and let gq format comments
set shiftround          " When at 3 spaces and hit > ... go to 4, not 5

set visualbell
set noerrorbells
set wildmenu                    " Turn on wild menu
set wildmode=list:longest,full  " Turn on wild mode huge list
set wildchar=<TAB>              " Path/file expansion in colon mode
set ruler
" Use english for spellchecking, but don't spellcheck by default
if version >= 700
    set spl=en spell
    set nospell
endif

syn sync fromstart
set foldmethod=syntax
set foldlevel=20
set foldnestmax=10

" Ignore this list of file extensions
" wildignore extended from Erik Harmon's ignore list
set wildignore=*.bak
set wildignore+=*.sw?                               " Vim swap files
set wildignore+=*.DS_Store                          " OS X bullshit
set wildignore+=*.spl                               " Compiled spelling word lists
set wildignore+=*.bmp,*.gif,*.jpg,*.jpeg,*.png      " Binary images
set wildignore+=.hg,.git,.svn                       " Version control
set wildignore+=*.orig                              " Merge resolution files
set wildignore+=*.dll,*.exe,*.o,*.obj,*.manifest    " Compiled object files
set wildignore+=*.pyc                               " Python byte code
set wildignore+=migrations                          " Django migrations
set wildignore+=*.luac                              " Lua byte code
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
set cursorline
set cursorcolumn
hi cursorline ctermbg=234
hi cursorcolumn ctermbg=234

:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" ========================================================================= }}}
"  Filetype Association {{{1
" ============================================================================

au BufRead,BufNewFile *.pp
    \ set filetype=puppet
au BufWritePost ~/.bashrc !source %
au BufRead,BufNewFile *_spec.rb
    \ nmap <F8> :!rspec --color %<CR>
augroup PatchDiffHighlight
autocmd!
autocmd BufEnter *.patch,*.rej,*.diff syntax enable
au BufRead,BufNewFile *.c set filetype=c
augroup END


autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|     endif

nmap <Space> za

" Syntax optimazations
syntax sync minlines=256

" ========================================================================= }}}
"  Plugin Settings {{{1
" ============================================================================
" Airline Settings {{{2
" ----------------
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='serene'
let g:airline_left_sep = '|'
"let g:airline_left_alt_sep = ''
let g:airline_right_sep = '|'
"let g:airline_right_alt_sep = ''
" }}}
" Vim Session Persist {{{2
" -------------------
let g:session_autosave = 1
let g:session_autoload = 1
" }}}
" Snippets Variables {{{2
" ------------------
let g:snips_author = 'Jaime Geiger'
" }}}
" NERDTree {{{2
" --------
let NERDTreeIgnore=['\.pyc$']
" }}}
" Python Mode Settings {{{2
" --------------------
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_onfly = 0
let g:pymode_folding = 1
let g:pymode_lint_ignore = "E501,E701,E401,E201,E202,E302"
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_run_bind = '<leader>R'
let g:pymode_options_max_line_length = 0
" }}}

" Jedi-Vim Settings
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_select_first=0
let g:jedi#popup_on_dot = 0
autocmd  FileType python let b:did_ftplugin = 1
autocmd FileType python setlocal completeopt-=preview

" NERDTreeToggle {{{2
" --------------
function! NERDTreeToggleOrFocus()

    if expand("%") =~ "NERD_tree"
        :NERDTreeToggle
    else
        call NERDTreeFocus()
    endif
endfunction
nmap <leader>n :call NERDTreeToggleOrFocus()<CR>
set backspace=2
set encoding=utf-8

nmap <leader>. :tabn<CR>
nmap <leader>m :tabp<CR>
nmap <leader>q :tabc<CR>
nmap <leader>t :tabnew<CR>
nnoremap <leader>s :set nospell!<CR>
nnoremap <leader>p :set nopaste!<CR>
nnoremap <leader>u :UndotreeToggle<CR>
map \ <Plug>(easymotion-prefix)


let g:UltiSnipsExpandTrigger="<C-g>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<C-a>"

set colorcolumn=80
highlight ColorColumn ctermbg=0
