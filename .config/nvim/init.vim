set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components'
Plug 'elzr/vim-json'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'wincent/ferret'

call plug#end()

call coc#add_extension('coc-json', 'coc-highlight', 'coc-tsserver', 'coc-eslint', 'coc-prettier')

"set completeopt=noinsert,menuone,noselect

filetype plugin indent on
syntax on

let g:user_emmet_leader_key='<C-B>'
let g:user_emmet_mode='a'

"================color====================
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" ============================== FZF/RIPGREP
" ========== files
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" ========== words
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --ignore-case --color=always --glob "!yarn.lock" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:50%', '?'))

" ============================== SETTINGS ==============================

" colorscheme
colorscheme gruvbox

let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = '='
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_powerline_fonts = 0

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=60

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set clipboard+=unnamedplus
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:✗,space:·
set nobackup
set noswapfile
set noshowmode
set number
set relativenumber
set path+=src
set shiftwidth=2
set softtabstop=2
set tabstop=2
set splitright
set timeoutlen=2000
set ttimeoutlen=0
set wildmenu
set list!
set updatetime=100
set shortmess+=c
set showtabline=2
set pumheight=10
set scl=yes

" reload changed file on focus, buffer enter
" helps if file was changed externally.
augroup ReloadGroup
  autocmd!
  autocmd! FocusGained,BufEnter * checktime
augroup END

" =========== cursorline
hi CursorLine ctermfg=NONE ctermbg=NONE
hi CursorLineNR ctermfg=black ctermbg=yellow
set cursorline

" ======= duplicate line command ======
command! -count=0 DuplicateLine :-<count>,-0t.

" ====== COC highlights =====
hi CocErrorHighlight ctermbg=124 guibg=#b71c1c
hi CocWarningHighlight ctermbg=166 guibg=#ffb74d
hi CocInfoHighlight ctermbg=227 guibg=#fff59d
hi CocHintHighlight ctermbg=74 guibg=#2196f3

" ============================== MAPPINGS ==============================
let mapleader = " "

" find and replace word
nnoremap ,rr :%s//cg<Left><Left><Left>
nnoremap ,rg :%s//g<Left><Left>

" find file
nnoremap ,ff :GFiles<CR>
nnoremap ,F :Files<CR>
" find fuzzy
nnoremap ,fg :Rg 
" find buffer
nnoremap ,e :Buffers<CR>

" close buffer
nnoremap ,d :bd<CR>
" close buffer not window
" nnoremap ,d :bp\|bd #<CR>
" close all buffers
nnoremap ,D :bufdo bd<CR>

" vert split
nnoremap ,v :vs<CR>

" session save/open/remove
nnoremap ,ss :mksession! ~/.config/nvim/sessions/
nnoremap ,so :source ~/.config/nvim/sessions/
nnoremap ,sr :!rm ~/.config/nvim/sessions/

" edit/save .vimrc
"nnoremap ,ev :e ~/.config/nvim/init.vim<CR>
"nnoremap ,sv :so ~/.config/nvim/init.vim<CR>

" show invisible chars
nnoremap ,sh :set list!<CR>

" no highlights
nnoremap ,y :noh<CR>

" select all
nnoremap ,sa ggVG

" quit/save all
nnoremap ,q :qa<CR>
nnoremap ,w :wall<CR>

" these only get hit by accident
nnoremap Q <Nop>
nnoremap q: <Nop>

" 0 is easier. ^ is more useful.
nnoremap 0 ^
nnoremap ^ 0

" explore project dir
nnoremap - :NERDTree .<CR>
" explore ditree toogle
nnoremap ,, :NERDTree %<CR>
" tree toggle
nnoremap ,m :NERDTreeToggle<CR>

" info windows
nnoremap ,o :lopen<CR>
nnoremap ,p :lclose<CR>:cclose<CR>:pclose<CR>

" buffers
nnoremap ,bb :b#<CR>
nnoremap ,bp :bp<CR>
nnoremap ,bn :bn<CR>
" nnoremap ,e :buffers<CR>:buffer<Space>

" windows
nnoremap ,z <C-W>x
nnoremap ,h <C-W>h
nnoremap ,j <C-W>j
nnoremap ,k <C-W>k
nnoremap ,l <C-W>l
nnoremap ,= <C-W>=
" kill all windows but current
nnoremap ,x :only<CR>

" tabs
nnoremap ,tg :tabnew<CR>
nnoremap ,tt :tabn<CR>
nnoremap ,tr :tabc<CR>
nnoremap ,tp :tabp<CR>

" hunks
nmap <Leader>hj <Plug>GitGutterNextHunk
nmap <Leader>hk <Plug>GitGutterPrevHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap <Leader>hi <Plug>GitGutterPreviewHunk

"duplicate
nnoremap ,a :DuplicateLine<space>

"complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" language server protocol
nmap <silent> K <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-rename)

" error navigation
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)
