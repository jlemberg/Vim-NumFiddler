" NumFiddler - as inspired by Sublime Text 
"
" Author: Jannik Lemberg <j.lemberg@nullwerk.de>
" Source repository: https://github.com/jlemberg/NumFiddler

if exists('g:NumFiddler_loaded')
	finish
endif

let g:NumFiddler_loaded = 1

function! NumFiddler(offset)
    let cword=expand("<cWORD>")
    if empty(matchstr(cword, '^-\?\d\+$'))
        echo "'" . cword . "' is not a number, sillypants"
    else
        let nword=cword+a:offset
        let curpos=col('.')
        execute ':s/'.cword.'/'.nword.'/'
        call cursor(line('.'), curpos)
    endif
endfunction

map <silent> <C-Up> :call NumFiddler(1)<CR>
map <silent> <C-Down> :call NumFiddler(-1)<CR>

