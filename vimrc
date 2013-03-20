" Pathogen https://github.com/tpope/vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Switch on syntax highlighting if it wasn't on yet.
if !exists("syntax_on")
 syntax on
endif

" Switch on search pattern highlighting.
set hlsearch

"autocmd GUIEnter * set lines=40 columns=124
"autocmd GUIEnter * set guioptions=egrLtm

set guioptions-=L "disable Left scrollbar on VSplit
set guioptions-=R "disable Right scrollbar on VSplit
set guioptions-=r "disable Right scrollbar

"set gfn=Consolas
"set gfn=Monaco:h10
set gfn=Menlo\ Regular:h11

map <D-'> :maca _cycleWindows:<CR>

map <C-f> <C-]>
map <S-C-Tab> <C-W>W

" press / to search for highlighted expression in V mode
vmap / y/<C-R>"<CR>

set tabstop=3
set shiftwidth=3
set expandtab

set scrolloff=3

set wildmenu
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c

set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>

set nobackup

"colors rainbow_neon
"colors tibet
"colors ps_color
"colors vividchalk
"colors ir_black
"colors simplewhite
let g:solarized_termcolors=16
if has("gui_running")
   set background=dark
   color Tomorrow-Night-Eighties
else
   "colors default
   color Tomorrow-Night
endif
"colors solarized

"if &t_Co >= 256 || has("gui_running")
"   colorscheme mustang
"endif

" Highlight the current line
set cursorline

filetype plugin on
filetype indent on

set fileencodings=ucs-bom,utf-8,latin1

"let xml_use_xhtml = 1

:command W w
:command Q q
:command Wq wq
:command WQ wq

map <C-t> :tabnew<CR>
map <C-left> :tabp<CR>
map <C-right> :tabn<CR>

nnoremap - %
vnoremap - %

" remap cursor keys
nmap <Left> <<
nmap <Right> >>

vmap <Left> <gv
vmap <Right> >gv

" select pasted text
nnoremap gp `[v`]

" No Help, please
nmap <F1> <Esc>

"XML stuff
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

nmap ,,, viw,,,
vnoremap ,,, <Esc>:call TagSelection()<CR>

function! TagSelection()
    let oldpaste = &paste
    if exists("b:tag")
    else
        let b:tag = ""
    endif
    let b:tag = input("Tag name? ", b:tag)
    " Turn on paste mode to avoid autoidenting messing with our positions
    set paste
    let start = substitute( b:tag, '[ \t"]*\(\<.*\)', '<\1>', "" )
    " Strip off all but the first word in the tag for the end tag
    let end   = substitute( b:tag, '[ \t"]*\(\<\S*\>\).*', '<\/\1>', "" )
    exec "normal `>a" . end
    exec "normal `<i" . start
    " Restore autoindent
    if ! oldpaste
        set nopaste
    endif
endfunction


""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""
" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$' ]

let NERDTreeShowBookmarks=0       " Hide the bookmarks table on startup
let NERDTreeShowFiles=1           " Show hidden files, too
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1          " Quit on opening files from the tree
let NERDTreeHighlightCursorline=1 " Highlight the selected entry in the tree
let NERDTreeMouseMode=2           " Use a single click to fold/unfold directories
                                  " and a double click to open files
let g:NERDTreeWinPos = "right"    " Dock the window to the right

nmap <Leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nmap <Leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap <F3> :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap <Leader>N :NERDTreeClose<CR>
nmap <F4> :NERDTreeClose<CR>



""""""""""""""""""""""""
" bufferlist
""""""""""""""""""""""""
map <silent> <Leader>b :call BufferList()<CR>
map <silent> <F2> :call BufferList()<CR>

let g:BufferListWidth= 40
let g:BufferListMaxWidth= 80

nmap <F5> :bprevious<CR>
nmap <F6> :bnext<CR>


""""""""""""""""""""""""
" Ack
""""""""""""""""""""""""
nmap <C-a> :Ack<space>

""""""""""""""""""""""""
" tComment
""""""""""""""""""""""""
map <leader>c <c-_><c-_>

command StripWS %s/\s\+$//e


" crontab editor fix (http://tim.theenchanter.com/2008/07/crontab-temp-file-must-be-edited-in.html)
set backupskip=/tmp/*,/private/tmp/*
