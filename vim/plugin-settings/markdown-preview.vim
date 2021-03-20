if g:mkdp_loaded
    " Don't automatically open the preview window when a markdown file is
    " entered
    let g:mkdp_auto_start = 0
    " Don't autoclose the preview window when switching away from a markdown
    " buffer
    let g:mkdp_auto_close = 0
    " Continuously refresh the preview window as we edit; set to 1 to only
    " refresh upon writing the buffer
    let g:mkdp_refresh_slow = 0
    " Only make the mkdp commands (like :MarkdownPreview) available for
    " markdown files
    let g:mkdp_command_for_global = 0
endif
