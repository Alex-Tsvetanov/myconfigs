"call pathogen#infect('/usr/local/bundle/{}')
"call pathogen#helptags()

set runtimepath+=/usr/local/bundle/badwolf
set runtimepath+=/usr/local/bundle/nerdtree
set runtimepath+=/usr/local/bundle/detectindent
"set runtimepath+=/usr/local/bundle/jshint2.vim

set runtimepath+=/usr/local/bundle/YouCompleteMe
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
autocmd FileType cpp        setlocal makeprg=g++\ '%'\ -o\ '%:r'.exe\ -std=c++14\ -Wall\ -lglut\ -lGLU\ -lGL\ -lXmu\ -lXext\ -lXi\ -lX11\ -lm\ -lgmpxx\ -lgmp
autocmd FileType haskell    setlocal makeprg=ghc\ --make\ '%' shellpipe=2> expandtab
autocmd FileType cabal      setlocal expandtab
autocmd FileType python     setlocal makeprg=python\ '%'
autocmd FileType javascript setlocal makeprg=node\ '%'
autocmd Filetype html       setlocal ts=2 sts=2 sw=2
endif


autocmd BufReadPost * :DetectIndent

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

let g:ycm_global_ycm_extra_conf = '/etc/vim/ycm_extra_conf.py'
set completeopt-=preview

"let g:syntastic_c_compiler_options = '-std=gnu11'
"let g:syntastic_cpp_compiler_options = '-std=gnu++1z'
"
""set conceallevel=2
""set concealcursor=vin
"let g:clang_snippets=1
"let g:clang_conceal_snippets=1
"let g:clang_snippets_engine='clang_complete'
"let g:clang_user_options = '-std=gnu++1z'
"
"let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'

if &term =~? 'xterm'
	set t_ut=
	set t_Co=256
	let g:badwolf_darkgutter = 1
	let g:badwolf_tabline = 2
	colorscheme badwolf
	set cursorline cursorcolumn
else
	if &term =~? 'rxvt-256color'
		set t_ut=
		set t_Co=256-color
		let g:badwolf_darkgutter = 1
		let g:badwolf_tabline = 2
		colorscheme badwolf
		set cursorline cursorcolumn
	else
		colorscheme slate
	endif
endif

noremap <silent> <F3> :NERDTreeToggle<CR>
map <Tab> :tabnext<CR>
map <BS> :tabprev<CR>
map <C-h> :nohls<CR> 
setfiletype cpp
hi Normal ctermbg=none
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '»'
let g:airline#extensions#tabline#right_sep = '◀'
let g:airline#extensions#tabline#right_alt_sep = '«'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Statusbar
let g:airline_detect_modified=1
let g:airline_mode_map = {
	\ '__' : '-',
	\ 'n'  : 'N',
	\ 'i'  : 'I',
	\ 'R'  : 'R',
	\ 'c'  : 'C',
	\ 'v'  : 'V',
	\ 'V'  : 'V',
	\ '' : 'V',
	\ 's'  : 'S',
	\ 'S'  : 'S',
	\ '' : 'S',
	\ }
" theme and etc.
let g:airline_theme             = 'badwolf'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

highlight Comment  cterm=bold ctermbg=NONE
highlight Constant ctermbg=NONE 
highlight Normal ctermbg=NONE 
highlight NonText ctermbg=NONE
highlight Special ctermbg=NONE
highlight Cursor ctermbg=NONE

" color jellybeans
" let g:jellybeans_background_color_256='NONE'
