"
"ind functions ( finds every line where a c++ function is defined
"define function (under the cursor);
"chech if file exist
"add new function to file
" regex that finds the function definition
" regex that finds the function name

function cppautodefine#FindAllFunctions() abort
	
endfunction

function cppautodefine#DefineCurrFunction()
	let currFuncNum = line(".")
	let currFunc = getline(currFuncNum)
	let currFileName = expand('%')
	let newFileName = substitute(currFileName , '\..*', '', '')
	execute 'touch ' . newFileName . '.cpp'
	execute 'echo ' . currFunc . ' >> ' . newFileName
endfunction

function FileExist()
	return 
endfunction
function FindFile()
	
	
endfunction

function! cppautodefine#WriteMessage() abort
  echom 'This is a sample message.'
endfunction