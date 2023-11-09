

function! detect_os#get_os()
  return systemlist('uname')[0] " ['sysname']
endfunction

function! detect_os#check_linux()
  return detect_os#get_os() == 'Linux'
endfunction

function! detect_os#check_windows()
  return detect_os#get_os() == 'Windows_NT'
endfunction

function! detect_os#check_neither()
  return detect_os#get_os() != 'Windows_NT' && detect_os#get_os() != 'Linux' 
endfunction

let g:is_windows = detect_os#get_os() == 'Windows_NT'
let g:is_linux = detect_os#get_os() == 'Linux'
let g:is_phone = systemlist('uname')[0] == 'aarch64'
let g:is_neither = detect_os#get_os() != 'Windows_NT' && detect_os#get_os() != 'Linux'

echo("is windows: " + g:is_windows)
echo("is linux: " + g:is_linux)
echo("is phone: " + g:is_phone)
echo "is linux: " detect_os#check_linux()
