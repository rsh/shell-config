" MIT License
"
" Copyright (c) 2022 Gerard
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

" from https://github.com/gerardbm/vim-md-checkbox/

if !exists('g:checkbox_maps')
  let g:checkbox_maps = 1
endif

if !exists('g:values')
  let g:values = [' ', 'x']
endif

if !exists('g:insert')
  let g:insert = '\<'
endif

if !exists('g:prefix')
  let g:prefix = '- '
endif

if !exists('g:suffix')
  let g:suffix = ' '
endif

function! s:ChangeCheckbox() abort
  let line = getline('.')

  if(match(line, '\[.\]') != -1)
    let states = copy(g:values)
    call add(states, g:values[0])
    for state in states
      if(match(line, '\[' . state . '\]') != -1)
        let next_state = states[index(states, state) + 1]
        let line = substitute(
              \ line,
              \ '\[' . state . '\]',
              \ '[' . next_state . ']',
              \ '')
        break
      endif
    endfor
  else
    if g:insert !=# ''
      let line = substitute(
            \ line,
            \ g:insert,
            \ g:prefix . '[' . g:values[0] . ']' . g:suffix,
            \ '')
    endif
  endif

  call setline('.', line)
endf

function! s:DeleteCheckbox() abort
  let line = getline('.')

  if(match(line, '\[.\]') != -1)
    let states = copy(g:values)
    call add(states, g:values[0])
    for state in states
      let line = substitute(
            \ line,
            \ g:prefix . '\['. state . '\]' . g:suffix,
            \ '',
            \ '')
    endfor
  endif

  call setline('.', line)
endfunction

if g:checkbox_maps == 1
  augroup markdown
    autocmd FileType markdown
          \ nnoremap <silent> <leader>d :call <SID>ChangeCheckbox()<CR>
    autocmd FileType markdown
          \ nnoremap <silent> <leader>r :call <SID>DeleteCheckbox()<CR>
  augroup end
endif

" vim:set ft=vim sts=2 et:
