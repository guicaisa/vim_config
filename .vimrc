call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
" Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax enable

" 显示行号
set nu
" 字符编码utf8
set encoding=utf8
set cursorline
" 缩进
set cindent
set tabstop=4
set shiftwidth=4
" 查询高亮
set hlsearch
"设置剪切板
set clipboard+=unnamedplus

" nerdtree
autocmd StdinReadPre * let s:std_in=1
" 打开vim的时候，如果指定了一个文件，将光标定位在文件的窗口
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" 打开vim的时候，vim指定的参数为一个文件
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" 当nerdtree为最后一个窗口时，关闭vim
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" airline
" 显示所有buffer
let g:airline#extensions#tabline#enabled = 1
" 使用powerline的符号和字体
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_left_sep = '⮀' 
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" ycm
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = "/usr/bin/clangd" 

" 按键映射
" 切换到上一个buffer
nnoremap <C-p> :bp<CR>
nnoremap <C-left> :bp<CR>
" 切换到下一个buffer
nnoremap <C-n> :bn<CR>
nnoremap <C-right> :bn<CR>
" 关闭查询高亮
nnoremap <F4> :nohlsearch<CR>

" 主题
colorscheme gruvbox 
set background=dark

" coc

let g:coc_global_extensions = ['coc-snippets', 'coc-explorer']

inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ CheckBackspace() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction 

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-type-definition)
nmap <silent> <F3> <Plug>(coc-implementation)
nmap <silent> <F2> <Plug>(coc-references)

let g:coc_snippet_next = '<tab>'
call coc#config('coc.preferences',{
			\ 	"formatOnSaveFiletypes":["go"],
			\ 	"bracketEnterImprove":"true"
			\})
call coc#config('diagnostic',{
			\ 	"checkCurrentLine":"true"
			\})
call coc#config('languageserver',{
			\ 'golang': {
			\ 	"command": "gopls",
			\ 	"rootPatterns": ["go.mod",".git/"],
			\ 	"disableWorkspaceFolders": "true",
			\ 	"filetypes": ["go"]
			\ },
			\ 'clangd': {
			\ 	"command": "clangd",
			\ 	"rootPatterns": ["compile_flags.txt", "compile_commands.json"],
			\ 	"filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"]
			\ }
			\})

set tagfunc=CocTagFunc
