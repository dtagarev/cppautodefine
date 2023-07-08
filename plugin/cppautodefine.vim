" Title:        cppautodefine
" Description:  A plugin to provide an example for creating Vim plugins.
" Last Change:  9 July 2023
" Maintainer:   <https://github.com/dtagarev>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists('g:loaded_cppautodefine')
  finish
endif

let g:loaded_cppautodefine = '0.1.0' " version number

let g:FunctionListCpp = []
let g:FunctionListIdxCpp = []

let g:FunctionListHpp = []
let g:FunctionListIdxHpp = []
