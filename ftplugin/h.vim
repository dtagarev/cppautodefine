if exists("g:auto-define")
    finish
endif

command! -buffer DefineFunc call autodefine#DefineCurrFunction()

let g:auto-define = 'alright'
