
"Useful
"]] goes to start of the function the cursor is in

:color torte

" Highlight all instances of word under cursor, when idle.
" when studying strange source code.
" Type z/ to toggle highlighting on/off.
"nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = '#'
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=50
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

set hlsearch
set nocompatible
syntax on
set hlsearch
hi Search ctermbg=Yellow
hi Search ctermfg=black
filetype plugin indent on

"Highlight current line
:hi CursorLine   cterm=NONE ctermbg=blue ctermfg=white
:nnoremap <Leader>a :set cursorline!<CR>
:set cursorline 

:set tabstop=4
:set shiftwidth=4
:set expandtab
:set tags=/home/osvDev/repos/tags
:cs add /home/osvDev/repos/cscope.out
:noremap <C-]> g<C-]>
:set csre
" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "

    " Hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result is displayed in the current window.
    " Use CTRL-T to go back  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  



endif



"jump to definition of local variable under cursor:gd
"junp to definition of global variable under cursor:gD

function! GotoDefinition()
      let n = search("\\<".expand("<cword>")."\\>[^(]*([^)]*)\\s*\\n*\\s*{")
  endfunction
  map <F4> :call GotoDefinition()<CR>
  imap <F4> <c-o>:call GotoDefinition()<CR:call AutoHighlightToggle()<cr>

:silent call AutoHighlightToggle()


"Changing autocomplete colors
"menu colors
highlight Pmenu ctermfg=black ctermbg=grey
"Selected item colors
highlight PmenuSel ctermfg=white ctermbg=blue

"Highlight trailing space
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+\%#\@<!$/
