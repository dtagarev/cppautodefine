if exists("g:autodefine")
    finish
endif

command! -buffer DefineFunc call autodefine#DefineCurrFunction()
command! -buffer Test call autodefine#WriteMessage()

let g:autodefine = 'alright'
