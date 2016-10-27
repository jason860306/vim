" 设置字体，如果字体名称中含有空格
" 需要在空格前面加上一个反绡斜杠
set guifont=Consolas
set helplang=cn
set nocompatible
set number
set history=1000
set background=dark
set smartindent
set tabstop=4
set shiftwidth=4
set showmatch
set vb t_vb=
set ruler
set ru
set hls
set is
set nobackup
set incsearch
set fileencodings=utf-8,gbk,gb2312,big5,gb18030
set hlsearch
set backspace=2
set autoindent
set showmode
set wrapscan
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,],h,l,~
set cscopequickfix=s-,c-,d-,i-,t-,e-

" 修改注释颜色
hi Comment ctermfg =blue
" 修改字符串颜色
hi String ctermfg =darkred
" 修改类型颜色
hi Type ctermfg =yellow
" 修改数字颜色
hi Number ctermfg =darkblue
" 修改常量颜色
hi Constant ctermfg =blue
" 修改声明颜色
hi Statement ctermfg =darkyellow

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplModSelTarget=1

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd='/usr/bin/ctags'

let g:winManagerWindowLayout='FileExplorer|TagList'
map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr>

nnoremap <silent> <F12> :A<CR>
nnoremap <silent> <F3> :Grep<CR> 

colorscheme sean

filetype on
filetype plugin indent on
set completeopt=longest,menu

let g:SuperTabRetainCompletionType=2
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
" 设置按下<Tab>后默认的补全方式, 默认是<C-P>,
" 现在改为<C-X><C-O>.
" 关于<C-P>的补全方式, 
" 还有其他的补全方式, 你可以看看下面的一些帮助:
" :help
" ins-completion
" :help compl-omni

" set foldmethod=syntax
" set foldlevel=100 " 启动vim时不要自动折叠代码

let did_install_default_menus = 4
if did_install_default_menus == 4
	"default menu.vim was suppressed
	unlet did_install_default_menus
	runtime menu.vim
endif 

" Windows下载建议加上这句
set encoding=cp936
" 这两句只在Linux下需要
so $VIMRUNTIME/delmenu.vim
so $VIMRUNTIME/menu.vim

if has("vms")
	set nobackup
else
	set backup
endif

if &t_Co > 1
	syntax enable
	syntax on
endif

set imcmdline

" 插入匹配括号
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" 按退格键时判断当前光标前一个字符，如果是左括号，
" 删除对应的右括号以及括号中间的内容
function! RemovePairs()
	let l:line = getline(".")
	let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符
 
	if index(["(", "[", "{", "\"", "\'"], l:previous_char) != -1
		let l:original_pos = getpos(".")
		execute "normal %"
		let l:new_pos = getpos(".")
 
		" 如果没有匹配的右括号
		if l:original_pos == l:new_pos
			execute "normal! a\<BS>"
			return
		end
 
		let l:line2 = getline(".")
		if len(l:line2) == col(".")
			" 如果右括号是当前行最后一个字符
			execute "normal! v%xa"
		else
			" 如果右括号不是当前行最后一个字符
			execute "normal! v%xi"
		end
 
	else
		execute "normal! a\<BS>"
	end
endfunction
" 用退格键删除一个左括号时同时删除对应的右括号
inoremap <BS> <ESC>:call RemovePairs()<CR>a

if has("gui_running")
"au GUIEnter * simalt ~x " 窗口启动时自动最大化
set guioptions-=m " 隐藏菜单栏
set guioptions-=T " 隐藏工具栏
set guioptions-=L " 隐藏左侧滚动条
set guioptions-=r " 隐藏右侧滚动条
set guioptions-=b " 隐藏底部滚动条
set showtabline=0 " 隐藏Tab栏

nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
"nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

endif 
