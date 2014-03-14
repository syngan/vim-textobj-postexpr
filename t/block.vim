filetype plugin on
runtime! plugin/textobj/postexpr.vim

" tako  ()
" hoge[aa[bb](1, 2, 3)]()
" (1)foo
" koko ha tada no word
function! s:paste_code()
  put =[
  \    'tako(hoge[])[]',
  \    'tako[hoge()]<>',
  \    'tako<hoge()>()',
  \    'hoge[aa[bb](1, 2, 3)]()',
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
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 14]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 12]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
    normal! 3G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [3, 1]
  end

  it 'set -'
    let g:textobj_postexpr = {'-' : {'block' : {'(' : ')'}}}
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 12]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
    normal! 3G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [3, 1]
  end


  it 'set &filetype'
    let g:textobj_postexpr = {'hoge' : {'block' : {'<' : '>'}}}
    setlocal filetype=hoge
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
    normal! 3G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 12]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [3, 1]
  end

  it '1: set &filetype with -'
    let g:textobj_postexpr = {'hoge' : {'block' : {'<' : '>'}},
          \ '-' : {'block' : {'(' : ')'}}}
    setlocal filetype=hoge
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
    normal! 3G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 12]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [3, 1]
  end

  it '2: set &filetype with -'
    let g:textobj_postexpr = {'hoge' : {'block' : {'<' : '>'}},
          \ '-' : {'block' : {'(' : ')'}}}
    setlocal filetype=tako
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 12]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
    normal! 3G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [3, 1]
  end

end

" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker cms=\ "\ %s:
