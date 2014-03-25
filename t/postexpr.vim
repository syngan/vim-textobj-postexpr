filetype plugin on
runtime! plugin/textobj/postexpr.vim

" tako  ()
" hoge[aa[bb](1, 2, 3)]()
" (1)foo
" koko ha tada no word
function! s:paste_code()
  put =[
  \    'tako  ()',
  \    'hoge[aa[bb](1, 2, 3)]()',
  \    '(1)foo',
  \    'koko ha tada no word',
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
  end

  it 'remove only tako()'
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 8]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
  end

  it 'remove only tako()'
    normal! 1G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 8]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
  end

  it 'remove only tako()'
    normal! 1G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 5]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
  end

  it 'remove only hoge line'
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 23]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
  end

  it 'remove only hoge line'
    normal! 2G0ll
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 23]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
  end

  it 'remove only hoge line'
    normal! 2G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 20]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 6]
  end

  it 'remove only koko 0'
    normal! 4G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only koko 1'
    normal! 4G0l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only koko 2'
    normal! 4G2l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only koko 3'
    normal! 4G3l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only empty'
    normal! 4G4l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 5]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 5]
  end

  it 'remove only ha'
    normal! 4G5l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 7]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 6]
  end

  it 'remove only ha'
    normal! 4G6l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 7]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 6]
  end
end


describe '<Plug>(textobj-posrexpr-a)'
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
  end

  it 'remove only tako()'
    normal! 1G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 8]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
  end

  it 'remove only tako()'
    normal! 1G3l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 8]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 1]
  end

  it 'remove only tako()'
    normal! 1G4l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [1, 5]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [1, 5]
  end

  it 'remove only hoge line'
    normal! 2G
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
  end

  it 'remove only hoge line'
    normal! 2G0ll
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [3, 3]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 1]
  end

  it 'remove only hoge line'
    normal! 2G6l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [2, 20]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [2, 6]
  end

  it 'remove only koko 0'
    normal! 4G0
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only koko 1'
    normal! 4G01l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only koko 2'
    normal! 4G02l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only koko 3'
    normal! 4G03l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 4]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 1]
  end

  it 'remove only empty'
    normal! 4G04l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 5]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 5]
  end

  it 'remove only ha'
    normal! 4G05l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 7]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 6]
  end

  it 'remove only ha'
    normal! 4G06l
    execute 'normal' "viv\<Esc>"
    execute 'normal!' "`>"
    Expect getpos('.')[1 : 2] == [4, 7]
    execute 'normal!' "`<"
    Expect getpos('.')[1 : 2] == [4, 6]
  end
end

" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker cms=\ "\ %s:
