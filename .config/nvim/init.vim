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
set tabstop=2
set shiftwidth=2
set expandtab

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Color Scheme
set termguicolors
colorscheme challenger_deep

" lightline
let g:lightline = {
\   'colorscheme': 'challenger_deep',
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
