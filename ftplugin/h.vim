if exists("g:cppsnippets")
    finish
endif

command! -buffer DefineFunc call DefineCurrFunction()

let g:cppsnippets = 'alright'
