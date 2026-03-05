let mapleader = " "
let maplocalleader = " "

filetype plugin on
syntax on
set nocompatible

set showcmd
set smarttab
set nostartofline
set switchbuf=uselast
set wildmenu
set incsearch
set nowrap
set linebreak
set mouse=a
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus,unnamed,autoselect
set breakindent
set noexpandtab
set ignorecase
set smartcase
set signcolumn=yes
set updatetime=250
set ttimeoutlen=50
set splitright
set splitbelow
set title
set nolist
set nocursorline
set hlsearch
set completeopt=menuone,noinsert,noselect,preview
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set undodir=~/.vim/undodir
set undofile
set termguicolors
set norelativenumber
set nonumber
set laststatus=0

set guifont=Cascadia\ Code\ NF:h22:w-0.5

set bg=dark

set foldmethod=marker
set foldmarker=<<<,>>>

" autocmd InsertEnter * set norelativenumber | set conceallevel=0
" autocmd InsertLeave * set relativenumber   | set conceallevel=2

autocmd FileType c,cpp,objc,objcpp,python,js,json call rainbow#load()

nnoremap <Esc> :nohl<CR>
nnoremap <leader>e <cmd>Ex<CR>
tnoremap <leader>e <C-\><C-n>
nnoremap <expr> <silent> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <silent> j v:count == 0 ? 'gj' : 'j'

nnoremap <leader>t <cmd>FloatermToggle<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

" PLUGINS <<<
" curl -fLo .vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()

Plug 'https://github.com/frazrepo/vim-rainbow'
Plug 'https://github.com/mipmip/vim-scimark'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'christoomey/vim-tmux-navigator'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tpope/vim-sleuth' " Auto detect tabstop
Plug 'godlygeek/tabular' " Table formatting
" Plug 'preservim/vim-markdown' " Markdown
Plug 'vimwiki/vimwiki' 
Plug 'jiangmiao/auto-pairs' " bracket auto completion
Plug 'tpope/vim-commentary' " gcc to toggle comment
Plug 'tpope/vim-surround' " QOL
" Plug 'lilydjwg/colorizer' " display hex color code
Plug 'rrethy/vim-hexokinase'
Plug 'Yggdroot/indentLine' " Indent blankline
Plug 'cacharle/vim-syntax-extra' " Enhanced syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'girishji/vimsuggest'
Plug 'voldikss/vim-floaterm'

" Colorschemes <<<
Plug 'nikolvs/vim-sunbather'
Plug 'widatama/vim-phoenix'
Plug 'n1ghtmare/noirblaze-vim'
Plug 'davidosomething/vim-colors-meh'
Plug 'andreasvc/vim-256noir'
Plug 'rose-pine/vim', { 'as': 'rosepine' }
Plug 'Everblush/everblush.vim'
Plug 'morhetz/gruvbox'
Plug 'metalelf0/base16-black-metal-scheme'
Plug 'tomasiser/vim-code-dark'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'wuelnerdotexe/vim-enfocado'
" >>>

call plug#end()

" >>>

" COC CONFIG <<<

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

nmap <leader>cl  <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" set statusline=%{StatusDiagnostic()}

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>l  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" let g:coc_global_extensions = ['coc-clangd', 'coc-git', 'coc-tsserver', 'coc-phpls', 'coc-emmet', 'coc-flutter', 'coc-eslint', 'coc-tslint-plugin', 'coc-html']

" >>>

let g:indentLine_char = '│'
let g:indentLine_color_gui = "#2d2d2d"
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

let g:enfocado_style = 'neon' " Available: `nature` or `neon`.

colo noirblaze
" hi Normal guibg=NONE
" hi Comment guifg=#454545
" hi LineNr guifg=#343434

colo noirblaze
" hi Function guifg=#7daea3
" hi String guifg=#e06c75
" hi SpecialChar guifg=#7daea3
" hi CocInlayHint guifg=#454545
" hi Type guifg=#d3869b

" hi Folded guifg=NONE
hi Normal guibg=NONE
hi LineNr guifg=#2c303a
hi Comment guifg=#373d48
hi StatusLine guibg=NONE
hi Pmenu guibg=#282c34
" hi EndOfBuffer guifg=#232323

colo noirblaze
hi Comment guifg=#343434
hi Folded guibg=#232323
hi Folded guifg=#454545
hi Pmenu guibg=#1d1d1d
