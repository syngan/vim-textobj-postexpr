filetype plugin on
runtime! plugin/textobj/postexpr.vim

function! s:paste_code()
  put =[
  \    'foo tako(hoge)[',
  \    '% ] ahahahaha',
  \    '] hohohohoho',
  \    '% tako(hoge)[',
  \    '] ahahahaha',
  \    '% ] hohohohoho',
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
    setlocal filetype=tex
    syntax on
    call s:paste_code()
  end

  after
    close!
    unlet! g:textobj_postexpr
  end

  it 'default'
    normal! 1G0ft
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 4G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [5, 1]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 3]
  end

  it 'set -'
    let g:textobj_postexpr = {'-' : {'check_comment' : '1'}}
    normal! 1G0ft
    Expect &filetype == 'tex'
    Expect synIDattr(synIDtrans(synID(1, 1, 1)), 'name') !=? "Comment"
    Expect synIDattr(synIDtrans(synID(2, 2, 1)), 'name') ==? "Comment"
    Expect synIDattr(synIDtrans(synID(3, 1, 1)), 'name') !=? "Comment"
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 1]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
    normal! 4G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [6, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 3]
  end

end

" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker cms=\ "\ %s:
