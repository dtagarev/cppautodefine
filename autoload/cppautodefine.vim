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
	let currFileName = expand('%:r')
	let test = expand('%:t')
	echom currFileName
	echom test
	" execute 'touch ' . currFileName . '.cpp'
endfunction

function cppautodefine#DefineCurrFunction()
	let currFuncNum = line(".")
	let currFunc = getline(currFuncNum)
	call s:CreateNewFile()
	echom currFunc
endfunction


function FileExist()
	return 
endfunction

" function FindFile()
	
	
" endfunction

function! cppautodefine#WriteMessage() abort
  echom 'This is a sample message.'
endfunction
