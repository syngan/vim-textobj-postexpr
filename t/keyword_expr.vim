filetype plugin on
runtime! plugin/textobj/postexpr.vim

" tako  ()
" hoge[aa[bb](1, 2, 3)]()
" (1)foo
" koko ha tada no word
function! s:paste_code()
  put =[
  \    'foo \tako(hoge[])[] hehehe',
  \ ]
  1 delete _
endfunction

describe '<Plug>(textobj-posrexpr-i)'
  before
    new
    omap av <Plug>(textobj-postexpr-a)
    omap iv <Plug>(textobj-postexpr-i)
    vmap av <Plug>(textobj-postexpr-a)
    vmap iv <Plug>(textobj-postexpr-i)
    call s:paste_code()
  end

  after
    close!
    unlet! g:textobj_postexpr
  end

  it 'default'
    normal! 1G0
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G01l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G02l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 4]
    normal! 1G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 5]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G05l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 6]
    normal! 1G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 6]
  end

  it 'set -'
    let g:textobj_postexpr = {'-' : {'keyword_expr' : '\\\k\+'}}
    normal! 1G0
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 1]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G01l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 2]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 2]
    normal! 1G02l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 3]
    normal! 1G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 4]
    normal! 1G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G05l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
  end


  it 'set &filetype'
    let g:textobj_postexpr = {'hoge' : {'keyword_expr' : '\\\k\+'}}
    setlocal filetype=hoge
    normal! 1G0
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 1]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G01l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 2]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 2]
    normal! 1G02l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 3]
    normal! 1G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 4]
    normal! 1G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G05l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
  end

  it '1: set &filetype with -'
    let g:textobj_postexpr = {
          \ 'hoge' : {'keyword_expr' : '\\\k\+'},
          \ '-' : {'keyword_expr' : '\k\+'}}
    setlocal filetype=hoge
    normal! 1G0
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 1]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G01l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 2]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 2]
    normal! 1G02l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 3]
    normal! 1G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 4]
    normal! 1G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G05l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
  end

  it '2: set &filetype with -'
    let g:textobj_postexpr = {
          \ 'hoge' : {'keyword_expr' : '\\\k\+'},
          \ '-' : {'keyword_expr' : '\k\+'}}
    setlocal filetype=tako
    normal! 1G0
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G01l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G02l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 1G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 4]
    normal! 1G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 5]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 1G05l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 6]
    normal! 1G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 19]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 6]
  end

end

" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker cms=\ "\ %s:
