"find functions ( finds every line where a c++ function is defined
"define function (under the cursor);
"chech if file exist
"add new function to file
" regex that finds the function definition
" regex that finds the function name

function FindAllFunctions() abort
	
endfunction

function DefineCurrFunction()
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
