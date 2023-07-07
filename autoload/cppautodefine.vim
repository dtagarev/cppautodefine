"
"ind functions ( finds every line where a c++ function is defined
"define function (under the cursor);
"chech if file exist
"add new function to file
" regex that finds the function definition
" regex that finds the function name

let s:functionRegexWithCurlyOrig = "[a-zA-Z][a-zA-Z0-9_]*\s\s*[a-zA-Z_][a-zA-Z0-9_]*\s*\\(.*\\)\s*{"
"
"
"
let s:functionRegexWithCurly     = "^[a-zA-Z][a-zA-Z0-9_]*\\s\\s*[a-zA-Z_][a-zA-Z0-9_]*\\s*\\(.*\\)\\s*{"
let s:functionRegexWithoutCurly  = "^[a-zA-Z][a-zA-Z0-9_]*\\s\\s*[a-zA-Z_][a-zA-Z0-9_]*\\s*\\(.*\\)\\s*"
"string - match(), matchstr()
"readfile() , readblob()
"for lists- index(), indexof(), add()

let g:FunctionListCpp = []
let g:FunctionListIdxCpp = []

function cppautodefine#FindAllFunctionsCpp(fileName) abort
	let fileList = readfile(a:fileName)
	echo fileList
	let lineCounter = 1
	let potencialFunc = 'temp'
	let potencialFuncLN = -1
	for str in fileList
		if str != '' && match(str, '^else') == -1
			if potencialFunc == "temp"
				if match(str, s:functionRegexWithCurly) != -1 
					call add(g:FunctionListCpp, str)
					call add(g:FunctionListIdxCpp, lineCounter)
				elseif match(str, s:functionRegexWithoutCurly) != -1
					let potencialFunc = str
					let potencialFuncLN = lineCounter
				endif
			elseif potencialFunc != "temp" && match(str, '^\s*{') == 0
				call add(g:FunctionListCpp, potencialFunc)
				call add(g:FunctionListIdxCpp, potencialFuncLN)
				let potencialFunc = "temp"
				let potencialFuncLN = -1
			endif
		endif
		
		let lineCounter = lineCounter + 1
	endfor
	echo g:FunctionListCpp
	echo g:FunctionListIdxCpp
endfunction

function! s:CreateNewFile()
	let fileName = expandcmd('%:t:r')
	if s:FileExist(fileName . '.cpp') == 0
		silent exec "!touch " . fileName . '.cpp'
		call writefile(['#include "' . fileName . '.h"', ''], fileName . '.cpp', "a")
	endif
	return fileName . ".cpp"
endfunction

"to-do: fix function type: void func(asdf) { return 1} 
function! cppautodefine#DefineCurrFunction()
	let currFuncNum = line(".")
	let currFunc = substitute(getline(currFuncNum), '^\s*', '', '')
	let currFunc = substitute(currFunc, ';', '', '')
	let fileName = s:CreateNewFile()
	
	if stridx(currFunc, '{')
		let currFunc = currFunc . " {"
	endif
	call writefile([currFunc, "}"], fileName, "a")
endfunction
" findfile() ??
function! s:FileExist(file)
	" if filereadable(a:file) == 1
	" 	echo "The File exists"
	" elseif filereadable(a:file) == 0
	" 	echo "The File doesn't exist"
	" endif
	return filereadable(a:file)
endfunction

function! cppautodefine#Test()
	let fileName = expandcmd('%:t:r') . '.cpp'
	call cppautodefine#FindAllFunctionsCpp(fileName)
endfunction

" function FindFile()
	
	
" endfunction


" upgrades:
" FileExis to search one directory back
" to work if the file is't in the current dirrectory
"
