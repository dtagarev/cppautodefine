if exists("g:cppautodefine")
    finish
endif

command! -buffer DefineFunc call cppautodefine#DefineCurrFunction()
command! -buffer DefineAllFunc call cppautodefine#DefineAllFunctions()
command! -buffer Test call cppautodefine#Test()


" let s:fileName = expandcmd('%:t')

" if match(s:fileName, '.h') || match(s:fileName, '.hpp')
" 	augroup FindFunction
" 	  autocmd!
" 	  " autocmd BufReadPost * call cppautodefine#FindAllFunctionsCpp(substitute(fileName)()
" 	  autocmd BufEnter *.h call cppautodefine#FindAllFunctionsCpp(substitute(s:fileName)()
" 	augroup END
" endif

let g:cppautodefine = 'alright'
