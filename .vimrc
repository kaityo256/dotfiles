"------------------------------------------------------------------------
"   各種基本設定
"------------------------------------------------------------------------
" 行番号は非表示
set nonumber
" カーソル位置を表示
set ruler
" ウィンドウのタイトルバーにファイル情報を表示
set title
" タブストップを空白二つに
set tabstop=2
" タブキーを押した時に挿入される空白数
set softtabstop=2
" vimが挿入するインデント幅
set shiftwidth=2
" 検索結果のハイライト表示
set hlsearch
" esc連打で検索ハイライト消去
nnoremap  <esc><esc> :<c-u>nohlsearch<cr><esc>

" カーソル位置等の設定の保存と復元
autocmd BufWinLeave ?* silent mkview
autocmd BufWinEnter ?* silent loadview

" エスケープを二回叩いたら検索結果のハイライト表示を消す
nnoremap <ESC><ESC> :<C-u>nohlsearch<cr><Esc>

" コメント中に改行してもコメントが追加されないようにする
autocmd FileType * setlocal formatoptions-=ro

"------------------------------------------------------------------------
" カレントディレクトリに.vimrc.localがあったら読み込む
" ALEにinclude pathを教えるのに使う
"------------------------------------------------------------------------
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

"------------------------------------------------------------------------
" dein向けの設定
"------------------------------------------------------------------------

" dein.vimインストール時に指定したディレクトリをセット
let s:dein_dir = expand('~/.cache/dein')

" dein.vimの実体があるディレクトリをセット
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " dein.toml, dein_layz.tomlファイルのディレクトリをセット
  let s:toml_dir = expand('~/.vim')
  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  " 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
"------------------------------------------------------------------------
" gnuplot file(*.plt)のシンタックスハイライティング
au BufRead,BufNewFile *.plt set filetype=gnuplot

" Ruby Formatter (rufo)を使う
"let g:rufo_auto_formatting=1

" ハイライト表示
syntax on
" ファイルタイプを(インデントやプラグインも含めて)有効化
filetype plugin indent on

let g:ale_tex_chktex_options = "-n 8"

" 保存時に自動でfixerをかける
let g:ale_fixers = {
    \ 'python': ['autopep8', 'black', 'isort'],
    \ 'ruby': ['rufo'],
    \ 'cpp': ['clang-format'],
    \ }
let g:ale_fix_on_save = 1
set encoding=utf8
set visualbell t_vt=
colorscheme delek
