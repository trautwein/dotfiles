" Plugins
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim

  " Automatically install missing plugins
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
    PlugClean | q
  endif
endif

" Options
let mapleader=","         " Map the Leader key
set inccommand=nosplit    " Preview the effects of substitute live
set incsearch             " Enable incremental searching
set mouse=a               " Enable cursor and split selection using the mouse

" Automatically switch between hybrid and absolute-only line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Softtabs (2 spaces)
set expandtab
set shiftwidth=2
set tabstop=2

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Color Scheme
if (has("termguicolors"))
 set termguicolors
endif

syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

colorscheme OceanicNext

" lightline
let g:lightline = {
\   'colorscheme': 'oceanicnext',
\   'active': {
\     'left': [
\       [ 'mode', 'paste' ],
\       [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
\     ],
\     'right': [
\       [ 'lineinfo' ],
\       [ 'percent' ],
\       [ 'fileformat', 'fileencoding', 'filetype' ]
\     ]
\   },
\   'component_function': {
\     'gitbranch': 'fugitive#head',
\   }
\ }

" netrw
nnoremap <Leader>e :Explore<CR>
let g:netrw_localrmdir='rm -r'

" ctrlp with ag
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'javascript': ['prettier', 'eslint']
\}

let g:ale_fix_on_save = 1
let g:ale_fix_on_save_ignore = ['rubocop', 'prettier', 'eslint']

" autocompletion
set omnifunc=syntaxcomplete#Complete

" fugitive
set diffopt+=vertical

" localorie
nnoremap <silent> <leader>lt :call localorie#translate()<CR>
nnoremap <silent> <leader>le :call localorie#expand_key()<CR>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Autosave when the focus is lost
:au FocusLost * silent! wa

" Clear the search on ESC
nnoremap <esc> :noh<return>

" Use the clipboard
set clipboard=unnamedplus

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
