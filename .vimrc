"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"
"       KissAndRun
"" _    _                         _                  
"" | |  (_)                       | |                 
"" | | ___ ___ ___  __ _ _ __   __| |_ __ _   _ _ __  
"" | |/ / / __/ __|/ _` | '_ \ / _` | '__| | | | '_ \ 
"" |   <| \__ \__ \ (_| | | | | (_| | |  | |_| | | | |
"" |_|\_\_|___/___/\__,_|_| |_|\__,_|_|   \__,_|_| |_|
""                                                    
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""Plug Install list"""""""""""""""""""""""""""""
set nocompatible              " required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'hotoo/pangu.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-signify' "显示修改痕迹
"Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-projectionist' "待研究
Plug 'tpope/vim-surround' "待研究
Plug 'tpope/vim-unimpaired' "[ ]一系列快捷键 已经忘了
Plug 'skywind3000/asyncrun.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'python'] }
Plug 'sgur/vim-textobj-parameter'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter' "<Leader>c<space> 注释当前行或者反注释
Plug 'rhysd/clever-f.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'Raimondi/delimitMate' "shift-tab 跳出匹配的闭括号
Plug 'chiel92/vim-autoformat'




" test 
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-startify'
Plug 'wellle/tmux-complete.vim'


call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ";"
set shell=zsh
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>af :Autoformat<CR>
let g:formatters_python = ['black']
let g:tmux_navigator_save_on_switch = 2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun xelatex "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
"let g:coc_snippet_next = '<tab>'
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""NerdTree setting"""""""""""""""""""""""""""""""
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""LeaderF settiing"""""""""""""""""""""""""""""""""
let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
let g:Lf_ReverseOrder = 1
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
"nmap <leader>t :TagbarToggle<CR>

noremap <leader>g :LeaderfFunction!<cr>
noremap <leader>t :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'gruvbox'
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_NormalMap = {
            \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
            \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
            \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
            \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
            \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
            \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
            \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""rainbow setting"""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""scheme and airline"""""""""""""""""""""""""""""""
"colorscheme wombat256mod
colorscheme gruvbox
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='wombat'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-n> :TmuxNavigatePrevious<cr>
tnoremap <silent> <C-h> <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
tnoremap <silent> <C-n> <C-\><C-n>:TmuxNavigatePrevious<cr>
"nnoremap <silent> <C-M-h> :TmuxNavigateLeft<cr>
"nnoremap <silent> <C-M-j> :TmuxNavigateDown<cr>
"nnoremap <silent> <C-M-k> :TmuxNavigateUp<cr>
"nnoremap <silent> <C-M-l> :TmuxNavigateRight<cr>
"nnoremap <silent> <C-M-f> :TmuxNavigatePrevious<cr>
""""""""""""""buffer setting"""""""""""""""""""""""""""""""""""
set hidden " 避免必须保存修改才可以跳转buffer

"buffer快速导航
"不需要了 用[]b 代替
autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
" 查看buffers
" nnoremap <Leader>l :ls<CR>

" 通过索引快速跳转
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""Terminal Setting"""""""""""""""""""""""""""""""""""
noremap <C-t> :belowright vert term <cr>
tnoremap tq <c-\><c-n>
"tnoremap <C-j> <C-W>j
"tnoremap <C-k> <C-W>k
"tnoremap <C-h> <C-W>h
"tnoremap <C-l> <C-W>l
tnoremap <Leader>j <c-\><c-n>:bp<CR>
tnoremap <Leader>k <c-\><c-n>:bn<CR>

"Always show the column
set signcolumn=yes
" Do not showing mode
set noshowmode
" Sets how many lines of history VIM has to remember
set history=500

" Set number of lines
set nu!

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :wa!<cr>
inoremap <leader>w <Esc>:w<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

"Use clipboard like human
set clipboard=unnamed
map Y "+y

" Height of the command bar
" set cmdheight=2

" 光标所在行一横线
set cursorline

" n Always Forward
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500
set t_vb=

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark
set novisualbell

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" relative number 
set relativenumber
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
"noremap <C-j> <C-W>j
"noremap <C-k> <C-W>k
"noremap <C-h> <C-W>h
"noremap <C-l> <C-W>l
"noremap <C-f> <C-W><C-P>

map <C-w>j :resize +6<cr>
map <C-w>k :resize -6<cr>
map <C-w>l :vertical resize +6<cr>
map <C-w>h :vertical resize -6<cr>

" Switch PWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^
noremap H ^
noremap L $
inoremap <c-a> <home>
inoremap <c-e> <end>
"inoremap <C-h> <left>
"inoremap <C-j> <down>
"inoremap <C-k> <up>
"inoremap <C-l> <right>
"cnoremap <c-h> <left>
"cnoremap <c-n> <down>
"cnoremap <c-p> <up>
"cnoremap <c-l> <right>
"cnoremap <c-a> <home>
"cnoremap <c-e> <end>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

set ttimeout ttimeoutlen=50
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""Add by KissAndRun"""""""""""""
"" Out of the brackets
func SkipPair()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc
inoremap <leader><TAB> <c-r>=SkipPair()<CR>
""""""""""快捷使用ipdb"""""""""""""""""""""""""""""""""
func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
endf

func! s:RemoveBreakpoint()
    exe 'silent! g/^\s*import\sipdb\;\?\n*\s*ipdb.set_trace()/d'
endf

func! s:ToggleBreakpoint()
    if getline('.')=~#'^\s*import\sipdb' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
endf
nnoremap <F6> :call <SID>ToggleBreakpoint()<CR>
""""""""""使用Alt键"""""""""""""""""""""""""""""""""
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

"call Terminal_MetaMode(0)

let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
    augroup END
endif
map <leader>p :read !/mnt/c/Windows/System32/paste.exe<cr>

function RunCurrent()
    let path = expand("%:p") 
    let commandin = "'" . "ipython -i" . " " . path . "'"
    let command = "tmux send-keys -t top-right ".expand(commandin).expand(" C-m")
    let commandfist ="tmux send-keys -t top-right ".expand("C-z")
    call system(commandfist)
    call system(command)
endfunction
nnoremap <leader>s :call RunCurrent()<CR>
