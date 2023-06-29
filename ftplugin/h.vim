if exists("g:cppautodefine")
    finish
endif

command! -buffer DefineFunc call cppautodefine#DefineCurrFunction()
" command! -buffer Test call cppautodefine#WriteMessage()

let g:cppautodefine = 'alright'
