" NumFiddler - as inspired by Sublime Text 
"
" Author: Jannik Lemberg <j.lemberg@nullwerk.de>
" Source repository: https://github.com/jlemberg/Vim-NumFiddler



" Basic script init
if exists('g:NumFiddler_loaded')
	finish
endif

let g:NumFiddler_loaded = 1



function! NumFiddler(offset)
    " Get the current word
    let cword=expand("<cWORD>")
    " Check if it's a number
    if !empty(matchstr(cword, '^-\?\d\+\.\?\(\d\+\)\?[fF]\?$'))
        " Check if the cursor's at the beginning of the word
        if(!empty(matchstr(getline('.')[col('.')-2], '[0-9\.-]')))
            exe "normal B"
        endif
        let offset=a:offset
        if(offset == -2 || offset == 2)
            if(match(cword, '\.') == -1)
                let offset=(offset == -2)?-1:1
            else
                let afterdot=split(cword, '\.')[1]
                let pos=match(afterdot, '\d[fF]\?$')
                let num=(offset==-2)?'-':''
                let num.='0.'
                for i in range(pos)
                    let num.='0'
                endfor
                let num.='1'
                let offset=str2float(num)
            endif
        endif
        let curpos=col('.')
        let startpos=curpos-1
        " Inc/Dec number and replace
        let endpos=curpos+strlen(cword)+1 
        let postfix=matchstr(cword, '[fF]')
        let cmd=':s/\%%>%dc%s\%%<%dc/'
        " Determine if either the current word or the offset is a float
        if !empty(matchstr(cword, '\.')) || type(offset) == 5 
            let cmd.='%g'
            let nword=str2float(cword)+offset
        else
            let cmd.='%d'
            let nword=cword+offset
        endif
        let cmd.=postfix.'/'
        
        execute printf(cmd, startpos, cword, endpos, nword)

        " Reset cursor position
        call cursor(line('.'), curpos)
    endif
endfunction



" Key mappings
map <silent> <C-Up> :call NumFiddler(1)<CR>
map <silent> <C-Down> :call NumFiddler(-1)<CR>

if has('float')
    map <silent> <A-Up> :call NumFiddler(0.1)<CR>
    map <silent> <A-Down> :call NumFiddler(-0.1)<CR>
    map <silent> <S-Up> :call NumFiddler(2)<CR>
    map <silent> <S-Down> :call NumFiddler(-2)<CR>
endif

