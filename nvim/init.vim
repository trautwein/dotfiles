" Leader
let mapleader = ","

set autowrite     " Automatically :write before running commands
set backspace=2        " Backspace deletes like most programs in insert mode
set cursorline
set diffopt+=vertical
set history=50
set inccommand=nosplit " preview the effects of substitute live
set incsearch          " do incremental searching
set laststatus=2       " Always display the status line
set lazyredraw
set nobackup
set noswapfile         " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nowritebackup
set printoptions=portrait:n,number:y 
set ruler              " show the cursor position all the time
set shell=/bin/zsh
set showcmd            " display incomplete commands
set ttyfast
set updatetime=100

" Enable truecolor support
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Enable syntax highlighting
syntax on

runtime macros/matchit.vim

" minpac
if filereadable(expand("~/.config/nvim/init.vim.packages"))
  command! PackUpdate call minpac#update()
  command! PackClean  call minpac#clean()
  source ~/.config/nvim/init.vim.packages
endif

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  let g:ackprg = 'ag --vimgrep'
endif

" Color scheme
set background=dark
let ayucolor='mirage'
colorscheme ayu

" lightline
source ~/.config/nvim/pack/minpac/start/ayu-lightline/ayu.vim
let g:lightline = {
\   'colorscheme': 'ayu',
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
call lightline#init()
call lightline#colorscheme()
call lightline#update()
set noshowmode

" Numbers
set number
set numberwidth=5

" Ignore case when searching
set ic

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" set ruby path (using rbenv)
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Explorer Mode
let g:netrw_liststyle=3
map <Leader>e :Explore<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" vim-test mappings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" dash mapping
nmap <silent> <leader>d <Plug>DashSearch

" execute current ruby file
map <Leader>r :!ruby %<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Remove any search highlighting
nnoremap <silent> <leader>c :nohlsearch<CR>

" configure syntastic syntax checking to check on open as well as save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['mri']

" Use OS X clipboard
set clipboard+=unnamed

"key to insert mode with paste using F2 key
map <F2> :set paste<CR>i

" Leave paste mode on exit
au InsertLeave * set nopaste

" localorie
nnoremap <silent> <leader>lt :call localorie#translate()<CR>
nnoremap <silent> <leader>le :call localorie#expand_key()<CR>
