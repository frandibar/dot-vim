" MY PERSONAL VIM SETTINGS FILE

" general settings
" This setting must go first because it changes other options as side effect
set nocompatible            " Make Vim behave in a more useful way instead of being Vi-compatible.
let mapleader = ","         " set <Leader> value for mappings

" files and backups
set autowrite               " Write the contents of the file, if it has been modified, when changing buffers.
set nobackup                " Don't make a backup before overwriting a file.
set noswapfile              " Don't use a swapfile for the buffer.  Don't use this for big files!
set autoread                " Automatically read files changed outside of vim
set hidden                  " Change buffer without saving

" user interface
set cursorline              " Highlight the screen line of the cursor.
set number                  " Print the line number in front of each line.
set listchars=tab:▸\ ,eol:$ " Modify tab char when set list
set nowrap                  " Don't wrap lines longer than the width of the window on the next line.
set scrolloff=2             " Minimal number of screen lines to keep above and below the cursor.
set showcmd                 " Show (partial) command in the last line of the screen.
set showmatch               " When a bracket is inserted, briefly jump to the matching one.

set wildmenu                " Possible matches are shown just above the command line
set wildmode=list:longest   " Complete longest common string, then list alternatives
set wildignore=*.o,*.obj,*.swp,*.bak,*.pyc,*.class  " A file that matches these patterns is ignored when completing file or directory names.
set shellslash              " Use a forward slash when expanding file names.

set mouse=a                 " Enable the use of the mouse for all modes (normal, visual, insert, command

" cursor behavior
set backspace=indent,eol,start  " Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set expandtab               " Use the appropriate number of spaces to insert a <Tab>
set shiftwidth=4            " Number of spaces to use for each step of (auto)indent.
set tabstop=4               " Number of spaces that a <Tab> in the file counts for. 
set softtabstop=4           " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>. 
set virtualedit=block       " Allow positioning cursor where no character exists in visual mode

" status line
set laststatus=2            " Always have status line for each window.
set statusline=%f%m%r%h%w\ %y\ %=[buf\ %n]\ %l,%c/%L\ %p%%   " information to show in status line
set ruler                   " Show the line and column number of the cursor position (commented out since this info was set in statusline)

" search behavior
set ignorecase              " Case is ignored for searches
set smartcase               " Override the ignorecase option if the search pattern contains upper case characters.
set hlsearch                " When there is a previous search pattern, highlight all its matches.
set incsearch               " While typing a search command, show where the pattern, as it was typed so far, matches. 
set nowrapscan              " Searches wrap around the end of the file.

" misc
set formatprg=par           " Use par as the external text formatting program
set makeprg=make\ %<        " Program to use for the :make command.
set tags=~/devel/src/**/tags,/usr/include/tags
set cindent                 " Enables automatic C program indenting.

" These lines must be called before enabling filetype detection
" Pathogen plugin
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on                 " Enable file type detection
filetype plugin on          " Enable filetype plugins.
filetype indent on
syntax enable               " Turn on syntax highlighting

" colors and fonts
set background=dark         " Vim will try to use colors that look good on a dark background.
colorscheme slate

" The following highlights must go after setting the colorscheme to avoid being overriden.
highlight LineNr ctermfg=darkgrey guifg=darkgrey 
highlight CursorLine ctermbg=darkblue term=bold cterm=bold guibg=Grey25
highlight CursorColumn ctermbg=darkblue term=bold cterm=bold guibg=Grey17
highlight NonText guibg=grey10
" override slate colorscheme for PreProc
highlight PreProc guibg=black   

" save ~/.vimrc file automatically when it's saved
autocmd! BufWritePost .vimrc nested source % 
autocmd! BufWritePost _vimrc nested source %  

" autocommands for file types
autocmd! Filetype html source ~/.vim/bundle/frandibar/source/html.vim

augroup python_filetype
    autocmd!
    " Set omni completion function for python files
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    " Set cursorcolumn for python and scheme files
    autocmd FileType python setlocal cursorcolumn
    autocmd FileType scheme setlocal cursorcolumn
augroup END

augroup tex_filetype
    autocmd! Filetype plaintex,tex source ~/.vim/bundle/frandibar/source/latex.vim
    " attention: pdflatex must be installed
    autocmd! Filetype tex setlocal makeprg=pdflatex\ %
augroup END

" disable comment autocomplete
augroup comment_autocomplete
    autocmd!
    autocmd FileType * setlocal formatoptions-=c
    autocmd FileType * setlocal formatoptions-=r
    autocmd FileType * setlocal formatoptions-=o
augroup END

" add lilypond syntax file
autocmd! BufReadPre *.ly,*.ily set runtimepath+=/usr/share/lilypond/2.12.3/vim/

" mappings
nnoremap <Leader>; ;
nnoremap ; :

" Better mapping for omni-completion
imap <c-space> <c-x><c-o>

" move 4 spaces to the right with tab
nmap <Tab> 4l
" move 4 spaces to the left with shift-tab
nmap <S-Tab> 4h

" When lines wrap, move to next wrapped line, although it's the same line.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" horizontal scroll mode with shift ctrl key
nmap <s-c-left> zh
nmap <s-c-right> zl
nmap <s-c-h> zh
nmap <s-c-l> zl

" vertical scroll mode with ctrl key
nmap <c-up> <c-y>
nmap <c-down> <c-e>
nmap <c-k> <c-y>
nmap <c-j> <c-e>

" smooth scrolling
nmap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
nmap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" mappings to keep the current visual block selection active after changing indentation
vmap > >gv
vmap < <gv

" mapping to remove highlight search
nmap <Leader>/ :nohlsearch<CR>

" see vimtip #159        
" for search and replace
nmap <F4> :%s//g<Left><Left>
" to replace word under cursor
nmap <S-F4> :%s/<C-r><C-w>//g<Left><Left>
" finds to the next occurence of the previously visually selected text.
vmap / y:execute "/".escape(@",'[]/\.*')<CR>
" replace selected text
vmap <F4> y:execute "%s/".escape(@",'[]/\')."//g"<Left><Left><Left>

" Use CTRL-S for saving, also in Insert mode
" (run 'stty -ixon' so it works from console)
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" Mapping to change directory to the file being edited
nmap <silent> <Leader>cd :cd %:p:h<CR>
" Mapping to add the current file path when openning a file
nmap <Leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

" Always add the current file's directory to the path if not already there
autocmd! BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path+=".s:tempPath

" Return the syntax highlighting group that the current "thing" under the
" cursor belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" toggle quick fix open/close
function! QFixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

nmap <silent> <Leader>x :call QFixToggle()<CR>

" cscope config
if has("cscope")
    set cscopeprg=/usr/bin/cscope
    set cscopetagorder=0      " use cscope db first, then tag files when calling :cstag
    set cscopetag             " use cscope for tag commands
    set nocscopeverbose
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
	set cscopequickfix=s-,c-,d-,i-,t-,e-
endif


" SECTION PLUGIN SPECIFIC

" Bufferlist plugin mappings
map <silent> <F3> :call BufferList()<CR>

" FuzzyFinder plugin mappings (fuf)
nnoremap <Leader>ff :FufFile<cr>
nnoremap <Leader>fb :FufBuffer<cr>
nnoremap <Leader>fr :FufMruFile<cr>
let g:fuf_modesDisable = [ 'mrucmd' ]   " enable mrufile, since the default value is ['mrufile', 'mrucmd']

" FSwitch plugin mappings
nmap <silent> <Leader>of :FSHere<CR>

" NERD_commenter plugin
let NERDShutUp=1    " Avoid warning for unknown filetypes


" Load settings specific to local machine
source ~/.vimrc-local

