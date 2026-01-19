" Simple markdown checkbox plugin
" Author: Rayhan
" Description: Clean and simple checkbox management for markdown files

" Create a new checkbox
function! CheckboxCreate() abort
  let line = getline('.')

  " Only add checkbox if it doesn't already exist
  if match(line, '- \[.\]') == -1
    " Add "- [ ] " at the beginning of the line
    call setline('.', '- [ ] ' . line)
  endif

  " Go to end of line and enter insert mode
  normal! $a
endfunction

" Mark checkbox as done
function! CheckboxMarkDone() abort
  let line = getline('.')

  " Replace [ ] or any checkbox state with [x]
  if match(line, '\[.\]') != -1
    let line = substitute(line, '\[\s*.\s*\]', '[x]', '')
    call setline('.', line)
  endif
endfunction

" Setup function to create mappings
function! s:SetupCheckboxMappings() abort
  nnoremap <buffer> <silent> <leader>c :call CheckboxCreate()<CR>
  nnoremap <buffer> <silent> <leader>x :call CheckboxMarkDone()<CR>
endfunction

" Set up keybindings for markdown files
augroup markdown_checkbox
  autocmd!
  autocmd FileType markdown call s:SetupCheckboxMappings()
augroup end

" vim:set ft=vim et sw=2 ts=2:
