" Custom quit command: hybrid of :quit and :bwipeout
function s:Quit()
    " If we're in the only window in the only tab in a buffer with no unsaved
    " changes, and the current buffer is a listed buffer, and there exist more
    " listed buffers out there, then use :bwipeout instead of :quit
    if tabpagenr('$') == 1 && winnr('$') == 1 && !&modified && len(getbufinfo({'buflisted': 1})) > 1
        bwipeout
    else
        quit
    endif
endfunction

command! -nargs=0 Quit :call s:Quit()
