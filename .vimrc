if &compatible
	set nocompatible
endif

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
Plug 'flowtype/vim-flow', { 'autoload': { 'filetypes': 'javascript' } }
Plug 'python-mode/python-mode'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'idanarye/vim-merginal'
Plug 'terryma/vim-multiple-cursors'
Plug 'dyng/ctrlsf.vim'
Plug 'liuchengxu/space-vim-dark'

Plug 'tpope/vim-rsi'
Plug 'jparise/vim-graphql'
Plug 'davidhalter/jedi-vim'

call plug#end()


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
set foldcolumn=0

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
:map <Leader>t :MerlinTypeOf<kEnter>
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

" Using fzf instead of ctrl-p
nnoremap <c-p> :Files<CR>


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
:let zenburn_on=1
if zenburn_on
    colors zenburn
    let g:airline_theme='zenburn'
else
endif

:let jon_theme='apprentice'

if jon_theme == 'zenburn'
    colors zenburn
    let g:airline_theme='zenburn'
	let g:zenburn_force_dark_Background = 1
elseif jon_theme == 'apprentice'
    colors apprentice
    let g:airline_theme='apprentice'
    set termguicolors
elseif jon_theme == 'violet'
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
elseif jon_theme == 'solarized'
    set background=dark
    colorscheme solarized
    " :AirlineTheme solarized
    let g:airline_solarized_bg='dark'
    let g:airline_theme='understated'
endif

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
set statusline+=%*

let g:flow#autoclose = 1

let g:used_javascript_libs = 'react'
let g:javascript_plugin_flow = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_loc_list = 0
" " let g:syntastic_check_on_open = 1
" " let g:syntastic_check_on_wq = 1
" let g:syntastic_check_on_w = 1
" " let g:syntastic_javascript_checkers = ['eslint', 'flow']
" let g:syntastic_javascript_checkers = ['eslint']

" " specific to opening in mixcloud/website!!
" let g:syntastic_javascript_eslint_exe = 'js/node_modules/.bin/eslint --config=.eslintrc.js --max-warnings=0'
" let g:syntastic_javascript_flow_exe = 'js/node_modules/.bin/flow'
" let g:syntastic_python_checkers = ['pylint']

" let g:syntastic_sh_checkers = ['shellcheck', 'sh']
" let g:syntastic_sh_shellcheck_exe = 'shellcheck'

let g:used_javascript_libs = 'react'
set rtp+=/usr/local/opt/fzf

" no max length bar
:set colorcolumn=0
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line:
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']

fun! OCaml_additional()
    " For the plugin 'tpope/vim-commentary':
    set commentstring=(*\ %s\ *)
    map  <buffer> <localleader>bmw obegin match  with<cr>end<esc>k2==0EEl
    nmap <buffer> <localleader>om o>>= fun  -><esc>==0t-
    nmap <buffer> <localleader>ou o>>= fun () -><esc>==
    nmap <buffer> <localleader>ad a(** *)<esc>hh
    nmap <buffer> <localleader>op o\|  -><esc>==^l
    set cc=81 " display 81st column
    " It's a merlin thing, but who cares:
    nmap <buffer> <localleader>l :Locate<cr>
endfun
autocmd FileType ocaml call OCaml_additional()
" ## added by OPAM user-setup for vim / ocp-indent ## 29a79bb13e4e1278e9d60f3492eb46b8 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/jonathan/.opam/4.05.0/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line


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
let local_flow = '/Users/jonathan/src/github.com/mixcloud/mixcloud/website/js/node_modules/.bin/flow'
let g:flow#flowpath = local_flow
" autoclose the quickfix window if no errors
let g:flow#autoclose = 1

command! -bang -nargs=* Search
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)


