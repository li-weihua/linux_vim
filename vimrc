" only load when vim version >= 8.0
if v:version < 800
    finish
endif

set encoding=utf-8

" when in vi compatible mode, turn off load plugins
if !has("compatible")
    call plug#begin('~/.vim/plugged')

    " auto complete for c/c++, python
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }

    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

    " vim windows themes
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " REPL
    Plug 'sillybun/vim-repl'

    " vim table mode
    Plug 'dhruvasagar/vim-table-mode'

    " show trailing whitespace
    Plug 'ntpeters/vim-better-whitespace'

    " rust
    Plug 'rust-lang/rust.vim'

    " Initialize plugin system
    call plug#end()
endif

"====== YCM plugin setup ====="
"let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_key_invoke_completion = '<c-space>'
"let g:ycm_python_binary_path = '/root/program/anaconda/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,cuda': ['re!\w{2}'],
           \ }

let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "cuda":1,
			\ "python":1,
			\ "sh":1,
			\ }

" nerdtree toggle shortcut
nnoremap <C-t> :NERDTreeToggle<CR>

" ycm shortcut
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>

" strip all whitespace
nnoremap <leader>s :StripWhitespace<CR>

" tab view shortcut
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"====== repl plugin setup ====="
let g:repl_program = {
			\	'python': ['ipython'],
			\	'default': ['bash']
			\	}

let g:repl_ipython_version = '6'
" 0 represents bottom
" 1 represents top
" 2 represents left
" 3 represents right
let g:repl_position = 3

"====== vimspector plugin setup ====="
let g:vimspector_enable_mappings = 'HUMAN'

" rust auto format
let g:rustfmt_autosave = 1

set wildmenu
set wildmode=longest:full,full
set fileencodings=utf-8
set backspace=indent,eol,start
set expandtab softtabstop=4 shiftwidth=4 tabstop=4

au FileType c,cpp,objc,proto,cmake set tabstop=2 shiftwidth=2  softtabstop=2
au FileType fortran set autoindent smartindent tabstop=8 shiftwidth=8
au FileType python set autoindent tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.cu,*.hip set ft=cuda tabstop=2 shiftwidth=2  softtabstop=2
au BufNewFile,BufRead *.cuh set ft=cuda tabstop=2 shiftwidth=2  softtabstop=2
au BufNewFile,BufRead *.nasm set ft=nasm autoindent
au BufNewFile,BufRead *.proto3 set ft=proto
au BufNewFile,BufRead *.m set ft=objc

"my personal mapping binding
"Toggle auto-indenting for code paste
" set pastetoggle=<F2>
imap jk <esc>
imap <c-u> <esc>vbUea
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';')) && executable('clang-format')
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.cuh,*.c,*.cpp,*.cc,*.cxx,*.cu,*.hip,*.proto :call FormatBuffer()
