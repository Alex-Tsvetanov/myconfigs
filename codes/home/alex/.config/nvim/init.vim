set autochdir

"set runtimepath+=/usr/local/bundle/badwolf
"set runtimepath+=/usr/local/bundle/nerdtree
"set runtimepath+=/usr/local/bundle/detectindent
"set runtimepath+=/usr/local/bundle/jshint2.vim

"set runtimepath+=/usr/local/bundle/YouCompleteMe
"set runtimepath+=/usr/local/bundle/AutoComplPop
"set runtimepath+=/usr/local/bundle/clang_complete
"set runtimepath+=/usr/local/bundle/supertab
"set runtimepath+=/usr/local/bundle/syntastic


set history=1000
set wildmenu ruler showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set hlsearch incsearch magic
set noerrorbells visualbell t_vb=
set background=dark
set encoding=utf8
set nobackup nowritebackup noswapfile
set smartcase
set showfulltag
set scrolloff=5 sidescrolloff=5
set hidden
set number relativenumber
set smartindent autoindent smarttab cindent
set autoread
set ts=4 sw=4 sts=4
set mouse=a
set timeoutlen=200
set laststatus=2

syntax enable

if filereadable("Makefile")
setlocal makeprg=make
else
autocmd FileType c          setlocal makeprg=gcc\ '%'\ -o\ '%:r'.exe\ -std=gnu11\ -Wall
autocmd FileType cs         setlocal makeprg=mcs\ '%'
autocmd FileType cpp        setlocal makeprg=g++\ '%'\ -o\ '%:r'.exe\ -std=c++14\ -Wall\ -lglut\ -lGLU\ -lGL\ -lXmu\ -lXext\ -lXi\ -lX11\ -lm\ -lgmpxx\ -lgmp\ -fopenmp
autocmd FileType haskell    setlocal makeprg=ghc\ --make\ '%' shellpipe=2> expandtab
autocmd FileType cabal      setlocal expandtab
autocmd FileType python     setlocal makeprg=python\ '%'
autocmd FileType javascript setlocal makeprg=node\ '%'
autocmd Filetype html       setlocal ts=2 sts=2 sw=2 makeprg=firefox\ file://$PWD/'%'
endif


"autocmd BufReadPost * :DetectIndent

autocmd QuickFixCmdPost [^l]* nested cwindow

set errorformat=%f:%l:%c:\%m
set errorformat+=%*[\"]%f%*[\"]\\,\ line\ %l:\ %m

set errorformat+=%-Z\ %#
set errorformat+=%W%f:%l:%c:\ Warning:\ %m
set errorformat+=%E%f:%l:%c:\ %m
set errorformat+=%E%>%f:%l:%c:
set errorformat+=%+C\ \ %#%m
set errorformat+=%W%>%f:%l:%c:
set errorformat+=%+C\ \ %#%tarning:\ %m

nmap <F8> :w<CR>:make -O2<CR><CR>
nmap <F9> :w<CR>:make<CR><CR>
nmap <F10> :!'%:p:r'.exe<CR>
nmap <C-F10> :w<CR>:!'%:p'<CR>
nmap <F12> :w<CR>:!ghci %<CR><CR>
nmap <C-F12> :w<CR>:!ghci<CR><CR>
nmap <C-D> :sh<CR>

let mapleader='\'
nmap <Leader>q :q<CR>
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>w :w !sudo tee % > /dev/null<CR><CR>
nmap <Leader>p :make program<CR><CR>

nmap Y y$
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h

set langmap=чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM

let myterm = $TERM
if myterm =~ 'xterm'
	source /usr/share/vim/vimfiles/colors/badwolf.vim
    set t_ut=
    set t_Co=256
    let g:badwolf_darkgutter = 1
    let g:badwolf_tabline = 2
    set cursorline cursorcolumn
else
	colorscheme slate
endif

source /usr/share/vim/vimfiles/syntax/nerdtree.vim
noremap <silent> <F3> :NERDTreeToggle<CR>
map <Tab> :tabnext<CR>
map <BS> :tabprev<CR>
map <C-h> :nohls<CR> 
setfiletype cpp

"let w:airline_disabled=1
if ! has("gui_running")
    let g:loaded_airline = 1
endif

"call pathogen#infect()
"call pathogen#helptags()

"let g:clang_complete_auto = 1
"let g:clang_auto_select = 1
"let g:clang_hl_errors = 1
"let g:clang_snippets = 1
"let g:acp_behaviorHtmlOmniLength=100000000

"highlight SyntasticErrorLine guibg=#2f0000
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_c_compiler_options = '-std=gnu11 -Wall -lglut -lGLU -lGL -lXmu -lXext -lXi -lX11 -lm -lgmpxx -lgmp -fopenmp'
"let g:syntastic_cpp_compiler_options = '-std=gnu++14 -Wall -lglut -lGLU -lGL -lXmu -lXext -lXi -lX11 -lm -lgmpxx -lgmp -fopenmp'

highlight Comment  cterm=bold ctermbg=NONE
highlight Constant ctermbg=NONE 
highlight Normal ctermbg=NONE 
highlight NonText ctermbg=NONE
highlight Special ctermbg=NONE
highlight Cursor ctermbg=NONE
