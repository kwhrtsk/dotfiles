" vim:set foldmethod=marker:
set foldlevel=100 " don't autofold
set nu
set ruler
set nrformats-=octal
set history=10000
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildmode=list:longest
set smartcase
set incsearch
set hlsearch
set noerrorbells
set novisualbell
set visualbell t_vb=
set hidden
set nowrap
set expandtab
set autoindent

" <F11>でpasteをトグル
set pastetoggle=<F11>

syn on
set ts=2 sw=2 sts=2

" keymaps

let mapleader = ','
nnoremap <C-n> :bn<Enter>
nnoremap <C-p> :bp<Enter>

cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>

" qfixhown
" set runtimepath+=${HOME}/.vim/app/qfixapp

"キーマップリーダー
let QFixHowm_Key = 'g'
"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir             = '~/.howm/'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'

" メニューを自動で閉じる
let QFixHowm_MenuCloseOnJump = 1

" backup dir
set backupdir=$HOME/.vimbackup

" swapfiles
set directory=~/.vimswap/

" dein {{{
if &compatible
  set nocompatible
endif

" 設定ファイル類のディレクトリ
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:nvim_dir = s:config_home . '/nvim'
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" 初回のみgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  " 管理するプラグインを記述したファイル
  let s:toml = s:nvim_dir . '/dein.toml'
  let s:lazy_toml = s:nvim_dir . '/dein_lazy.toml'

  " init.vim, dein.toml, dein_lazy.tomlに変更があれば再読み込み
	call dein#begin(s:dein_dir, [$MYVIMRC, s:toml, s:lazy_toml])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
" }}}

" Unite {{{
let g:unite_enable_start_insert=1
nnoremap [unite]    <Nop>
nmap     ,u [unite]
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>VimFilerBufferDir<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite -vertical outline<CR>
" }}}

" VimFiler {{{
let g:vimfiler_safe_mode_by_default = 0
" }}}

" neoterm {{{
tnoremap <ESC> <C-\><C-n>
" }}}

" vim-test {{{
let test#strategy = "neoterm"
let test#javascript#mocha#file_pattern = 'spec\.js'
nnoremap gq :TestNearest<Enter>
" }}}

" quickrun {{{
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['watchdogs_checker/_'] = {
        \ 'runner' : 'vimproc',
        \ 'runner/vimproc/sleep' : 10,
        \ 'runner/vimproc/updatetime' : 100,
        \ 'outputter/quickfix/open_cmd' : '',
        \ 'hook/echo/enable' : 0,
        \ 'hook/echo/output_success' : '> No Errors Found.',
        \ }

" eslint_dがある場合は使う
if executable('eslint_d')
  let g:quickrun_config['javascript/watchdogs_checker'] = {
        \ 'type' : 'watchdogs_checker/eslint',
        \ }
  let g:quickrun_config['javascript.jsx/watchdogs_checker'] = {
        \ 'type' : 'eslint',
        \ }
  let g:quickrun_config['watchdogs_checker/eslint'] = {
        \ 'command' : 'eslint_d',
        \ }
endif

if executable('rubocop')
  let g:quickrun_config['ruby/watchdogs_checker'] = {
				\ "type" : "watchdogs_checker/rubocop"
				\ }
endif

" バッファ保存時にwatchdogsがquickrunを起動するファイルタイプを指定
let g:watchdogs_check_BufWritePost_enables = {
      \ 'javascript'     : 1,
      \ 'javascript.jsx' : 1,
      \ 'ruby'           : 1,
      \ 'elm'            : 1,
      \ }
" }}}

" lightline {{{
" フルパスでファイル名を表示する
let g:lightline = {
      \ 'component_function': {
      \   'filename' : 'LightLineFilename',
      \ }
      \ }
function! LightLineFilename()
  return expand("%")
endfunction
" }}}

" SQLUtilities {{{
let g:sqlutil_align_comma=1
vmap <silent>sf <Plug>SQLUFormatter<CR>
" }}}
"
set background=dark
colo hybrid

" eashmotion {{{
" }}}
