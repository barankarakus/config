set noautochdir               " This just messes stuff up; turn it off
let g:rooter_manual_only = 0
let g:rooter_patterns = ['.git', '.ccls']
let g:rooter_targets = '/,*'
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_change_directory_for_project_files = 'current'
let g:rooter_silent_chdir = 1
