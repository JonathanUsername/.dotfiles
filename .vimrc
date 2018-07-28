" hopefully fixes arrow keys 
set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'racer-rust/vim-racer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
" Plug 'ternjs/tern_for_vim'
Plug 'airblade/vim-gitgutter'
Plug 'flowtype/vim-flow'
" Plug 'python-mode/python-mode'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'idanarye/vim-merginal'
Plug 'terryma/vim-multiple-cursors'
Plug 'dyng/ctrlsf.vim'
Plug 'liuchengxu/space-vim-dark'

call plug#end()

" set fileencoding=utf-8
" set fileencodings=ucs-bom,utf8,prc
syntax on
filetype plugin indent on
set paste
set autoread
set clipboard=unnamedplus

" Lets you use the cursor like a boss 
set mouse=a

" 4 spaces instead of tabs :(
set tabstop=8
set softtabstop=0
set expandtab
set smarttab
set nonumber
set shiftwidth=4
set autoindent
set smartindent
set virtualedit=onemore 
set foldcolumn=0

" clear search highlighting with esc
"nnoremap <esc> :noh<return><esc>

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

command! -nargs=1 Lg !git add --all; git commit -m <args>
command! -bar -bang -nargs=? Stack call stackanswers#StackAnswers(<q-bang>, <q-args>)

command! Sa :StackAnswers

" Use silver searcher
let g:ackprg = 'ag --vimgrep'

" Map Cmd+s to save
:let mapleader = ","
:map <Leader>s :w<kEnter>
:map <Leader>q :q<kEnter>
:map <Leader>v :e ~/.vimrc<kEnter>
:map <Leader>d :FlowJumpToDef<kEnter>
:map <Leader>td :TernDef<kEnter>
:map <Leader>tr :TernRefs<kEnter>
:map <Leader>tt :TernDefTab<kEnter>

" avoid backup files in working directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" persistent undo between sessions
set undofile
set undodir=~/.vim/tmp


" open file in nerdtree
nmap ,n :NERDTreeFind<CR>

" For light, low contrast theme:
:let zenburn_on=0
if zenburn_on
    colors zenburn
    let g:airline_theme='zenburn'
else
    set t_Co=256
    highlight Normal ctermbg=NONE
    highlight nonText ctermbg=NONE
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    " :AirlineTheme solarized
    " let g:airline_solarized_bg='dark'
    let g:airline_theme='violet'

    colorscheme space-vim-dark
    hi Normal     ctermbg=NONE guibg=NONE
    hi LineNr     ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
    set termguicolors
endif

" For dark colours
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

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

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_check_on_w = 1
" let g:syntastic_javascript_checkers = ['eslint']
" " let g:syntastic_javascript_checkers = ['eslint', 'flow']
" " let g:syntastic_javascript_flow_exe = 'node_modules/.bin/flow'
" let g:syntastic_javascript_eslint_exe = 'node_modules/.bin/eslint --config=.eslintrc.js --max-warnings=0'
" let g:syntastic_python_checkers = ['pylint']

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn


let g:used_javascript_libs = 'react'
let g:python_host_prog = '/usr/local/bin/python2'


let NERDTreeShowHidden=1

" Using fzf instead of ctrl-p
nnoremap <c-t> :History<CR>
nnoremap <c-p> :Files<CR>

" get ctrlp to remember 250 files
let g:ctrlp_mruf_max = 250

" avoid backup files in working directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" Map ctrl n to open filetree
map <C-n> :NERDTreeToggle<CR>

set rtp+=/usr/local/opt/fzf

" for fancy arrows etc
let g:airline_powerline_fonts = 1

" let g:gitgutter_override_sign_column_highlight = 0
let g:zenburn_force_dark_Background = 1
" let g:zenburn_high_Contrast = 1

" Persistent undo
try 
    set undodir=~/.vim/undodir
    set undofile
catch
endtry

" Save clipboard registers even when leaving
autocmd VimLeave * call system("xsel -ib", getreg('+'))

let g:ale_linters = {
\   'python': ['pylint'],
\}
let g:ale_python_pylint_options = '--rcfile /home/jonathan/src/github.com/mixcloud/mixcloud/website/tests/pylint/pylintrc' 
"Use locally installed flow - must be a better way!
let local_flow = '/home/jonathan/src/github.com/mixcloud/mixcloud/website/js/node_modules/.bin/flow'
let g:flow#flowpath = local_flow
" autoclose the quickfix window if no errors
let g:flow#autoclose = 1
