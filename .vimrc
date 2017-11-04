" ######################################################################
" ## dein configuration start                                         ##
" ######################################################################
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand("~/.vim/dein")
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " プラグインリストを収めた TOML ファイル
    let g:rc_dir    = expand('~/.vim/rc')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    " TOML を読み込み、キャッシュしておく
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    " 設定終了
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
" ######################################################################
" ## dein configuration end                                           ##
" ######################################################################

" ######################################################################
" ## neocomplete configuration start                                  ##
" ######################################################################
" enable neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
" ######################################################################
" ## neocomplete configuration end                                    ##
" ######################################################################

" ######################################################################
" ## syntastic configuration start                                    ##
" ######################################################################
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" ######################################################################
" ## syntastic configuration end                                      ##
" ######################################################################

" ######################################################################
" ## color scheme configuration start                                 ##
" ######################################################################
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" set t_Co=256
" set background=dark
" set background=light
" colorscheme solarized
hi LineNr ctermfg=darkgray
hi CursorLineNr ctermfg=red
set cursorline
hi clear CursorLine

" ######################################################################
" ## color scheme configuration end                                   ##
" ######################################################################

syntax on
syntax enable
set autoindent
set number
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set autoread
set hlsearch
