if exists("did_load_filetypes")
    finish
endif

augroup filetype_detect
    autocmd!
    autocmd BufNewFile,BufRead *.ly,*.ily setfiletype lilypond
    autocmd BufNewFile,BufRead *.svg setfiletype svg 
    autocmd BufNewFile,BufRead *.rkt setfiletype scheme 
    autocmd BufNewFile,BufRead SConstruct setfiletype python 
    autocmd BufNewFile,BufRead SConscript setfiletype python 
augroup END

