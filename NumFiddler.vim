" NumFiddler - as inspired by Sublime Text 
"
" Author: Jannik Lemberg <j.lemberg@nullwerk.de>
" Source repository: https://github.com/jlemberg/NumFiddler

" Basic script init
if exists('g:NumFiddler_loaded')
	finish
endif

let g:NumFiddler_loaded = 1

function! NumFiddler(offset)
    " Get the current word
    let cword=expand("<cWORD>")
    " Check if it's an integer
    if !empty(matchstr(cword, '^-\?\d\+$'))
        " Check if the cursor's at the beginning of the word
        if(!empty(matchstr(getline('.')[col('.')-2], '\w')))
            exe "normal b"
        endif
        let curpos=col('.')
        let nword=cword+a:offset
        let startpos=curpos-1
        " Inc/Dec number and replace
        let endpos=curpos+strlen(cword)+1 
        execute ':s/\%>'.startpos.'c'.cword.'\%<'.endpos.'c/'.nword.'/'
        " Reset cursor position
        call cursor(line('.'), curpos)
    endif
endfunction

" Key mappings
map <silent> <C-Up> :call NumFiddler(1)<CR>
map <silent> <C-Down> :call NumFiddler(-1)<CR>

