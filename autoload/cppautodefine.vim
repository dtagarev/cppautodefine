"
"ind functions ( finds every line where a c++ function is defined
"define function (under the cursor);
"chech if file exist
"add new function to file
" regex that finds the function definition
" regex that finds the function name

" function cppautodefine#FindAllFunctions() abort
	
" endfunction

function! s:CreateNewFile()
	let fileName = expandcmd('%:t:r')
	if s:FileExist(fileName . '.cpp') == 0
		silent exec "!touch " . fileName . '.cpp'
		call writefile(['#include "' . fileName . '.h"', ''], fileName . '.cpp', "a")
	endif
	return fileName . ".cpp"
endfunction

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

function! s:FileExist(file)
	" if filereadable(a:file) == 1
	" 	echo "The File exists"
	" elseif filereadable(a:file) == 0
	" 	echo "The File doesn't exist"
	" endif
	return filereadable(a:file)
endfunction

" function FindFile()
	
	
" endfunction


" upgrades:
" FileExis to search one directory back
" to work if the file is't in the current dirrectory
"
