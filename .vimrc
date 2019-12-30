"======================= Plug ==========================
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'schickling/vim-bufonly'
Plug 'Yggdroot/indentLine'
Plug 'storyn26383/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'kylef/apiblueprint.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'digitaltoad/vim-pug'
Plug 'storyn26383/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'toyamarinyon/vim-swift'
Plug 'udalov/kotlin-vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'

call plug#end()
"====================== Settings =======================
syntax on
set encoding=UTF-8
set nu
set incsearch
set ignorecase
set autoread
set nocompatible
set nobackup " no *~ backup files
set noswapfile
set nowritebackup
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set tags+=~/.vim/tags,./tags,tags;
set hidden " leave buffer without save
autocmd FileType make setlocal noexpandtab
autocmd FileType php setlocal omnifunc=phpactor#Complete
autocmd FileType js,vue,css,html,typescript setlocal sw=2 sts=2 ts=2
nmap <F2> :ctags -R<CR>
nmap <F4> :w<CR>:make<CR>
nmap <F5> :w<CR>
nmap <F6> :cl<CR>
nmap <F7> :! gdb <CR>
nmap <F8> :Tlist<CR>
nmap <Leader>i :IndentLinesToggle<CR>
nmap <Leader>s :LeadingSpaceToggle<CR>
nmap <Leader>l :IndentLinesToggle<CR>
nmap <Leader>b :Buffer<CR>
nmap <Leader>a :Ag<CR>
nmap <Leader>f :Files<CR>
noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprevious<CR>
noremap <C-x> :bd<CR>
let g:vim_markdown_folding_disabled = 1
if has("clipboard") " yank to clipboard
      set clipboard=unnamed " copy to the system clipboard
        if has("unnamedplus") " X11 support
                set clipboard+=unnamedplus
                  endif
              endif
let mapleader=" " " set leader key to space
"===================== ctrlp ===========================
let g:ctrlp_map='<D-p>'
"===================== Ctags ===========================
function! UpdateTags()
  let tags = 'tags'
  if filereadable(tags)
    let file = substitute(expand('%:p'), getcwd() . '/', '', '')
    " remove tags of file and append tags
    call system('sed -ri "/\s+' . escape(file, './') . '/d"' . tags . ' && ctags -a "' . file . '" &')
  endif
endfunction
autocmd BufWritePost *.php,*.cpp,*.cc,*.h,*.c call UpdateTags()
"======================= Ag silversearch ==========================
"@ref: https://thoughtbot.com/blog/faster-grepping-in-vim
if executable("ag")
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    
    " ag is fast enough the CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif
"======================= Air Line ==========================
let g:airline_theme="tomorrow"
let g:airline_powerline_fonts = 1
" set status line
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
"========================== PHP ============================
function! PhpSyntaxOverride()
    " Put snippet overrides in this function.
    hi! link phpDocTags phpDefine
    hi! link phpDocParam phpType
endfunction
augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END
" php cs fixer
let g:php_cs_fixer_level = 'psr2'
let g:php_cs_fixer_enable_default_mapping = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=psr2'
" php namespace
"=========================== indentLine ============================
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_color_term = 239
let g:indentLine_leadingSpaceChar = '.'
" autocmd FileType html,css,php,c,cpp,swift,python,ruby :IndentLinesEnable
autocmd FileType html,css,php,c,cpp,swift,python,ruby 
"=========================== indentLine ============================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"
"========================== Phpactor ==============================
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>
" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>
" Goto definition of class or class member under the cursor
nmap gd :call phpactor#GotoDefinition()<CR>
" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>
" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>
" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

"========================== NerdTree ==============================
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
map <C-n> :NERDTreeToggle <CR>
map <C-l> :NERDTreeFind <CR>


"========================== NerdCommentor ==============================
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

"========================== coc.nvim ==============================
set cmdheight=2
set updatetime=300

"========================== vim multiple cursor ==============================
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-S-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-S-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"========================== Highlight word under cursor ==============================
"set updatetime=10

"function! HighlightWordUnderCursor()
    "if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]' 
        "exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/' 
    "else 
        "match none 
    "endif
"endfunction

"autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
