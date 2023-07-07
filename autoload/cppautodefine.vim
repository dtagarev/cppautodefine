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
	let fileName = expandcmd('%:t:r') . '.cpp'
	if s:FileExist(fileName) == 0
	 silent exec "!touch " . fileName
	endif
endfunction

function cppautodefine#DefineCurrFunction()
	let currFuncNum = line(".")
	let currFunc = getline(currFuncNum)
	call s:CreateNewFile()
	" echom currFunc
endfunction

function! s:FileExist(file)
	return filereadable(a:file)
endfunction

" function FindFile()
	
	
" endfunction

function! cppautodefine#WriteMessage() abort
  echom 'Hellp is a sample message.'
endfunction
