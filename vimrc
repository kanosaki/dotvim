
set nocompatible
syntax on
""set term=xterm-256color
filetype on
filetype indent on
filetype plugin on

"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#infect()

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
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap
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

"タブ関連{{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set statusline=[%{winnr('$')>1?':'.winnr().'/'.winnr('$'):''}]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
"}}}

" ディレクトリの自動移動
au   BufEnter *   execute ":lcd " . escape(expand("%:p:h"), " #\\")

"StatusLine Mode Color{{{
"if has('gui_running')
"    augroup InsertHook
"        autocmd!
"        autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2e4340
"        autocmd InsertLeave * highlight StatusLine guifg=#f6f3e8 guibg=#444444
"    augroup END
"else
"    augroup InsertHook
"        autocmd!
"        autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2e4340
"        autocmd InsertLeave * highlight StatusLine guifg=#2e4340 guibg=#ccdc90
"    augroup END
"endif
"}}}
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
"Fキー
"nnoremap <F3> :NERDTreeToggle<CR>
"nnoremap <F4> :BufExplorer<CR>

" Swap + and =
nnoremap = +
nnoremap + =

nnoremap <C-e> $
nnoremap <C-a> ^

"nnoremap <C-/> g/
"nnoremap / :g/
"nnoremap <C-?> g?
"nnoremap ? :g?

nnoremap <Space> <C-d>
nnoremap <S-Space> <C-u> 

"実行
nnoremap <F5> !./%<CR>
"全文オートインデント
"nnoremap <F12> <ESC>gg=G
"nnoremap <C-J> <ESC>

inoremap <C-b> <C-o>b
inoremap <C-f> <ESC>ea
inoremap <C-q> <ESC><ESC>
inoremap <C-a> <C-o>:call WSBack()<CR>

"Create and move new line below and upper with modified return key
inoremap <C-L> <C-o>l
inoremap <C-e> <C-o>$
inoremap <C-k> <C-o>d$
inoremap <C-u> <C-o>k
inoremap <C-d> <Del>

inoremap <C-j> <C-o>o

"バッファ、タブ関連
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
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

" Unite
nnoremap \\ :Unite giti/


" コマンドモード
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>


noremap <silent> ge :NERDTreeToggle<CR>
"noremap <silent> gb :BufExplorer<CR>
"nnoremap tl :TlistToggle<CR>

"Move carret visuallity
nnoremap j gj
nnoremap k gk


"FuzzyFinder
"nnoremap <silent> <C-f>f :FufFile<CR>

"Unite
nnoremap <silent> <C-k>f :<C-u>Unite -vertical file file_mru directory_mru<CR>
nnoremap <silent> gt :<C-u>Unite buffer file file_mru directory_mru<CR>
nnoremap <silent> _ :<C-u>Unite buffer file file_mru directory_mru<CR>
nnoremap <silent> go :<C-u>Unite -vertical outline<CR>
nnoremap <silent> gb :<C-u>Unite buffer<CR>
nnoremap <silent> <C-k>b :<C-u>Unite buffer<CR>
nnoremap <silent> <C-k>o :<C-u>Unite outline<CR>
nnoremap <silent> <C-k>m :<C-u>Unite mark<CR>

"neco keybindings
" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
""inoremap <expr><C-e>  neocomplcache#cancel_popup() 

" yankring
nnoremap <silent> <F11> :YRShow<CR>

"}}}
" プラグインごとの設定 "{{{

"Ctags
let g:Tlist_Ctags_Cmd="/usr/bin/ctags"

" Acp
let g:acp_enableAtStartup=0
let g:acp_ignorecaseOption=1

" pydiction
let g:pydiction_location=expand("$HOME/.vim/vimfiles/complete-dict")

"ropevim
let ropevim_extended_complete=1
let ropevim_vim_completion=1
let rope_guess_project=1

" YankRing
let g:yankring_history_dir = "$HOME/.vim/"
let g:yankring_clipboard_monitor = 1
let g:yankring_min_element_length = 3

"netcomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

" Plugin key-mappings.
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)

"snipMate like behavior
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?
" \ "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"" For snippet_complete marker.
"if has('conceal')
"    set conceallevel=2 concealcursor=i
"endif
"let g:neocomplcache_snippets_dir = $HOME . '/.vim/snippets'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"Unite
"let g:unite_enable_start_insert=1
let g:unite_update_time=50
let g:unite_split_rule="botright"
let g:unite_winwidth=70
let g:unite_source_ack_command="ack"
com! -nargs=* Ack Unite ack:<args>

"showmarks
let g:showmarks_enable=0
let g:showmarks_textlower="\t"

" RSense
let g:rsenseHome=expand("$HOME/local/lib/rsense")
let g:rsenseUseOmniFunc=1

" QuickRun
let g:quickrun_config = {} 
let g:quickrun_config['markdown'] = {
    \ 'outputter' : 'browser'
    \ }
"}}}
" Source Explorer
let g:SrcExpl_pluginList = [
    \ "__Tag_List__",
    \ "_NERD_tree_",
    \ "Source_Explorer"
    \ ]

" PowerLine
let g:Powerline_cache_file=expand("$HOME/.vim/cache/powerline")
let g:Powerline_symbols = 'fancy'

"ファイルタイプごとの設定{{{
"------ Ruby ----------
"autocmd BufNewFile *.rb 0r $HOME/.vim/skeleton/skelton.rb
"----------------------


"------ Haskell -------
au Bufenter *.hs compiler ghc
let g:hs_highlight_delimiters=1
let g:hs_highlight_boolean=1
let g:hs_highlight_types=1
let g:hs_highlight_more_types=1
let g:hs_highlight_debug=1
"configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"
au BufEnter *.hs compiler ghc
"-----------------------

"------ LaTeX --------
" grep will sometimes skip displaying the file name.
"set grepprg=grep\ -nH\ $*
"---------------------
"closetag


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

"ノーマルモードでコマンドを始める
set iminsert=0
set imsearch=-1

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
set clipboard& clipboard+=unnamed

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
colorscheme molokai
if !has('gui_running')
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

