if exists("g:auto-define")
    finish
endif

command! -buffer DefineFunc call auto-define#DefineCurrFunction()

let g:auto-define = 'alright'
