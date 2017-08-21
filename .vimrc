if &compatible
	set nocompatible
endif

let onremote=$SSH_TTY
if onremote == ''
	set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
	set runtimepath+=~/testingstuffwoo
	" clear search highlighting with esc
	nnoremap <esc> :noh<return><esc>
else
	set runtimepath+=$SSHHOME/.sshrc.d/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim
	set runtimepath+=$SSHHOME/.sshrc.d/.vim
endif

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
call dein#add('vim-syntastic/syntastic')
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-commentary')
" call dein#add('ternjs/tern_for_vim')
call dein#add('airblade/vim-gitgutter')
" call dein#add('flowtype/vim-flow')
call dein#add('python-mode/python-mode')
call dein#add('jelera/vim-javascript-syntax')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('jiangmiao/auto-pairs')
call dein#add('idanarye/vim-merginal')

" and a lot more plugins.....
call dein#end()

if dein#check_install()
  :call dein#install()
endif

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
set virtualedit=onemore
" set foldmethod=syntax
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set shiftwidth=4
set autoindent
set smartindent

" for fancy arrows etc
let g:airline_powerline_fonts = 1

" Turn of annoyances for py-mode
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 0

" use // to search for selected text
vnoremap // y/<C-R>"<CR>"

" Lets you use the cursor
set mouse=a

let g:ackprg = "ag --vimgrep"

" Map Cmd+s to save
:let mapleader = ","
:map <Leader>s :w<kEnter>
:map <Leader>q :q<kEnter>
" back to last file
:map <Leader>b :e#<kEnter>
:map <Leader>v :tabedit ~/.vimrc<kEnter>
:map <Leader>d :FlowJumpToDef<kEnter>
:map <Leader>r :Ack <cword> --ignore-file=is:www.js<kEnter>
" open file in nerdtree
nmap <Leader>n :NERDTreeFind<CR>

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

" remap d to not copy
" http://stackoverflow.com/questions/3638542/any-way-to-delete-in-vim-without-overwriting-your-last-yank
" nnoremap d "xd
" vnoremap d "xd
" xnoremap p "_dP

" set cursor to bar when in insert mode
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
elseif empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

let NERDTreeShowHidden=1

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

" avoid backup files in working directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" persistent undo between sessions
set undofile
set undodir=~/.vim/tmp

" For light, low contrast theme:
:let zenburn_on=0
if zenburn_on
    colors zenburn
    let g:airline_theme='zenburn'
else
    set background=dark
    colorscheme solarized
    " :AirlineTheme solarized
    let g:airline_solarized_bg='dark'
    let g:airline_theme='understated'
endif

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

" SYNTASTIC

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
let g:syntastic_check_on_w = 1
" let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_checkers = ['eslint']

" specific to opening in mixcloud/website!!
let g:syntastic_javascript_eslint_exe = 'js/node_modules/.bin/eslint --config=.eslintrc.js --max-warnings=0'
let g:syntastic_javascript_flow_exe = 'js/node_modules/.bin/flow'
let g:syntastic_python_checkers = ['pylint']

let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_sh_shellcheck_exe = 'shellcheck'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

let g:used_javascript_libs = 'react'
set rtp+=/usr/local/opt/fzf

" no max length bar
:set colorcolumn=0
