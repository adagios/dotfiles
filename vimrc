" Pathogen https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged' (JN: didn't for compat)
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'chriskempson/base16-vim'

" comentei para não ter repetidos
"Plug 'dense-analysis/ale'

if has('nvim')
   Plug 'neovim/nvim-lspconfig'
end

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

Plug 'rust-lang/rust.vim'

Plug 'posva/vim-vue'
" vou deixar este comentado, é mais novo mas o outro ainda tem mais seguidores
"Plug 'leafOfTree/vim-vue-plugin'

Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'pangloss/vim-javascript'

Plug 'rickhowe/spotdiff.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'lewis6991/gitsigns.nvim'
Plug 'airblade/vim-gitgutter'

Plug 'glench/vim-jinja2-syntax'

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
     buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
     buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
     buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
     buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
     buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
     buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
     buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
     buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
     buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
     buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({})<CR>', opts)
     buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
     buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
     buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
     buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

   end

   -- Use a loop to conveniently call 'setup' on multiple servers and
   -- map buffer local keybindings when the language server attaches
   local servers = { "bashls", "html", "ts_ls", "vuels", "rust_analyzer", "pyright" }
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

if has('nvim')
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
     enable = true,
     keymaps = {
        init_selection = "<M-Up>", -- set to `false` to disable one of the mappings
        node_incremental = "<M-Up>",
        scope_incremental = "grc",
        node_decremental = "<M-Down>",
     },
  },
}
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
  if has("gui_running")
    set fullscreen
    autocmd VimResized * wincmd =
  endif
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

" don't show preview when using omnifunc
set completeopt-=preview

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
   color base16-tomorrow
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

let g:airline_section_b = ""
let g:airline_section_z =  "%p%% %#__accent_bold#%l%#__restore__#%#__accent_bold#/%L%#__restore__# %#__accent_bold#%v%#__restore__#"

let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""
" fzf
""""""""""""""""""""

""""""""""""""""""""
" telescope
""""""""""""""""""""
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <C-t> <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <C-a> <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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


""""""""""""""""""""""""
"     GitGutter
""""""""""""""""""""""""
" for a faster update
set updatetime=100

" to remove bg from non-signed lines
highlight! link SignColumn LineNr

" command to fill and open location
let g:gitgutter_use_location_list = 0
command! Gqf GitGutterQuickFix | copen

nmap <space>hp <Plug>(GitGutterPreviewHunk)
nmap <space>hq :Gqf<cr>
