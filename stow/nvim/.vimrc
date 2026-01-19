set expandtab
set shiftwidth=2
set softtabstop=2

filetype plugin indent on

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

set number
set relativenumber

imap jk <Esc>

syntax on
highlight Comment cterm=italic

autocmd Filetype markdown set linebreak
autocmd Filetype markdown set breakindent
autocmd Filetype markdown let &showbreak = '↳ '
" autocmd Filetype markdown let &showbreak = '╰─>'

set conceallevel=2

let mapleader = " "
map <leader>t :NERDTreeToggle<CR>
nnoremap <leader>R :source $MYVIMRC<CR>

" show when leader key has been pressed
set showcmd
