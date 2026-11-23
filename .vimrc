let mapleader = " "
let maplocalleader = " "

filetype plugin on
syntax on
set nocompatible

" gVim configs

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=e

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
set expandtab
set ignorecase
set smartcase
set signcolumn=yes
set updatetime=250
set ttimeoutlen=50
set splitright
set splitbelow
set title
set nolist
set cursorline
set hlsearch
set completeopt=menuone,noinsert,noselect,preview
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set undodir=~/.vim/undodir
set undofile
set termguicolors
set relativenumber
set number
set laststatus=0
" set foldcolumn=3

set textwidth=75
" set colorcolumn=+0
set formatoptions+=t

" set guifont=Cascadia\ Code\ NF:h22:w-0.5
set guifont=Maple\ Mono\ SemiBold:h30

set bg=dark

set foldmethod=marker
set foldmarker=<<<,>>>

" autocmd InsertEnter * set norelativenumber | set conceallevel=0
" autocmd InsertLeave * set relativenumber   | set conceallevel=2

" autocmd FileType c,cpp,objc,objcpp,python,js,json call rainbow#load()

nnoremap <Esc> :nohl<CR>
nnoremap <leader>e <cmd>Ex<CR>
" tnoremap <Esc><Esc> <C-\><C-n>
nnoremap <expr> <silent> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <silent> j v:count == 0 ? 'gj' : 'j'

nnoremap <leader>t <cmd>FloatermToggle<CR>
" tnoremap <C-w>t <cmd>FloatermToggle<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

nnoremap <C-p> <cmd>FZF<CR>
nnoremap <C-o> <cmd>Buffers<CR>

" PLUGINS <<<
" curl -fLo .vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()

Plug 'iamcco/markdown-preview.nvim'
Plug 'lervag/vimtex'
Plug 'kaarmu/typst.vim'
" Plug 'github/copilot.vim'
" Plug 'preservim/nerdtree'
Plug 'lanx-x/NeoSolarized'
Plug 'liuchengxu/space-vim-dark'
Plug 'mhartington/oceanic-next'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'preservim/tagbar'
Plug 'https://github.com/frazrepo/vim-rainbow'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'tpope/vim-sleuth' " Auto detect tabstop
Plug 'godlygeek/tabular' " Table formatting
Plug 'vimwiki/vimwiki' 
Plug 'jiangmiao/auto-pairs' " bracket auto completion
Plug 'tpope/vim-commentary' " gcc to toggle comment
Plug 'tpope/vim-surround' " QOL
Plug 'rrethy/vim-hexokinase'
Plug 'Yggdroot/indentLine' " Indent blankline
Plug 'cacharle/vim-syntax-extra' " Enhanced syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
" Plug 'girishji/vimsuggest'
Plug 'voldikss/vim-floaterm'

" Colorschemes <<<
Plug 'aditya23043/shadotheme'
Plug 'djjcast/mirodark'
Plug 'drsooch/gruber-darker-vim'
Plug 'm6vrm/gruber.vim'
Plug 'aditya23043/bark-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'lunacookies/vim-substrata'
Plug 'nikolvs/vim-sunbather'
Plug 'widatama/vim-phoenix'
Plug 'n1ghtmare/noirblaze-vim'
Plug 'davidosomething/vim-colors-meh'
Plug 'rose-pine/vim', { 'as': 'rosepine' }
Plug 'Everblush/everblush.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
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

let g:typst_pdf_viewer = 'zathura'

let g:indentLine_char = '│'
let g:indentLine_color_gui = "#33333b"
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
let g:livepreview_previewer = 'mupdf'
let g:vimtex_view_method = 'mupdf'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {
      \ 'continuous' : 1,
      \}

let g:enfocado_style = 'neon' " Available: `nature` or `neon`.
let g:space_vim_dark_background = 233

let g:copilot_enabled = v:false


" STATUS LINE<<<
" set laststatus=2    " always show the statusline
" set showmode        " show mode line ---INSERT---
" " initialise to blank
" set statusline=
" " space, buffer number surrounded by [square braces]
" set statusline+=\ [%n]
" " space, filename (tail)
" set statusline+=\ %t
" " space, flags: modified, readonly, help, preview
" set statusline+=\ %m%r%h%w
" " right align
" set statusline+=%=
" " file format (line endings)
" set statusline+=%{&ff}
" " space, pipe, space, file encoding
" set statusline+=\ \|\ %{''.(&fenc!=''?&fenc:&enc).''}
" " space, pipe, space, filetype or "none"
" set statusline+=\ \|\ %{&filetype!=#''?&filetype.'':'none'}
" " space, pipe, space, min-2-width percent through file in lines
" set statusline+=\ \|\ %2p%%
" " space, pipe, space, min-3-width line number
" set statusline+=\ \|\ %3l
" " comma, min-2-character left-aligned virtual column number, space
" set statusline+=:%-2v\ "
" ------>>>

colo shado
hi Normal guibg=NONE
hi Comment guifg=#484c54
hi LineNr guifg=#282c34
hi Pmenu guibg=#282c34
hi Folded guifg=#282c34
colo shado
hi Pmenu guibg=#21212d

" source ~/term.vim

colo shado
hi Normal guibg=NONE

" Gruvbox
" hi Normal guibg=NONE
" hi Comment guifg=#363636
" hi LineNr guifg=#363636

" Quiet
" hi Normal guifg=#ded7b3 guibg=#000000 guisp=NONE gui=NONE ctermfg=253 ctermbg=16 cterm=NONE term=NONE
" hi Constant guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi CursorLineNr guifg=#ded7b3 guibg=#303030 guisp=NONE gui=NONE ctermfg=253 ctermbg=236 cterm=NONE term=bold
" hi Directory guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi ErrorMsg guifg=#ded7b3 guibg=#000000 guisp=NONE gui=reverse ctermfg=253 ctermbg=16 cterm=reverse term=bold,reverse
" hi Identifier guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi Ignore guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi ModeMsg guifg=#ded7b3 guibg=NONE guisp=NONE gui=bold ctermfg=253 ctermbg=NONE cterm=bold term=bold
" hi MoreMsg guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi PmenuExtraSel guifg=#000000 guibg=#ded7b3 guisp=NONE gui=NONE ctermfg=16 ctermbg=253 cterm=NONE term=NONE
" hi PmenuKindSel guifg=#000000 guibg=#ded7b3 guisp=NONE gui=bold ctermfg=16 ctermbg=253 cterm=bold term=bold
" hi PmenuMatchSel guifg=#d7005f guibg=#ded7b3 guisp=NONE gui=bold ctermfg=161 ctermbg=253 cterm=bold term=bold
" hi PmenuSel guifg=#000000 guibg=#ded7b3 guisp=NONE gui=NONE ctermfg=16 ctermbg=253 cterm=NONE term=bold
" hi PmenuThumb guifg=#ded7b3 guibg=#ded7b3 guisp=NONE gui=NONE ctermfg=253 ctermbg=253 cterm=NONE term=NONE
" hi PreProc guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi Question guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=standout
" hi SignColumn guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=reverse
" hi Special guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi Statement guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi StatusLine guifg=#000000 guibg=#ded7b3 guisp=NONE gui=bold ctermfg=16 ctermbg=253 cterm=bold term=bold,reverse
" hi TabLineFill guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi TabLineSel guifg=#000000 guibg=#ded7b3 guisp=NONE gui=bold ctermfg=16 ctermbg=253 cterm=bold term=bold,reverse
" hi TitleBar guifg=#ded7b3 guibg=#4c4c4c guisp=NONE gui=NONE ctermfg=253 ctermbg=237 cterm=NONE term=NONE
" hi ToolbarButton guifg=#ded7b3 guibg=#000000 guisp=NONE gui=bold ctermfg=253 ctermbg=16 cterm=bold term=bold,reverse
" hi Type guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=NONE
" hi Underlined guifg=#ded7b3 guibg=NONE guisp=NONE gui=underline ctermfg=253 ctermbg=NONE cterm=underline term=underline
" hi WarningMsg guifg=#ded7b3 guibg=NONE guisp=NONE gui=NONE ctermfg=253 ctermbg=NONE cterm=NONE term=standout
" hi Comment guifg=#ded7b3
