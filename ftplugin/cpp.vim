if exists("g:cppautodefine")
    finish
endif

command! DefineFunc call cppautodefine#DefineCurrFunction()
command! DefineAllFunc call cppautodefine#DefineAllFunctions()
command! MirrorFunc call cppautodefine#MirrorFunc()


let g:cppautodefine = 'alright'
