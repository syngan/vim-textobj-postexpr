if exists('g:loaded_textobj_postexpr')
  finish
endif
let g:loaded_textobj_postexpr = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('postexpr', {
\      '-': {
\        'select-a': 'a,',
\       '*select-a-function*': 'textobj#postexpr#select_a',
\        'select-i': 'i,',
\      '*select-i-function*': 'textobj#postexpr#select_i',
\      },
\    })

let &cpo = s:save_cpo
unlet s:save_cpo
