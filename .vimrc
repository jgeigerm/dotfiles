call pathogen#infect()
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

" Folding
set foldenable " Turn on folding
set foldmethod=indent " Fold on the indent (damn you python)
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
function SimpleFoldText() " {
    return getline(v:foldstart).' '
endfunction " }
set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)
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
"set cmdheight=1         " Set the commandbar height -- default
set showtabline=2       " Display tab line even if single file opened
set guitablabel=%t      " Display buffer name on tab label
"set nohidden            " When I close a tab, remove from buffer
set tm=500              " Set tooltip menu

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
set nowrap              " Do not wrap lines
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

set clipboard^=unnamed  " Share Window's clipboard
set formatoptions=rw    " Automatically insert command leader on return and let gq format comments
set shiftround          " When at 3 spaces and hit > ... go to 4, not 5

set hidden
set novisualbell
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

function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
set cursorline
hi cursorline ctermbg=234

if &term =~ '^xterm'
    " solid underscore
    let &t_SI .= "\<Esc>[0 q;"
    " solid block
    let &t_EI .= "\<Esc>[3 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
endif
