if &compatible
	set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim

call dein#begin(expand('~/.vim/dein')) " plugins' root path
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'windows': 'tools\\update-dll-mingw',
    \     'cygwin': 'make -f make_cygwin.mak',
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })

call dein#add('Shougo/unite.vim')
call dein#add('mileszs/ack.vim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-commentary')
call dein#add('airblade/vim-gitgutter')
call dein#add('jelera/vim-javascript-syntax')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('jiangmiao/auto-pairs')
call dein#add('idanarye/vim-merginal')

" and a lot more plugins.....
call dein#end()

" :call dein#install()

" execute pathogen#infect()

" set background=dark
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
syntax on
filetype plugin indent on
set number
set paste
set autoread
set clipboard=unnamed

" Lets you use the cursor like a boss 
set mouse=a

" let g:ackprg = "ag --vimgrep"

" 4 spaces instead of tabs :(
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set shiftwidth=4
set autoindent
set smartindent

" clear search highlighting with esc
nnoremap <esc> :noh<return><esc>

" Map Cmd+s to save
:let mapleader = ","
:map <Leader>s :w<kEnter>
:map <Leader>q :q<kEnter>

" get ctrlp to remember 250 files
let g:ctrlp_mruf_max = 250

" FUGITIVE / GIT
" Write COMMIT_EDITMSG and push to current branch
function! PushToCurrentBranch()
  exe ":Gwrite"
  let branch = fugitive#statusline()
  let branch = substitute(branch, '\c\v\[?GIT\(([a-z0-9\-_\./:]+)\)\]?', $BRANCH.' \1', 'g')
  exe ":Git push origin" . branch
endfunction

" Allow capital for writeout, ie. :W
cnoreabbrev W w

command! Gp :call PushToCurrentBranch()
command! -nargs=1 Lg :exec("! git add --all; git commit -m " . shellescape(<args>, 1))
command! -bar -bang -nargs=? Stack call stackanswers#StackAnswers(<q-bang>, <q-args>)

command! Sa :StackAnswers

" Map Cmd+s to save
:let mapleader = ","
:map <Leader>s :w<kEnter>
:map <Leader>q :q<kEnter>
:map <Leader>c oconsole.log('here')<ESC>

" avoid backup files in working directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" persistent undo between sessions
set undofile
set undodir=~/.vim/tmp


" open file in nerdtree
nmap ,n :NERDTreeFind<CR>

" For light, low contrast theme:
colors zenburn

" and for airline...
let g:airline_theme='zenburn'

" For dark colours
" colorscheme solarized

" Map ctrl n to open filetree
map <C-n> :NERDTreeToggle<CR>

" open new file from ctrl+p in pane
let g:ctrlp_switch_buffer = 'et'
" dont limit the files ctrl+p can search
let g:ctrlp_max_files=50000
" ignore .gitignored files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


" TABS
" Navigate through tabs by number
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 :tablast<cr>"
noremap <Leader>T :tabnew<cr>"

" SYNTASTIC

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_check_on_w = 1
let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_eslint_exe = 'node_modules/.bin/eslint --config=.eslintrc.js --max-warnings=0'
let g:syntastic_javascript_flow_exe = 'node_modules/.bin/flow'
let g:syntastic_python_checkers = ['pylint']

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn


" PLUGIN LIST:
" ack.vim
" auto-pairs
" ctrlp
" nerdtree
" python-syntax
" stackanswers.vim
" syntastic
" vim-airline
" vim-colors-solarized
" vim-commentary
" vim-fugitive
" vim-gitgutter
" vim-javascript-syntax
" javascript-libraries-syntax

let g:used_javascript_libs = 'react'
