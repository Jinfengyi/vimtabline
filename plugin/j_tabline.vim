hi TabLineFill ctermfg=24 ctermbg=DarkBlue
hi TabLine term=reverse cterm=NONE  ctermfg=Black ctermbg=LightBlue
hi TabLineSel term=reverse ctermbg=0 guisp=#7070F0

hi TabLineaArr term=bold ctermbg=24 ctermfg=LightBlue guibg=#13354A
hi TabLineaArrSel term=bold ctermbg=24 ctermfg=0 guibg=#13354A

hi TabLinebArr term=bold ctermbg=LightBlue ctermfg=24 guibg=#13354A
hi TabLinebArrSel term=bold ctermbg=0 ctermfg=24 guibg=#13354A

function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:my_tabline()
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ''
        let title = fnamemodify(bufname(bufnr), ':t')
        let s .= '%'.i.'T'
        let tbarrowa = '%#'. (i == tabpagenr() ? 'TabLineaArrSel#' : 'TabLineaArr#')
        let tbarrowb = '%#'. (i == tabpagenr() ? 'TabLinebArrSel#' : 'TabLinebArr#')
        let s .= tbarrowb.'%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#' .'['.no.']'. title .mod. tbarrowa
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    let s = '  '.s
    return s
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

