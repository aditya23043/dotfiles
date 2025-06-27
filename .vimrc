let mapleader = " "

" set rtp+=~/.vim/plugged/tokyonight.nvim
set rtp+=~/.vim/oil.vim

set showcmd smarttab nostartofline
set switchbuf=uselast wildmenu "wildoptions=pum,tagfile
filetype plugin on
set nocompatible
syntax on 

set number
set nowrap
set incsearch

set guifont=Cascadia\ Code\ NF

" NOTE: hmm
" set tabline=%t
set showtabline=1

set tabline=%!MyTabLine()

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s ..= '%' .. (i + 1) .. 'T'

        " the label is made by MyTabLabel()
        let s ..= ' %M %{MyTabLabel(' .. (i + 1) .. ')}  '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999X close '
    endif

    return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    " return bufname(buflist[winnr - 1])
    let fullpath = bufname(buflist[winnr - 1])
    return fnamemodify(fullpath, ':t') " ':t' gives just the filename
endfunction

set mouse=a

set noshowmode

set clipboard=unnamedplus

set breakindent

set tabstop=4
set shiftwidth=4
set noexpandtab

set ignorecase
set smartcase

set signcolumn=yes

set updatetime=250

" Decrease mapped sequence wait time
" Displays vim-which-key sooner
"set timeoutlen=1000
set ttimeoutlen=50

set splitright
set splitbelow

set title

set nolist
" set listchars=tab:»\ ,trail:·,nbsp:␣,lead:·
" set listchars=tab:│\ ,trail:·,nbsp:␣
" set listchars=tab:⇥\ ,trail:·,nbsp:␣,eol:⏎
set listchars=tab:⇥\ ,trail:·,nbsp:␣

set fillchars=vert:│,fold:─,foldopen:·

" folds
" set foldmethod=marker
" set foldmarker={,}

" Show which line your cursor is on
set cursorline

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10


" [[ Basic Keymaps ]]

" nnoremap : :<C-f>i

nnoremap <C-o> <cmd>CtrlPCurWD<CR>

inoremap <C-j> <Right>

set hlsearch
nnoremap <Esc> :nohlsearch<CR>

nnoremap <space>m <cmd>tabnext<CR>
nnoremap <space>n <cmd>tabprev<CR>
" nnoremap <space>e <cmd>NERDTreeToggle<CR>
nnoremap <leader>e <cmd>Ex<CR>
" nnoremap <S-j> <cmd>Ex<CR>

tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-w> <M-Backspace>
tnoremap <C-q> <C-\><C-n><C-w><C-w>

set dictionary+=~/.vim/dictionary/en_words.txt
set complete+=k

nnoremap <expr> <silent> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <silent> j v:count == 0 ? 'gj' : 'j'

nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

" [[ Install `vim-plug` plugin manager ]]
"    See https://github.com/junegunn/vim-plug/ for more info
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" autocmd VimEnter * Goyo

" [[ Install plugins ]]
"  To check the current status of your plugins, run
"    :PlugStatus
"
"  To update plugins you can run
"    :PlugUpdate
"
call plug#begin()

" Auto Pair
Plug 'jiangmiao/auto-pairs'

" nerd tree
" Plug 'preservim/nerdtree'

" Detect tabstop and shiftwidth automatically
Plug 'tpope/vim-sleuth'

" "gc" to comment visual regions/lines
Plug 'tpope/vim-commentary'

" for bracket auto completion
Plug 'tpope/vim-surround'

" Tmux nav
Plug 'christoomey/vim-tmux-navigator'

" Color codes
Plug 'lilydjwg/colorizer'

" openscad
Plug 'sirtaj/vim-openscad'

" ASCII DOC
Plug 'habamax/vim-asciidoctor'

" VIM WIKI
Plug 'vimwiki/vimwiki'

" ORG MODE
Plug 'jceb/vim-orgmode'

" Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'theniceboy/coc-flutter-tools'

" GIT
" Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Plug 'tpope/vim-vinegar'

" INDENT LINE
Plug 'Yggdroot/indentLine'

Plug 'https://github.com/wolandark/vim-live-server.git'

" Plug 'ayu-theme/ayu-vim'
" Plug 'tomasr/molokai'
Plug 'https://github.com/jasonccox/vim-wayland-clipboard.git'
Plug 'elkowar/yuck.vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', {'as': 'dracula'}
" Plug 'chriskempson/base16-vim'
Plug 'metalelf0/base16-black-metal-scheme'
Plug 'shime/vim-livedown'
Plug 'tomasiser/vim-code-dark'
" Plug 'relastle/bluewery.vim'
Plug 'sainnhe/everforest'
" Plug 'timmajani/tokyonightnoir-vim', {'as': 'tokyo'}
Plug 'bluz71/vim-moonfly-colors'
" Plug 'bluz71/vim-nightfly-colors'
Plug 'catppuccin/vim', {'as': 'catppuccin'}
" Plug 'ericbn/vim-solarized'
" Plug 'romgrk/doom-one.vim'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'rose-pine/vim', {'as': 'rosepine'}
Plug 'cocopon/iceberg.vim'
Plug 'nordtheme/vim', {'as': 'nord'}
" Plug 'rmehri01/onenord.nvim'
Plug 'nanotech/jellybeans.vim'
Plug 'ghifarit53/tokyonight-vim'
" Plug 'rakr/vim-one'
" Plug 'junegunn/seoul256.vim'
" Plug 'ayu-theme/ayu-vim'
" Plug 'Everblush/everblush.vim'
" Plug 'tomasiser/vim-code-dark'
" Plug 'vv9k/vim-github-dark'
" Plug 'overcache/NeoSolarized'
" Solarized
" Plug 'ericbn/vim-solarized'

" Adds git related signs to the gutter
" Plug 'airblade/vim-gitgutter'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ctrlpvim/ctrlp.vim'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
Plug 'honza/vim-snippets'

" Status bar (i dont think i need it but lets check it out cuz why not
" Plug 'itchyny/lightline.vim'

" Enhanced syntax highlighting
Plug 'cacharle/vim-syntax-extra'

" FOCUS
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

call plug#end()


" [[ Configure plugins ]]
set termguicolors
let g:tokyonight_style = 'night'  " available: night, storm
let g:tokyonight_enable_italic = 1
let g:gruvbox_italic=1

colorscheme zellner
set bg=light

function Something()
  syntax off
  colo zellner
  set laststatus=0
  set nonumber

  GitGutterBufferDisable

  hi Normal guibg=#ffffff
  hi Pmenu guibg=#ffffff
  hi CocPumDetail guifg=#000000
  hi CocPumShortcut guifg=#000000
  hi CocMenuSel guifg=#ffffff guibg=#000000
  hi CocInlayHint guifg=#2aa198
  hi Search guibg=#000000 guifg=#ffffff
  hi MatchParen guibg=#2aa198 guifg=#000000
  hi Visual guifg=#000000 guibg=#aaaaaa
  
endfunction

command Something call Something()



if g:colors_name == "gruvbox" && &background ==# 'dark'
    hi Comment guifg=#484848
    hi Whitespace guifg=#585858
    hi LineNr guifg=#383838
    hi SpecialKey guifg=#383838
    hi LimelightDim guifg=#484848
    hi TabLineFill guibg=#282828
    hi StatusLine guifg=#3c3836 guibg=#ddc7a1
    hi CursorLine guibg=#3c3836
    hi StatusLine guibg=#ddc7a1
    hi StatusLineNc guibg=#504b49
    " hi SignColumn guibg=#3c3836
    " hi SignColumn guibg=#282828
    hi CursorLineNr guifg=#ddc7a1 guibg=#3c3836
    hi CocInlayHint guibg=#333333 guifg=#585858
    hi SpecialKey guifg=#333333
    hi ErrorMsg ctermfg=256
    let g:limelight_conceal_guifg = '#484848'
elseif g:colors_name == "dracula" && &background ==# 'dark'
  hi Normal guibg=#16191f
  hi LineNr guifg=#2a303c
  hi clear CursorLineNr
  hi CursorLineNr guifg=#e8e6e3
  set cursorline
  set cursorlineopt=number
  hi Comment guifg=#3f485a
  hi StatusLine guibg=#2a303c
  hi SignColumn guibg=#2a303c
  hi DraculaYellow guifg=#f9ec8c
  hi DraculaYellowItalic guifg=#f9ec8c
  hi DraculaCyan guifg=#6ddbee
  hi DraculaCyanItalic guifg=#6ddbee
  hi DraculaMagenta guifg=#fc7cf4
  hi DraculaMagentaItalic guifg=#fc7cf4
  hi DraculaRed guifg=#ed3c83
  hi DraculaRedItalic guifg=#ed3c83
  hi DraculaGreen guifg=#4eff85
  hi DraculaGreenItalic guifg=#4eff85
  hi DraculaBlue guifg=#0d9fd9
  hi DraculaBlueItalic guifg=#0d9fd9
  hi DraculaFg guifg=#e8e6e3
  hi DraculaFgItalic guifg=#e8e6e3
elseif g:colors_name == "bluewery-light" && &background ==# 'dark'
    hi Comment guifg=#bfbaa6
    hi LineNr guifg=#bfbaa6
    set nocursorline
elseif g:colors_name == "wildcharm" && &background ==# 'dark'
    hi Comment guifg=#232323
    hi LineNr guifg=#232323
    hi WildMenu cterm=NONE guibg=#aaaaaa guifg=#000000
    hi StatusLine guibg=#232323 cterm=none guifg=#555555
    hi CocMenuSel guibg=#aaaaaa guifg=#000000
    hi Pmenu cterm=NONE guibg=#232323
    hi PmenuExtra cterm=NONE guibg=#232323
    hi CocPumDetail guifg=#454545
    hi CocPumShortcut guifg=#454545
    " hi CocInlayHint guifg=#bbbbbb guibg=#eeeeee
    set nocursorline
elseif g:colors_name == "NeoSolarized" && &background ==# 'dark'
    " hi Comment guifg=#dbd1bd
    " hi LineNr guifg=#ede8de guibg=#fdf6e3
    " hi SpecialKey guifg=#ede8de guibg=#fdf6e3

    hi Normal guibg=#fcf0cf
    hi LineNr guibg=#fcf0cf
    hi CursorLine guibg=#fcf0cf
    hi CursorLineNr guibg=#fcf0cf
    hi TabLineFill guibg=#fae8b7
    hi TabLineFill guibg=#fae8b7
    hi Comment guifg=#e6d8b3
    hi LineNr guifg=#e6d8b3
    hi SpecialKey guifg=#e6d8b3 guibg=#fcf0cf
    hi TabLineSel guibg=#586e75 guifg=#fcf0cf
    hi TabLine guifg=#fcf0cf guibg=#e6d8b3
elseif g:colors_name == "catppuccin_mocha" && &background ==# 'dark'
    hi EndOfBuffer guifg=#28283e
    hi Comment guifg=#47476c
    hi SpecialKey guifg=#28283e
    hi LineNr guifg=#47476c
    " hi LineNr guifg=#28283e
    hi CursorLine guibg=#14141f
    set nocursorline
elseif g:colors_name == "quiet" && &background ==# 'dark'
    hi Comment guifg=#343434
    hi LineNr guifg=#232323
    hi CursorLineNr guifg=#c7c7c7
    hi CursorLine guibg=#121212
    hi CursorLineNr guibg=#121212
    hi StatusLine guibg=#000000 guifg=#777777
    hi StatusLineNC guibg=#000000 guifg=#444444 cterm=NONE
    hi Whitespace guifg=#232323
    hi SpecialKey guifg=#121212
    hi Search guifg=#676767 guibg=#000000
    hi Visual guifg=#c7c7c7
    hi CocInlayHint guifg=#232323
    hi CocMenuSel guifg=#000000 guibg=#a8a8a8
    hi clear Wildmenu
    hi WildMenu guifg=#000000 guibg=#a8a8a8
    hi CocFloating guibg=#121212 guifg=#dadada
    hi EndOfBuffer guifg=#000000
elseif g:colors_name == "moonfly" && &background ==# 'dark'
    hi CocInlayHint guifg=#454545
    hi Comment guifg=#282828
    hi CocErrorVirtualText guifg=#ff5454
    hi WildMenu guibg=#e06c75 guifg=#000000
    hi StatusLine guibg=#181818 guifg=#868686
    hi NonText guifg=#282828
    hi SpecialKey guifg=#282828
    hi LineNr guifg=#181818
    hi CursorLineNr guifg=#c6c6c6
    hi CursorLine guibg=#1c1c1c
elseif g:colors_name == "onedark" && &background ==# 'dark'
    hi Comment guifg=#2c303a
    hi LineNr guifg=#1c202a
    " hi Normal guibg=#16181d
    hi Normal guibg=#141617
    hi CursorLine guibg=#16181d
    hi StatusLine guibg=#282c34 guifg=#abb2bf
    hi StatusLineNC guibg=#282c34 guifg=#4e5565
    hi Pmenu guibg=#2c303a
elseif g:colors_name == "iceberg" && &background ==# 'dark'
    hi Comment guifg=#33384d
    hi LineNr guifg=#1f212e guibg=#161821
    hi CocInlayHint guibg=#1f212e guifg=#33384d
    hi Pmenu guibg=#0a0b0f
    hi WildMenu guibg=#b4be82
    hi MatchParen guibg=NONE guifg=#e06c75
    hi SignColumn guibg=#161821
    hi CursorLine guibg=#1f212e
    hi CursorLineNr guibg=#0f1117
    " hi StatusLine guifg=#0f1117 guibg=#9a9ca5
    " hi StatusLineNC guibg=#303136
elseif g:colors_name == "ghdark" && &background ==# 'dark'
    hi Ignore guifg=#232323
    hi NonText guifg=#232323
    hi WildMenu guibg=#e06c75
    hi CocMenuSel guifg=#000000 guibg=#ecf2f8
    hi Normal guibg=#000000
    hi CursorLineNr guibg=#161b22
    hi Comment guifg=#242424
    hi LineNr guifg=#121212
    hi Pmenu guibg=#121212
    hi CursorLine guibg=#121212
    hi CursorLineNr guibg=#121212 guifg=#ecf2f8
    hi Search guifg=#000000 guibg=#f97970
    hi StatusLine guifg=#c6cdd5 guibg=#121212
    hi StatusLineNC guifg=#555555 guibg=#000000
    hi SignColumn guibg=#121212
    hi TabLine guibg=#232323 cterm=NONE guifg=#444444
    hi TabLineFill guifg=#232323
elseif g:colors_name == "tokyonight" && &background ==# 'dark'
    hi Comment guifg=#32344a
" hi TabLineSel guifg=#a9b1d6 guibg=#32344a
" hi TabLine guibg=#232433 guifg=#32344a
" hi LineNr guibg=#232433 guifg=#32344a
    hi LineNr guifg=#32344a
    hi CocInlayHint guibg=NONE guifg=#32344a
" hi CursorLine guibg=NONE
elseif g:colors_name == "rosepine" && &background ==# 'dark'
    hi Normal guibg=#000000
    hi Normal guibg=NONE
    hi CocMenuSel guifg=#000000 guibg=#ebbcba
" elseif g:colors_name == "rosepine" && g:bg == "light"
"   hi Comment guifg=#decdba
"   hi LineNr guifg=#e6d9cb
elseif g:colors_name == "habamax" && &background ==# 'dark'
    hi Comment guifg=#444444
    hi LineNr guifg=#343434
    " hi TabLineFill guibg=#1c1c1c
    " hi CocInlayHint guifg=#343434
    " hi CursorLine guibg=#1c1c1c
    " hi Pmenu guibg=#111111
elseif g:colors_name == "gruvbox-material" && &background ==# 'dark'
	set nocursorline
    hi CursorLine guibg=#181a1b
    hi Terminal guibg=NONE
    hi SpecialChar guifg=#7daea3
    hi EndOfBuffer guifg=#141617
    hi SpecialKey guifg=#282828
    hi NonText guifg=#282828
    hi Comment guifg=#383838
    hi LineNr guifg=#282828
    hi CursorLineNr guifg=#ddc7a1
    hi SpecialKey guifg=#282828
    hi NonText guifg=#282828
    hi LineNr guifg=#282828
    " hi Normal guibg=#141617
    hi Normal guibg=NONE
    hi TabLineSel guibg=#bcab8f guifg=#000000
    hi TabLine guibg=#282828 guifg=#555555
    " hi SignColumn guibg=#282828
    hi TabLineFill guibg=#282828 guifg=#444444
    hi StatusLine guibg=#282828 guifg=#585858
    hi StatusLineNC guibg=#141617 guifg=#817365
    hi CocCodeLens guibg=#141617 guifg=#484848
    hi Whitespace guibg=#141617 guifg=#484848
    hi CocErrorVirtualText guifg=#ea6962
    hi Pmenu guibg=#141617
" set cursorlineopt=number
elseif g:colors_name == "jellybeans"
    hi Comment guifg=#353535
    hi StatusLine guibg=#353535 guifg=#999999
    hi TabLineSel guibg=#353535 guifg=#999999
    hi TabLine guibg=#252525 guifg=#444444
    hi TabLineFill guibg=#252525 guifg=#444444
    hi LineNr guifg=#333333 guibg=#252525
    hi CursorLineNr guibg=#252525 guifg=#999999
    hi CocInlayHint guibg=#252525 guifg=#555555
    hi CocErrorSign guibg=#353535 guifg=#e06c75
    " hi CocCodeLens guibg=#252525 guifg=#555555
    hi CocCodeLens guibg=NONE guifg=#353535
    hi EndOfBuffer guibg=NONE guifg=#353535
    hi Search guifg=#e06c75
elseif g:colors_name == "nord"
    hi CocCodeLens guifg=#4b5468
    hi Comment guifg=#4b5468
    hi LineNr guifg=#404859
    hi Search guifg=#000000
elseif g:colors_name == "agila"
    hi CocErrorSign guifg=#ee6165
elseif g:colors_name == "zellner"
  hi Normal guibg=#ffffff
  hi Pmenu guibg=#ffffff
  hi CocPumDetail guifg=#000000
  hi CocPumShortcut guifg=#000000
elseif g:colors_name == "spacegray"
    hi LineNr guifg=#3d4142
    hi SignColumn guibg=#242627
    hi CursorLineNr guibg=#242627 guifg=#B3B8c4
endif



set completeopt=menuone,noinsert,noselect,preview


" COC Config
" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" nnoremap <C-w>. <cmd>tabNext<CR>
" nnoremap <C-w>, <cmd>tabprevious<CR>

inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ "\<Tab>"
" \ CheckBackspace() ? "\<Tab>" :
" \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <leader>k <Plug>(coc-diagnostic-prev)
nmap <leader>j <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f V$%zf

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>d  <Plug>(coc-codeaction-selected)
nmap <leader>d  <Plug>(coc-codeaction-selected)
nmap <leader><leader> v<Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline=\ %r\ %F\ %y%m\ %p%%%=%l/%L\ %{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
" nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
" nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item
" nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>

nnoremap <leader>a :call CocActionAsync('codeAction', 'selected')<CR>

let g:coc_global_extensions = ['coc-clangd', 'coc-git', 'coc-tsserver', 'coc-phpls', 'coc-emmet', 'coc-flutter', 'coc-eslint', 'coc-tslint-plugin']

let g:asciidoctor_folding = 0
let g:asciidoctor_fenced_languages = ['python', 'c', 'javascript', 'cpp']
let g:asciidoctor_img_paste_command = 'xclip -selection clipboard -t image/png -o > %s%s'


let g:indentLine_color_gui = "#e0ded8"
let g:indentLine_char = '│'

autocmd BufWritePost *.wiki silent :Vimwiki2HTML

set conceallevel=2

" vim: ts=2 sts=2 sw=2 et
