let s:save_cpo = &cpo
set cpo&vim

scriptencoding utf-8

let s:block = {
  \ '(' : ')',
  \ '[' : ']',
  \}

function! textobj#postexpr#select_a() " {{{
  return s:select(0)
endfunction " }}}

function! textobj#postexpr#select_i() " {{{
  return s:select(1)
endfunction " }}}

function! s:iskeyword(s) " {{{
  return a:s =~ '\k'
endfunction " }}}

function! s:next_pos(pos) " {{{
" pos = [char, lnum, col, line, len]
  let l = a:pos[1]
  let c = a:pos[2]
  let len = a:pos[4]

  if c < len
    return [a:pos[3][c], l, c+1, a:pos[3], len]
  else
    let line = getline(l+1)
    return [line[0], l+1, 1, line, len(line)]
  endif
endfunction " }}}

function! s:prev_pos(pos) " {{{
  let l = a:pos[1]
  let c = a:pos[2]
  let len = a:pos[4]

  if c - 2 >= 0
    return [a:pos[3][c-2], l, c-1, a:pos[3], len]
  else
    let line = getline(l-1)
    let len = len(line)
    return [line[len-1], l-1, len, line, len]
  endif
endfunction " }}}

function! s:skip_space(pos, in) " {{{
  let p = a:pos
  if a:in
    while p[0] =~ '\s'
      let p = s:next_pos(p)
    endwhile
  else
    while p[0] =~ '\s' || p[0] =~ '\n' || p[0] =~ '\r'
      let p = s:next_pos(p)
    endwhile
  endif
  return p
endfunction " }}}

function! s:get_startpos(pos) " {{{
  let b = a:pos
  while 1
    let tpos = s:prev_pos(b)
    if !s:iskeyword(tpos[0])
      break
    endif
    let b = tpos
  endwhile

  return b
endfunction " }}}

" postexpr := name
"           | name '[' any ']'
"           | name '(' any ')'
function! s:select(in) " {{{
  let spos = getpos(".")

  let line = getline(spos[1])
  let pos = [line[spos[2]-1], spos[1], spos[2], line, len(line)]

  if !s:iskeyword(pos[0])
    return
  endif

  while 1
    if !s:iskeyword(pos[0])
      break
    endif
    let pos = s:next_pos(pos)
  endwhile

  let pos = s:skip_space(pos, a:in)

  let stack = has_key(s:block, pos[0]) ? [pos[0]] : []
  while 1
    while len(stack) > 0
      let open = stack[-1]
      let close = s:block[open]

      while 1
        let pos = s:next_pos(pos)
        let c = pos[0]
        if has_key(s:block, c)
          let stack = stack + [c]
          break
        elseif c == close
          call remove(stack, -1)
          break
        endif
      endwhile
    endwhile

    let epos = pos

    let pos = s:next_pos(pos)
    let pos = s:skip_space(pos, a:in)
    if pos[0] == '['
      " hoge[a][b] みたいなの
      let stack += [pos[0]]
    elseif pos[0] == '('
      " hoge[a](b)  みたいなの
      let stack += [pos[0]]
    else
      break
    endif
  endwhile

  let bpos = s:get_startpos([line[spos[2]-1], spos[1], spos[2], line, len(line)])
  let bpos = [spos[0], bpos[1], bpos[2], spos[3]]
  let npos = [spos[0], epos[1], epos[2], spos[3]]

  return ['v', bpos, npos]
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker cms=\ "\ %s:
