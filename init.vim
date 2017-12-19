execute pathogen#infect()

" enable mouse in all modes
set mouse=a

" reveal neighbor text when nearing screen borders
set scrolloff=1
set sidescrolloff=5

" always assume bash when executing stuff
set shell=/bin/bash

" 2 spaces for tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" Split below and to the right
set splitbelow
set splitright

" enable line number gutter
set number

" place swap files somewhere more sane
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp

" undo persists across sessions
if has('persistent_undo')
  set undofile
  set undodir=~/.nvim/.undo
endif

" ignore binary files
set wildignore+=*.a

" clear highlights on space
nmap <space> :noh<cr>

" work around sketchy <C-h> behavior; hopefully this can be removed someday
nmap <BS> <C-w>h

" undotree bindings
nnoremap <leader>u :UndotreeToggle<CR>

" utility for colorscheme development
function! SyntaxItem()
  return "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

" set statusline=%{SyntaxItem()}

" tab for cycling through options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" open list automatically but preserve cursor position
let g:neomake_open_list = 2
let g:neomake_list_height = 5

" use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev Ag Ack
endif

" ensure vertical splits don't split into NERDTree
let g:ack_mappings = {
      \  'v':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
      \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' }

" enable Ack-style bindings in quickfix/loclist windows
" (e.g. s = open in split, v = open in vsplit, etc.)
let g:qf_mapping_ack_style = 1

" having both ql and ll at bottom results in awkwardly large list panes
let g:qf_loclist_window_bottom = 0

" load language-specific configuration
runtime! lang/*.vim

hi Search cterm=NONE ctermfg=grey ctermbg=blue
set hlsearch

" source local config if any
if !empty(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
end

" don't auto-fold
set foldlevelstart=99
