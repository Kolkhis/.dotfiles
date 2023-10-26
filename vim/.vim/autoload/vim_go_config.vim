function! vim_go_config#SetVimGoOptions()
    " vim-go basic functionality
    let g:go_fmt_autosave = 1
    let g:go_gopls_enabled = 1
    let g:go_doc_popup_window = 1

    " highlights
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_diagnostic_errors = 1
    let g:go_highlight_diagnostic_watnings = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_variable_declarations = 1

    let g:go_highlight_extra_types = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1

    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_format_strings = 1
endfunction
