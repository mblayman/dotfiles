" Matt, recall that \v is a starting modifier to Vimscript to mean "very
" magic." Because, of course it is. :|
if !exists('g:test#lua#luatest#file_pattern')
  let g:test#lua#luatest#file_pattern = '\vtest_[^/]+\.lua$'
endif

let test#luatest#patterns = {
  \ 'test':      ['\vfunction\s+\w*\.?(\w+)\(\)'],
  \ 'namespace': [],
\}

function! test#lua#luatest#test_file(file) abort
  return a:file =~# g:test#lua#luatest#file_pattern
endfunction

function! test#lua#luatest#build_position(type, position) abort
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      return [a:position['file'].'::'.name]
    else
      return [a:position['file']]
    endif
  elseif a:type ==# 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#lua#luatest#build_args(args) abort
  return a:args
endfunction

function! test#lua#luatest#executable() abort
  return 'luatest'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#luatest#patterns)

  if !empty(name['test'])
    return name['test'][0]
  endif

  return ""
endfunction
