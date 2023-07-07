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
	if s:FileExist(fileName) == 0
	 silent exec "!touch " . fileName . '.cpp'
        " exe "normal! i#include <" . fileName . ".h>"
		call writefile(["#include <" . fileName . ".h>", ' '], fileName . '.cpp', "a")
	endif
	return fileName . ".cpp"
endfunction

function! cppautodefine#DefineCurrFunction()
	let currFuncNum = line(".")
	let currFunc = getline(currFuncNum)
	let fileName = s:CreateNewFile()
	
	if stridx(currFunc, '{')
		let currFunc = currFunc . " {"
	endif
	call writefile([currFunc, "}"], fileName, "a")
endfunction

function! s:FileExist(file)
	return filereadable(a:file)
endfunction

" function FindFile()
	
	
" endfunction

function! cppautodefine#WriteMessage() abort
  echom 'Hellp is a sample message.'
endfunction


" upgrades:
" FindFile to search one directory back
"
