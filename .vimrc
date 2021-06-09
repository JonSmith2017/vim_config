"++++++++++++++++++++++vim config++++++++++++++++++++++++++++"
"File Name: 	.vimrc   (pls put this file in: ~/.vimrc)
"Author:		yinbiao.zhong
"Version: 		v2.0
"Date: 			2019-12-28
"Description: 	use this file to config vim, then u can use it
"             	more conveniently.
"Other:			NA
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"


"+++++++++++++++++++++++++ 常规设置 +++++++++++++++++++++++++++++++++

set nu							" 启用行号"
set ic                          " 在查询及模式匹配时忽赂大小写
set ai							" 自动缩进，新行与前面的行保持—致的自动空格
set showmatch                   " 显示括号配对，当键入“]”“)”时，高亮度显示匹配的括号
set ruler                       " 打开状态栏标尺
set scrolloff=5                 " 设定光标离窗口上下边界 5 行时窗口自动滚动
set tabstop=4                   " 设定 tab 长度为 4
syntax enable					" 自动语法高亮
syntax on                       
set hlsearch					" 搜索高亮
set laststatus=2				" 状态行配置为2行
"set cc=80						" 80 列提醒
set wildmode=list:longest       " 命令行模式补全
set mouse=a						"启用鼠标
"set selection=exclusive
"set selectmode=mouse,key

"set ws/nows                     " 在搜索时如到达文件尾则绕回文件头继续搜索

"+++++++++++++++++++++++++ 高光显示 +++++++++++++++++++++++++++++++++

" 列号显示色彩配置
hi LineNr cterm=NONE ctermbg=NONE ctermfg=59

" 开启光亮光标行
set cursorline
hi CursorLine	cterm=NONE ctermbg=NONE ctermbg=black 

" 开启高亮光标列
set cursorcolumn
hi CursorColumn cterm=NONE ctermbg=NONE ctermbg=black


"+++++++++++++++++++++++++ 底部显示 +++++++++++++++++++++++++++++++++

" 底部显示：当前路径，将$HOME转化为~ | 行号 总行数 用户
highlight StatusLine cterm=bold ctermfg=223 ctermbg=240
function! CurDir()
        let curdir = substitute(getcwd(), $HOME, "~", "g")
		        return curdir
				endfunction
				set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ %{$USER}\ @\ %{hostname()}\

"+++++++++++++++++++++++++ map 重映射快捷键 +++++++++++++++++++++++++
" 保存 及 保存并退出
:map `` :w<CR><Esc>
:map ``` :wq<CR><Esc>
:map <tab>q :q<CR><Esc>
" 粘贴模式
:map `1 :set paste<CR><Esc>
:map `2 :set nopaste<CR><Esc>
" vim 中打开terminal
:map tm :ConqueTermSplit bash<CR><Esc>:res 10<CR>i
:map tmv :ConqueTermVSplit bash<CR>
" 防止误输入
:cmap Wq wq
:cmap WQ wq
:cmap wQ wq
:cmap Q q

"+++++++++++++++++++++++++ ctags 配置++++++++++++++++++++++++++++++++
set tags=tags;
set autochdir

"启动vim后自动打开taglist窗口
let Tlist_Auto_Open = 1

"不同时显示多个文件的tag，仅显示一个
"let Tlist_Show_One_File = 1

"taglist为最后一个窗口时，退出vim
let Tlist_Exit_OnlyWindow = 1

"taglist窗口显示在右侧，缺省为左侧
"let Tlist_Use_Right_Window =1

"设置taglist窗口大小
"let Tlist_WinHeight = 100
let Tlist_WinWidth = 35
"横向窗口
"let Tlist_Use_Horiz_Window=1
"焦点
let Tlist_GainFocus_On_ToggleOpen=0

"设置taglist打开关闭的快捷键F3
noremap <F3> :TlistToggle<CR>

"更新ctags标签文件快捷键设置
noremap <F6> :!ctags -R<CR>

" 重映射ctags 进入定义与返回
:map <tab>] <C-]>
:map <tab>[ <C-o>

"+++++++++++++++++++++++++ NerdTree 配置++++++++++++++++++++++++++++++++

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	Plugin 'gmarik/Vundle.vim'
	Plugin 'scrooloose/nerdtree'
call vundle#end()

" NerdTree才插件的配置信息
""将F2设置为开关NERDTree的快捷键
map <f2> :NERDTreeToggle<cr>
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
""窗口位置
let g:NERDTreeWinPos='left'
""窗口尺寸
let NERDTreeWinSize=20
""窗口是否显示行号
let g:NERDTreeShowLineNumbers=0
""不显示隐藏文件
let g:NERDTreeHidden=0

""自动打开NerdTree
"autocmd BufRead * 25vsp ./

""当文本编辑界面退出后，自动关闭所有窗口
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif



"+++++++++++++++++++++++++ cscope 配置++++++++++++++++++++++++++++++++
"if filereadable("cscope.out")
"    cs add csope.out
"elseif $CSCOPE_DB  != ""
"    cs add $CSCOPE_DB
"endif

if has("cscope")  
	set csprg=/usr/bin/cscope  
	set csto=0  
	set cst  
	set csverb  
	set cspc=3  
"add any database in current dir  
	if filereadable("cscope.out")  
		:cs add cscope.out  
"else search cscope.out elsewhere  
	else  
		let cscope_file=findfile("cscope.out", ".;")  
		let cscope_pre=matchstr(cscope_file, ".*/")  
		if !empty(cscope_file) && filereadable(cscope_file)  
			:exe "cs add" cscope_file cscope_pre  
	endif        
	endif  
	endif  

nmap <tab>\ :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <tab>\\ :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-a>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-a>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-a>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-a>f :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap <C-a>i :cs find i ^<C-R>=expand("<cword>")<CR><CR>
nmap <C-a>d :cs find d <C-R>=expand("<cword>")<CR><CR>

":cs add cscope.out
