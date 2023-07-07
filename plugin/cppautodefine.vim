if exists('g:loaded_cppautodefine')
  finish
endif

let g:loaded_cppautodefine = '0.1.0' " version number

command! -buffer Test call cppautodefine#Test()
command! -buffer DefineFunc call cppautodefine#DefineCurrFunction()
