" Plugins
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim

  " Automatically install missing plugins
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
    PlugClean | q
  endif
endif

" Various options
let mapleader=","         " Map the Leader key
set inccommand=nosplit    " Preview the effects of substitute live
set incsearch             " Enable incremental searching
set mouse=a               " Enable cursor and split selection using the mouse
set ignorecase
set smartcase

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

" Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ALE
let g:ale_linters = {
\   'ruby': ['standardrb', 'rubocop'],
\   'javascript': ['prettier', 'eslint']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['standardrb']
\}

let g:ale_fix_on_save = 1

" LSC
"
" Install Solargraph via 'gem install solargraph' and run 'solargraph bundle'
" when installing/updating ruby gems
let g:lsc_server_commands = {
 \  'ruby': {
 \    'command': 'solargraph stdio',
 \    'log_level': -1,
 \    'suppress_stderr': v:true,
 \  }
 \}
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}
let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:false
let g:lsc_reference_highlights = v:false
let g:lsc_trace_level          = 'off'

set completeopt=menu,menuone,noinsert,noselect

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

" Enable system clipboard integration
set clipboard+=unnamedplus
" Workaround for neovim wl-clipboard and netrw interaction hang
" (see: https://github.com/neovim/neovim/issues/6695 and
" https://github.com/neovim/neovim/issues/9806)
let g:clipboard = {
 \   'name': 'myClipboard',
 \   'copy': {
 \      '+': 'wl-copy',
 \      '*': 'wl-copy',
 \    },
 \   'paste': {
 \      '+': 'wl-paste -o',
 \      '*': 'wl-paste -o',
 \   },
 \   'cache_enabled': 0,
 \ }

" fzf
map <Leader>f :FZF<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
