function! ale_config#SetAleOptions()
    " ALE
    let g:ale_completion_enabled = 1  
    let g:ale_sign_info = "⑆" " ┉ 〇 ☼
    let g:ale_sign_error = "よ" " ♢ 〄
    let g:ale_sign_warning = "☺" " ω ∆  ⑇ ⑈ ⑉ 
    let g:ale_detail_to_floating_preview = 1
    let g:ale_completion_enabled = 1
    let g:ale_floating_preview = 1

    " Go
    let g:ale_go_langserver_executable = '/usr/bin/gopls'

    " Python
    let g:ale_python_pyright_executable = "pyright-langserver"
    let g:ale_python_auto_pipenv = 1
    let g:ale_python_auto_virtualenv = 1

    let g:ale_linters = {
                \ 'go': ['gopls', 'gometalinter', 'gofmt', 'gobuild'], 
                \ 'python': ['pyright']
                \ }
    let g:ale_fixers = {
                \ 'go': ['gopls'], 
                \ 'python3': ['pyright']
                \ }
endfunction
