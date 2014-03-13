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

function! s:get_val(key, defval) " {{{
  if exists('g:textobj_postexpr')
    if &filetype != '' && has_key(g:textobj_postexpr, &filetype) && has_key(g:textobj_postexpr[&filetype], a:key)
      return g:textobj_postexpr[&filetype][a:key]
    elseif has_key(g:textobj_postexpr, '-') && has_key(g:textobj_postexpr.filetype, a:key)
      return g:textobj_postexpr['-'][a:key]
    endif
  endif

  return a:defval
endfunction " }}}

function! s:iskeyword(s, pattern) " {{{
  return a:s =~ a:pattern
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
    return ["\n", l+1, 0, line, len(line)]
"    return [line[0], l+1, 1, line, len(line)]
  endif
endfunction " }}}

function! s:prev_pos(pos) " {{{
  let l = a:pos[1]
  let c = a:pos[2]
  let len = a:pos[4]

  if c - 2 >= 0
    return [a:pos[3][c-2], l, c-1, a:pos[3], len]
  elseif l == 1
    return ['', l, c-1, a:pos[3], len]
  else
    let line = getline(l-1)
    let len = len(line)
    return ["\n", l-1, len+1, line, len]
    " return [line[len-1], l-1, len, line, len]
  endif
endfunction " }}}

function! s:skip_space(pos, in) " {{{
  let p = a:pos
  if a:in
    while p[0] =~ '\s'
      let p = s:next_pos(p)
    endwhile
  else
    while p[0] =~ '\s' || p[0] =~ "\n"
      let p = s:next_pos(p)
    endwhile
  endif
  return p
endfunction " }}}

function! s:get_startpos(pos, keyword_pattern) " {{{
  let b = a:pos

  while 1
    let tpos = s:prev_pos(b)
    if !s:iskeyword(tpos[0], a:keyword_pattern)
      return b
    endif
    let b = tpos
  endwhile

endfunction " }}}

function! s:to_cursorpos(pos, base) " {{{
  return [a:base[0], a:pos[1], a:pos[2], a:base[3]]
endfunction " }}}

function! s:get_maxline(lnum) " {{{
  let m = get(b:, "textobj_postexpr_search_limit",
  \       get(g:, "textobj_postexpr_search_limit", 30))
  let m = a:lnum + m
  return min([m, line("$")])
endfunction " }}}

function! s:select(in) " {{{
  let spos = getpos(".")

  let line = getline(spos[1])
  let pos = [line[spos[2]-1], spos[1], spos[2], line, len(line)]

  let maxline = s:get_maxline(spos[1])

  let keyword_pattern = s:get_val('keyword_pattern', '\k')

  if !s:iskeyword(pos[0], keyword_pattern)
    return
  endif

  while 1
    if !s:iskeyword(pos[0], keyword_pattern)
      break
    endif
    let epos = pos
    let pos = s:next_pos(pos)
  endwhile

  let block = s:get_val('block', s:block)
  let pos = s:skip_space(pos, a:in)

  let stack = has_key(block, pos[0]) ? [pos[0]] : []
  while 1
    while len(stack) > 0
      let open = stack[-1]
      let close = block[open]

      while 1
        let pos = s:next_pos(pos)
        if pos[1] > maxline
          return
        endif
        let c = pos[0]
        if has_key(block, c)
          let stack = stack + [c]
          break
        elseif c == close
          call remove(stack, -1)
          let epos = pos
          break
        endif

      endwhile
    endwhile

    let pos = s:next_pos(pos)
    let pos = s:skip_space(pos, a:in)

    " hoge[a][b], " hoge[a](b)  みたいなの
    if has_key(block, pos[0])
      let stack += [pos[0]]
    else
      break
    endif
  endwhile

  let bpos = s:get_startpos([line[spos[2]-1], spos[1], spos[2], line, len(line)], keyword_pattern)
  let bpos = s:to_cursorpos(bpos, spos)
  let npos = s:to_cursorpos(epos, spos)

  return ['v', bpos, npos]
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker cms=\ "\ %s:
