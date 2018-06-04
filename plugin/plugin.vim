function! GoRgFile()
    let l:filename = expand('<cfile>')
    let l:extension = expand('<cfile>:e')

    if l:extension =~ '^\s*$'
        let l:filename = l:filename . ".js"
    endif

    let l:command = "rg --files -g \'*" . l:filename . "*\'"
    echom l:command
    let l:stdout = system(l:command)
    let l:files = split(stdout, "\n")

    if len(l:files) == 0
        echoe "Can't find file for \'" . expand('<cfile>') . "\'"
        return
    elseif len(l:files) != 1
        echoe "Found " . len(l:files) . " files: " . join(l:files, ", ")
        return
    endif

    execute "e " . l:files[0]
endfunction

function! InitRgGoFile()
    nnoremap <buffer> <leader>gf :call GoRgFile()<cr>
endfunction

augroup go_rg_file_group
    autocmd!
    autocmd FileType javascript call InitRgGoFile()
    autocmd FileType less call InitRgGoFile()
augroup END
