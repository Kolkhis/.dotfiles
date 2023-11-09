
function! kolkhis#ToggleCase()
  let l:cword = expand('<cword>')
  let l:lcase = l:cword =~# '%l*'
  let l:ucase = l:cword =~# '%u*'

  if l:lcase 
    if l:lcase == l:cword
      execute "normal! viwUei"
    endif
  endif

  if l:ucase
    execute "normal! viwuei" 
  endif
endfunction
