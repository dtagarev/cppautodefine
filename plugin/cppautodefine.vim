" Title:        cppautodefine
" Description:  A simple vim plugin to automatically define C++ functions.
" Last Change:  9 July 2023
" Maintainer:   <https://github.com/dtagarev>
if exists('g:loaded_cppautodefine')
  finish
endif

let g:loaded_cppautodefine = '0.1.0' " version number

let g:FunctionListCpp = []
let g:FunctionListIdxCpp = []

let g:FunctionListHpp = []
let g:FunctionListIdxHpp = []
