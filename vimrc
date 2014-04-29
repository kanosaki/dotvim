
set nocompatible

" Around multiclinent
if has('win32') || has('win64')
    let $VIMRC_ROOT = expand('$VIM')
else
    let $VIMRC_ROOT = expand('$HOME/.vim')
endif

function! VimrcRelpath(expr)
    return expand("$VIMRC_ROOT/".a:expr)
endfunction

" NeoBundle {{{
filetype off

if has('vim_starting')
  let $NEOBUNDLE_DIR = VimrcRelpath('bundle/neobundle.vim')
  set runtimepath+=$NEOBUNDLE_DIR
  call neobundle#rc(VimrcRelpath('bundle'))
endif

"
" Basic Bundles
"
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'Shougo/neocomplcache', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}

" {{{ neocomplcache configurations
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}} 
NeoBundleLazy 'Shougo/neosnippet', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}
let s:bundle = neobundle#get('neosnippet')
function! s:bundle.hooks.on_source(bundle)
    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
endfunction

NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ } }
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kmnk/vim-unite-giti'
nnoremap <silent> <Leader>\ :Unite giti<CR>
nnoremap <silent> <Leader>gb :Unite giti/branch<CR>
nnoremap <silent> <Leader>gs :Unite giti/status<CR>

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'bling/vim-airline'
let g:airline_branch_prefix = ''
let g:airline_readonly_symbol = 'RO'
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline_theme = 'luna'
let g:airline#extensions#whitespace#enabled = 0
"NeoBundle 'YankRing.vim'

" CtrlP
NeoBundle 'kien/ctrlp.vim'

NeoBundle 'LeafCage/yankround.vim'
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
nnoremap <silent> <Leader>p :CtrlPYankRound<CR>
let g:yankround_max_history = 50


NeoBundleLazy 'osyo-manga/vim-over', {
            \   'autoload'  : { 'commands' : ['OverCommandLine'] }
            \}

nnoremap <silent> <Leader>o :OverCommandLine<CR>
let g:over_command_line_prompt = 'vim-over >>> '

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'Shougo/neomru.vim'
nnoremap <Leader>a :Alignta 

NeoBundle 'Shougo/unite-outline'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 't9md/vim-unite-ack'

NeoBundle 'scrooloose/syntastic'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
"NeoBundle 'closetag.vim'

NeoBundleLazy 'Shougo/vimshell', {
    \   'autoload' : { 'commands' : [ 'VimShell', "VimShellPop", "VimShellInteractive" ] }
    \}
nnoremap <silent> <Leader>s :VimShellPop<CR>
nnoremap <silent> <Leader><S-S> :VimShell<CR>
nnoremap <silent> - :VimShellPop<CR>

NeoBundleLazy 'Shougo/vimfiler', {
            \   'autoload'  : { 'commands' : [ 'VimFilerBufferDir', 'VimFiler', 'VimFilerExplorer' ] },
            \   'depends'   : [ 'Shougo/unite.vim' ],
            \}
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
    let g:vifiler_as_default_explorer=1
endfunction
nnoremap <silent> ge :<C-u>VimFilerBufferDir -toggle -explorer -split -simple -winwidth=35<CR>
nnoremap <silent> gr :<C-u>VimFilerBufferDir -toggle<CR>
nnoremap <silent> + :<C-u>VimFilerBufferDir -toggle<CR>
nnoremap <silent> <Leader>f :<C-u>VimFilerBufferDir -toggle<CR>
"
" Optional Bundles
"

" C/C++
NeoBundleLazy 'c.vim', {
    \    "autoload" : { "filetypes" : ["c", "cpp"] }   
    \}

" Python
NeoBundleLazy 'klen/python-mode', {
    \    "autoload" : { "filetypes" : ["python"] }   
    \}
let s:bundle = neobundle#get('python-mode')
function! s:bundle.hooks.on_source(bundle)

endfunction

" SGMLs
NeoBundleLazy 'mattn/zencoding-vim', {
    \    "autoload" : { "filetypes" : ["html", "xml", "xhtml", "eruby", "scala"] }   
    \}

" Haskell
NeoBundleLazy 'dag/vim2hs', {
    \    "autoload" : { "filetypes" : ["haskell"] }   
    \}
let s:bundle = neobundle#get('vim2hs')
function! s:bundle.hooks.on_source(bundle)
    let g:haskell_conceal = 0
endfunction
NeoBundleLazy 'eagletmt/ghcmod-vim', {
    \    "autoload" : { "filetypes" : ["haskell"] }   
    \}
let s:bundle = neobundle#get('ghcmod-vim')
function! s:bundle.hooks.on_source(bundle)
    nnoremap <silent> <Leader>i :GhcModInfoPreview<CR>
    nnoremap <silent> <Leader>t :GhcModTypeInsert<CR>
    nnoremap <silent> <Leader>l :GhcModCheckAndLintAsync<CR>
    augroup ghcmodcheck
      autocmd! BufWritePost <buffer> GhcModCheckAsync
    augroup END
endfunction
NeoBundleLazy 'eagletmt/unite-haddock', {
    \   "autoload" : { "filetypes" : ["haskell"] }   
    \}
NeoBundleLazy 'ujihisa/neco-ghc', {
    \   "autoload" : { "filetypes" : ["haskell"] }   
    \}
" Ruby and Rake
"NeoBundle 'tpope/vim-rake'
NeoBundleLazy 'ujihisa/unite-rake', {
      \ 'depends' : 'Shougo/unite.vim' }

" Rails
NeoBundleLazy 'tpope/vim-rails' , {
    \   'autoload'  : { 'commands' : [ 'VimFilerBufferDir', 'VimFiler', 'VimFilerExplorer' ],
    \                   'filetype': ["ruby"] },
    \}

NeoBundleLazy 'basyura/unite-rails', {
    \   'depends'   : [ 'Shougo/unite.vim' ],
    \}

" Coffee script
NeoBundleLazy 'kchmck/vim-coffee-script', {
    \    "autoload" : { "filetypes" : ["coffee"] }   
    \}
" }}}

" Coffee script
NeoBundleLazy 'derekwyatt/vim-scala', {
    \    "autoload" : { "filetypes" : ["scala"] }   
    \}
" }}}

" Erlang
NeoBundleLazy 'oscarh/vimerl', {
    \   "autoload" : { "filetypes" : ["erlang"] }   
    \}

" Utils
"NeoBundle 'tyru/restart.vim'

" REGREL
"NeoBundle 'kanosaki/regrel.vim'

syntax on
filetype on
filetype indent on
filetype plugin on
" 表示 "{{{

"タイトルを表示
set notitle
" Title length.
set titlelen=95
" Title string.
set titlestring=%f%(\ %M%)%(\ (%{getcwd()})%)%(\ %a%)
set autowrite
set scrolloff=5 " スクロール時の余白確保
set sidescrolloff=8
set showmatch
set backup
let $VIM_BACKUPDIR=VimrcRelpath('backup')
if !isdirectory($VIM_BACKUPDIR)
    call mkdir($VIM_BACKUPDIR)
endif
set backupdir=$VIM_BACKUPDIR
let $VIM_SWAPDIR=VimrcRelpath('swap')
if !isdirectory($VIM_SWAPDIR)
    call mkdir($VIM_SWAPDIR)
endif
set swapfile
set directory=$VIM_SWAPDIR
set number
set history=100
set list
set listchars=tab:\ \ ,extends:<,trail:\ 
set laststatus=2
set wildmode=list:longest
set wildmenu
set backspace=indent,eol,start
set autoindent smartindent
set smarttab
set whichwrap=b,s,h,l,<,>,[,]
set nowrap
set nostartofline
set confirm
set mouse=a
set modeline
set cul
set more
set autoread
set cmdheight=2
set ttyfast
set ttymouse=xterm2
set lazyredraw
set ruler

"Don't show welcome message
set shortmess=aTI

set matchpairs+=<:>

" Powerline settings
" This must not be in gvimrc, but vimrc.
"if has('gui_running')
"    let g:Powerline_symbols = 'fancy'
"endif

"タブ関連{{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set statusline=[%{winnr('$')>1?':'.winnr().'/'.winnr('$'):''}]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
"}}}

" ディレクトリの自動移動
"au   BufEnter *   execute ":lcd " . escape(expand("%:p:h"), " #\\")

"}}}
" バッファ関連 "{{{
" 切り替え時のundoの効果持続等
set hidden           

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright

"}}}
" キーバインド "{{{

nnoremap <C-e> $
nnoremap <C-a> ^

nnoremap <Space> <C-d>
nnoremap <S-Space> <C-u> 

"実行
nnoremap <F5> !./%<CR>
"全文オートインデント

inoremap <C-b> <C-o>b
inoremap <C-f> <ESC>ea
inoremap <C-q> <ESC>
silent !stty -ixon > /dev/null 2>/dev/null
inoremap <C-a> <C-o>:call WSBack()<CR>

"Create and move new line below and upper with modified return key
inoremap <C-L> <C-o>l
inoremap <C-e> <C-o>$
inoremap <C-k> <C-o>d$
inoremap <C-u> <C-o>k
inoremap <C-d> <Del>

inoremap <C-j> <C-o>o

"バッファ、タブ関連
nnoremap tp :tabprevious<CR>
nnoremap tn :tabnext<CR>
nnoremap tm :tabmove 
nnoremap te :tabe 
nnoremap tc :tabclose<CR>
nnoremap <M-h> <C-W>h
nnoremap <M-j> <C-W>j
nnoremap <M-k> <C-W>k
nnoremap <M-l> <C-W>l
nnoremap <M-n> :bn<CR>
nnoremap <M-p> :bp<CR>
nnoremap <M-d> :bd<CR>
nnoremap <M-q> :q<CR>
nnoremap <D-D> :bd<CR>

"オムニ補完
inoremap <C-Space> <C-X><C-O>
"ノーマルモードで簡易編集
nnoremap <DEL> x
nnoremap <BS> X
nnoremap <C-h> X
nnoremap <Return> i<Return><ESC>
nnoremap <C-Return> o<ESC>
              
"検索したとき に、カーソルが画面の真ん中に来るようにする
nnoremap n nz z
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz



" コマンドモード
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>


"Move carret visuallity
nnoremap j gj
nnoremap k gk

"Unite
nnoremap <silent> <C-k>f :<C-u>Unite -vertical file file_mru directory_mru<CR>
nnoremap <silent> _ :<C-u>Unite buffer file file_mru directory_mru<CR>
nnoremap <silent> <Leader>u :<C-u>Unite buffer file file_mru directory_mru<CR>
nnoremap <silent> go :<C-u>Unite -vertical outline<CR>
nnoremap <silent> gb :<C-u>Unite buffer<CR>
nnoremap <silent> <C-k>b :<C-u>Unite buffer<CR>
nnoremap <silent> <C-k>o :<C-u>Unite outline<CR>
nnoremap <silent> <C-k>m :<C-u>Unite mark<CR>

" disable ?(Search backward) and use ? as ack search
nnoremap ? :<C-u>Unite ack<CR>

"}}}
" プラグインごとの設定 "{{{

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


let g:untie_split_rule='botright'
let g:unite_winwidth=70
if executable('ack')
    let g:unite_source_ack_command="ack"
    com! -nargs=* Ack Unite ack:<args>
elseif executable('ack-grep')
    let g:unite_source_ack_command="ack-grep"
    com! -nargs=* Ack Unite ack:<args>
else
    echo 'ack command not found'
endif

" RSense
let g:rsenseUseOmniFunc=1


" }}}
"ファイルタイプごとの設定{{{

au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2



"}}}
" Omni completion{{{

"Omnicomplete with TAB
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>


"}}}
" Folding "{{{
set foldenable
set foldmethod=marker
set foldcolumn=3

highlight Folded ctermbg=none
highlight FoldColumn ctermbg=none

"}}}
" 検索 "{{{

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
set smartcase
" 検索文字のハイライトをする
set hlsearch
" インクリメンタルサーチ
set incsearch
"<C-l>でハイライトを除去
nnoremap <silent> <ESC><ESC> :nohl<CR>

" Use vimgrep as grep
set grepprg=internal
"}}}
" 日本語設定 "{{{
" Disable IME on Normal mode

" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
if !has('kaoriya')
    " 文字コードの自動認識
    if &encoding !=# 'utf-8'
        set encoding=japan
        set fileencoding=japan
    endif
    if has('iconv')
        let s:enc_euc = 'euc-jp'
        let s:enc_jis = 'iso-2022-jp'
        " iconvがeucJP-msに対応しているかをチェック
        if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
            let s:enc_euc = 'eucjp-ms'
            let s:enc_jis = 'iso-2022-jp-3'
            " iconvがJISX0213に対応しているかをチェック
        elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
            let s:enc_euc = 'euc-jisx0213'
            let s:enc_jis = 'iso-2022-jp-3'
        endif
        " fileencodingsを構築
        if &encoding ==# 'utf-8'
            let s:fileencodings_default = &fileencodings
            let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
            let &fileencodings = &fileencodings .','. s:fileencodings_default
            unlet s:fileencodings_default
        else
            let &fileencodings = &fileencodings .','. s:enc_jis
            set fileencodings+=utf-8,ucs-2le,ucs-2
            if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
                set fileencodings+=cp932
                set fileencodings-=euc-jp
                set fileencodings-=euc-jisx0213
                set fileencodings-=eucjp-ms
                let &encoding = s:enc_euc
                let &fileencoding = s:enc_euc
            else
                let &fileencodings = &fileencodings .','. s:enc_euc
            endif
        endif
        " 定数を処分
        unlet s:enc_euc
        unlet s:enc_jis
    endif
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif


"}}}
" Utility"{{{

" -------------------
" 自動保存
" -------------------
autocmd CursorHold * call NewUpdate()
set updatetime=500
let g:svbfre = '.\+'

" Use clipboard register.
if $TMUX == ''
    set clipboard+=unnamed
endif

" create directory automatically
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

"}}}
" テーマ "{{{
if has('gui_running')
    colorscheme wombat
else
    colorscheme molokai
    hi CursorLine term=none cterm=none ctermbg=233
endif
" }}}
"Functions "{{{

fun! WSBack()
    let rest = getline('.')[0:col('.')-2]
    if rest =~ '^\s*$'
        normal 0
    else
        normal ^
    endif
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
    let l:s = ''

    for l:i in range(1, tabpagenr('$'))
        let l:bufnrs = tabpagebuflist(i)
        let l:curbufnr = l:bufnrs[tabpagewinnr(l:i) - 1]  " first window, first appears

        let l:no = (l:i <= 10 ? l:i-1 : '#')  " display 0-origin tabpagenr.
        let l:mod = len(filter(l:bufnrs, 'getbufvar(v:val, "&modified")')) ? '!' : ' '
        let l:title = gettabwinvar(l:i, tabpagewinnr(l:i), 'title')
        if l:title == ''
            let l:title = fnamemodify(gettabwinvar(l:i, tabpagewinnr(l:i), 'cwd'), ':t')
            if l:title == ''
                let l:title = fnamemodify(bufname(l:curbufnr),':t')
                if l:title == ''
                    let l:title = '[No Name]'
                endif
            endif
        endif

        let l:s .= '%'.l:i.'T'
        let l:s .= '%#' . (l:i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let l:s .= l:no . ':' . l:title . l:mod
        let l:s .= '%#TabLineFill#  '
    endfor

    let l:s .= '%#TabLineFill#%T%=%#TabLine#|%999X %X'
    return l:s
endfunction "}}}
"let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" 自動更新
function! NewUpdate()
    let time = strftime("%H", localtime())
    exe "set backupext=.".time
    if expand('%') =~ g:svbfre && !&readonly && &buftype == ''
        silent! update
    endif
endfunction

" Enable menu in console.
if !has('gui_running')
    source $VIMRUNTIME/menu.vim
    set cpo-=<
    set wcm=<C-z>
    noremap <F2> :emenu <C-z>
endif

fun! Filename(...)
    let filename = expand('%:t:r')
    if filename == '' | return a:0 == 2 ? a:2 : '' | endif
    return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
endf

"}}}

