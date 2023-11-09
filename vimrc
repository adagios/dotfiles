" Pathogen https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged' (JN: didn't for compat)
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'dense-analysis/ale'

if has('nvim')
   Plug 'neovim/nvim-lspconfig'
end

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'rust-lang/rust.vim'

Plug 'posva/vim-vue'
" vou deixar este comentado, é mais novo mas o outro ainda tem mais seguidores
"Plug 'leafOfTree/vim-vue-plugin'

Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" Initialize plugin system
call plug#end()

if has('nvim')
lua << EOF
   local nvim_lsp = require('lspconfig')

   -- Use an on_attach function to only map the following keys
   -- after the language server attaches to the current buffer
   local on_attach = function(client, bufnr)
     local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
     local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

     --Enable completion triggered by <c-x><c-o>
     buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

     -- Mappings.
     local opts = { noremap=true, silent=true }

     -- See `:help vim.lsp.*` for documentation on any of the below functions
     buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
     buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
     buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
     buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
     buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
     buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
     buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
     buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
     buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
     buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
     buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
     buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
     buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
     buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
     buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

   end

   -- Use a loop to conveniently call 'setup' on multiple servers and
   -- map buffer local keybindings when the language server attaches
   local servers = { "bashls", "html", "tsserver", "vuels" }
   for _, lsp in ipairs(servers) do
     nvim_lsp[lsp].setup {
       on_attach = on_attach,
       flags = {
         debounce_text_changes = 150,
       }
     }
   end
EOF
end

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text
set mouse=n       " mouse funciona em modo normal

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Switch on syntax highlighting if it wasn't on yet.
if !exists("syntax_on")
 syntax on
endif

" Switch on search pattern highlighting.
set hlsearch

autocmd GUIEnter * set lines=70 columns=124
"autocmd GUIEnter * set guioptions=egrLtm

set guioptions-=L "disable Left scrollbar on VSplit
set guioptions-=R "disable Right scrollbar on VSplit
set guioptions-=r "disable Right scrollbar

set diffopt+=indent-heuristic "https://vimways.org/2018/the-power-of-diff/
if &diff
  set fullscreen
  autocmd VimResized * wincmd =
  map <leader>1 :diffget LOCAL<CR>
  map <leader>3 :diffget REMOTE<CR>
endif

"set gfn=Consolas
"set gfn=Monaco:h10
set gfn=Menlo\ Regular:h11

map <D-'> :maca _cycleWindows:<CR>

map <C-g> <C-]>
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

" autoload files that have changed outside of vim (we can always undo changes)
set autoread

set termguicolors
"colors rainbow_neon
"colors tibet
"colors ps_color
"colors vividchalk
"colors ir_black
"colors simplewhite
"let g:solarized_termcolors=16
if has("gui_running")
   " set background=dark
   " color Tomorrow-Night-Eighties
   color Tomorrow
   if &diff
      colorscheme PaperColor
   endif
else
   "colors default
   " color Tomorrow-Night
   color Tomorrow
endif
"colors solarized

"if &t_Co >= 256 || has("gui_running")
"   colorscheme mustang
"endif

" Highlight the current line
" jone 2017-10-04: desliguei porque tornava o scroll lento no iterm2
" set cursorline

filetype plugin on
filetype indent on

set fileencodings=ucs-bom,utf-8,latin1

"let xml_use_xhtml = 1

:command! W w
:command! Q q
:command! Wq wq
:command! WQ wq

" map <C-t> :tabnew<CR>
" map <C-left> :tabp<CR>
" map <C-right> :tabn<CR>

""""""""""
" splits "
""""""""""
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright


nnoremap - %
vnoremap - %

" remap cursor keys
nmap <Left> <<
nmap <Right> >>

vmap <Left> <gv
vmap <Right> >gv

" select pasted text
nnoremap gp `[v`]

" copy to system clipboard
vmap <C-c> "+y

" No Help, please
nmap <F1> <Esc>

" Start with all folds open
set foldlevelstart=99

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
" Terminal
""""""""""""""""""""""""
command! -nargs=* T split | terminal <args>
noremap <Leader>t :T<CR>a

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

" exclude quickfix from buffer list
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END


""""""""""""""""""""""""
" Ack
""""""""""""""""""""""""
nmap <C-a> yiw:Ack<space><C-r>"
nnoremap <Leader>ac yiw:Ack<space><C-r>"
nnoremap <Leader>as :Ack<space><C-r>/
if executable('ag')
   let g:ackprg = 'ag --vimgrep'
endif

""""""""""""""""""""""""
" tComment
""""""""""""""""""""""""
map <leader>c <c-_><c-_>

command! StripWS %s/\s\+$//e
command! StripPivotal %s/\[#[^\]]*\]/[REDACTED]/e


" crontab editor fix (http://tim.theenchanter.com/2008/07/crontab-temp-file-must-be-edited-in.html)
set backupskip=/tmp/*,/private/tmp/*,tmp/*,/private/var/at/tmp/*
autocmd FileType crontab setlocal nowritebackup

""""""""""""""""""""""""
" GO
""""""""""""""""""""""""
" run fmt after save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd FileType go compiler go
autocmd FileType go setlocal foldmethod=syntax


""""""""""""""""""""""""
" Shell
""""""""""""""""""""""""
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
vnoremap <C-r> "ry:Shell <C-r>r
noremap <leader>r vip"ry:Shell <C-r>r<CR><CR>
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

""""""""""""""""""""""""
" airline
""""""""""""""""""""""""

let g:airline_theme='base16_classic_light'
let g:airline_powerline_fonts = 1

let g:airline_section_b = "%{airline#util#wrap(airline#extensions#hunks#get_hunks(),100)}"
let g:airline_section_z =  "%p%% %#__accent_bold#%l%#__restore__#%#__accent_bold#/%L%#__restore__# %#__accent_bold#%v%#__restore__#"

let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""
" fzf
""""""""""""""""""""
nnoremap <silent> <C-t> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" :BD para selecionar buffers para apagar
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))


""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""
"let g:syntastic_java_checkers = []

""""""""""""""""""""""""
" js-beautify
""""""""""""""""""""""""
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

""""""""""""""""""""""""
" to auto-complete files relative to current file
" C-x C-f
""""""""""""""""""""""""
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

set path=.,,src/,test/

" for a faster GitGutter update
set updatetime=100
