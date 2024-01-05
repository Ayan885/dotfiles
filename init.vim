:set number
:set relativenumber
:set encoding=utf-8
:set autoindent
:set noerrorbells
:set vb t_vb=
:set backspace=indent,eol,start
:syntax on
:filetype on
:filetype plugin on
:filetype indent on
:set cursorline
:set showmode
:set showcmd
:set wildmenu
:set wildmode=list:longest
:set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
:imap kj <Esc>l
:let mapleader = "\<Space>"
:nnoremap <leader>w :w<CR>
:nnoremap <leader>q :q<CR>
:nnoremap <leader>Q :q!<CR>
:nnoremap <leader>x :x<CR>
:nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>
:nnoremap <c-e> :NERDTreeToggle<cr>
:nnoremap <c-f> :NERDTreeFocus<cr>
:let NERDTreeIgnore=['\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
:let g:airline#extensions#tabline#enabled = 1

"BUFFER NAVIGATION
:nnoremap <silent><s-k>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
:nnoremap <silent><s-j>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
:nnoremap <silent><s-d>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bdelete<CR>

" move split panes to left/bottom/top/right
 nnoremap <A-h> <C-W>H
 nnoremap <A-j> <C-W>J
 nnoremap <A-k> <C-W>K
 nnoremap <A-l> <C-W>L

" move between panes to left/bottom/top/right
 nnoremap <C-h> <C-w>h
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-l> <C-w>l

" For Nvim Tree NAVIGATION
nnoremap <leader>e <cmd>:NvimTreeResize 25<cr><cmd>:NvimTreeToggle<cr>
nnoremap <A-e>  <cmd>:NvimTreeResize 25<cr><cmd>:NvimTreeToggle<cr>
nnoremap <A-d>  <cmd>:NvimTreeResize 25<cr><cmd>:NvimTreeClose<cr>


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'sainnhe/everforest'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
call plug#end()

colo everforest

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction
" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-@> coc#refresh()


:let g:airline#extensions#tabline#enabled = 1
:let g:airline#extensions#tabline#left_sep = ' '
:let g:airline#extensions#tabline#left_alt_sep = '|'


lua << END
require('lualine').setup({
  options = { theme = 'everforest' }
})
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
END

set termguicolors
lua << EOF
require("bufferline").setup{}
EOF
