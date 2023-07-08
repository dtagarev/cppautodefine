let s:functionRegexWithCurlyOrig = "[a-zA-Z][a-zA-Z0-9_]*\s\s*[a-zA-Z_][a-zA-Z0-9_]*\s*\\(.*\\)\s*{"
"
"
"
let s:functionRegexWithCurly      = "^\\s*[a-zA-Z][a-zA-Z0-9_]*\\s\\s*[a-zA-Z_][a-zA-Z0-9_]*\\s*(.*)\\s*{"
let s:functionRegexWithColumn     = "^\\s*[a-zA-Z][a-zA-Z0-9_]*\\s\\s*[a-zA-Z_][a-zA-Z0-9_]*\\s*(.*)\\s*;"
let s:functionRegexWithoutCurly   = "^\\s*[a-zA-Z][a-zA-Z0-9_]*\\s\\s*[a-zA-Z_][a-zA-Z0-9_]*\\s*(.*)\\s*"

"string - match(), matchstr()
"readfile() , readblob()
"for lists- index(), indexof(), add(), insert() , map(), remove()

function! s:SaveFiles()
	silent execute "wa"
endfunction

"read from file or read from curr buffer?
function cppautodefine#FindAllFunctions(fileName)
	if match(a:fileName, '\.h') != -1 || match(a:fileName, '\.hpp') != -1
		call s:FindAllFunctionsWork(a:fileName, g:FunctionListHpp, g:FunctionListIdxHpp)
	elseif match(a:fileName, '.cpp') != -1
		call s:FindAllFunctionsWork(a:fileName, g:FunctionListCpp, g:FunctionListIdxCpp)
	else
		echo "Error: Unsupported filetype"
	endif
endfunction

function s:FindAllFunctionsWork(fileName, ListContainer, LinNumContainer)
	
	if empty(a:ListContainer) != 1
		call remove(a:ListContainer, 0, len(a:ListContainer) - 1)
	endif
	if empty(a:LinNumContainer) != 1
		call remove(a:LinNumContainer, 0, len(a:LinNumContainer) - 1) 
	endif
	
	let fileList = readfile(a:fileName) " read from File
	" let fileList = getline(1, '$') " read from current buffer
	
	echo fileList
	let lineCounter = 1
	let potencialFunc = 'temp'
	let potencialFuncLN = -1
	for str in fileList
		if str != '' && match(str, '^\s*else') == -1
			if potencialFunc == "temp"
				if match(str, s:functionRegexWithCurly) != -1 || match(str, s:functionRegexWithColumn) != -1
					call add(a:ListContainer, s:cleanFunctionString(str))
					call add(a:LinNumContainer, lineCounter)
				elseif match(str, s:functionRegexWithoutCurly) != -1
					let potencialFunc = s:cleanFunctionString(str)
					let potencialFuncLN = lineCounter
				endif
			elseif potencialFunc != "temp" && match(str, '^\s*{') == 0
				call add(a:ListContainer, potencialFunc)
				call add(a:LinNumContainer, potencialFuncLN)
				let potencialFunc = "temp"
				let potencialFuncLN = -1
			endif
		endif
		
		let lineCounter = lineCounter + 1
	endfor
	echo a:ListContainer
	echo a:LinNumContainer
endfunction


function! s:cleanFunctionString(str)
	let cleaned_str = substitute(a:str, '\s\+', ' ', 'g')
	let cleaned_str = substitute(cleaned_str, ';.*' , '', 'g')
	let cleaned_str = substitute(cleaned_str, '{.*' , '', 'g') 
	let cleaned_str = substitute(cleaned_str, '^\s\+', '', '')
    let cleaned_str = substitute(cleaned_str, '\s\+$', '', '')
    let cleaned_str = substitute(cleaned_str, ' \+', ' ', 'g')
    let cleaned_str = substitute(cleaned_str, '\s(', '(', '')
    return cleaned_str
endfunction

" make it user edditable to choose between h hpp or custom
function! s:CreateNewFile(str)
	let fileName = expandcmd('%:t:r')
	if a:str == '.h'
		echo "Currently not supporting header files"
	elseif a:str == '.cpp'
		if s:FileExist(fileName . a:str) == 0
			silent exec "!touch " . fileName . a:str
			call writefile(['#include "' . fileName . '.h"', ''], fileName . a:str, "a")
		endif
	else
		echo "Unsupported filetype"
	endif
	
	return fileName . a:str
endfunction
function! MatchIndex(hayStack, hayStackLN, needle, needleLN) 
	
endfunction

function! cppautodefine#DefineCurrFunction()
	
	"!!!!! save the files
	call s:SaveFiles()

	if match(expandcmd('%:t'), '\.h') == -1 && match(expandcmd('%:t'), '\.hpp') == -1
		echo "Error: This command works only in header files"
		return 
	endif
	
	let currFuncNum = line(".")
	let currFunc = getline(currFuncNum)
	let currFunc = s:cleanFunctionString(currFunc)

	call cppautodefine#FindAllFunctions(expandcmd('%:t'))
	let currFuncIdx = index(g:FunctionListHpp, currFunc)
	
	if currFuncIdx == -1
		echo "Error: Line under the cursor is not a function"
		return
	endif
	
	let otherfile = expandcmd('%:t:r') . '.cpp'
	call cppautodefine#FindAllFunctions(otherfile)
	
	if index(g:FunctionListCpp, currFunc) >= 0 
		echo "This function is allready defined"
		return
	endif
	
	let funcLN = s:DefineOneFunc(currFunc, '.cpp')
	
	if funcLN != -1 
		silent execute "e +" . funcLN . ' ' . otherfile
	else
		echo "Error: Function not added"
	endif
	
endfunction

function! cppautodefine#DefineAllFunctions()
	"!!!!! save the files
	call s:SaveFiles()
	
	if match(expandcmd('%:t'), '\.h') == -1 && match(expandcmd('%:t'), '\.hpp') == -1
		echo "Error: This command works only in header files"
		return 
	endif
	
	call cppautodefine#FindAllFunctions(expandcmd('%:t'))
	let otherfile = expandcmd('%:t:r') . '.cpp'
	call cppautodefine#FindAllFunctions(otherfile)
	
	let counter = 0
	
	for fn in g:FunctionListHpp
		if index(g:FunctionListCpp, fn) == -1
			call s:DefineOneFunc(fn, '.cpp')
			let counter = counter + 1
		endif
	endfor
	echo counter . " functions defined"
endfunction




"assumes the funcion is not defined 
function! s:DefineOneFunc(prettyFName, ext)
	
	if a:ext == ".cpp"
		let ourF = g:FunctionListHpp
		let ourFLN = g:FunctionListIdxHpp
		let otherF = g:FunctionListCpp
		let otherFLN = g:FunctionListIdxCpp
	else
		let ourF = g:FunctionListCpp
		let ourFLN = g:FunctionListIdxCpp
		let otherF = g:FunctionListHpp
		let otherFLN = g:FunctionListIdxHpp
	endif
	
	
	let destination = s:CreateNewFile(a:ext)
	
	call cppautodefine#FindAllFunctions(destination)
	
	if empty(otherF) == 1 
		let tmp = copy(a:prettyFName) . " {" 
		call writefile([tmp, "}", ''], destination, "a")
		call cppautodefine#FindAllFunctions(destination)
		let prettyIdx = index(otherF, a:prettyFName)
		return otherFLN[prettyIdx]
	endif
	
	let alreadyDefined = []
	
	for fn in ourF
		if fn != a:prettyFName	
			if index(otherF, fn) >= 0
				call add(alreadyDefined, ourFLN[index(ourF, fn)])
			endif
		endif
	endfor
	
	call sort(alreadyDefined)
	let prettyLN = ourFLN[index(ourF, a:prettyFName)]
	
	for num in alreadyDefined
		if prettyLN < num 
			let afterF = ourF[index(ourFLN, num)]
			let afterFLN = otherFLN[index(otherF, afterF)]
			let content = readfile(destination)
			call insert(content, copy(a:prettyFName) . ' {', afterFLN - 1)
			call insert(content, '}', afterFLN)
			call insert(content, '', afterFLN + 1)
			call writefile(content, destination)
			return afterFLN
		endif
	endfor
	
	let tmp = copy(a:prettyFName) . " {" 
	call writefile([tmp, "}", ''], destination, "a")
	call cppautodefine#FindAllFunctions(destination)
	let prettyIdx = index(otherF, a:prettyFName)
	return otherFLN[prettyIdx]
	
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
	let fileName = expandcmd('%:t')
	" echo match(fileName, '.h')
	call cppautodefine#FindAllFunctions(fileName)
endfunction

" function FindFile()
	
	
" endfunction

" upgrades:
" FileExis to search one directory back ( drawbacks: can jump out of the last folder of the project
" to work if the file is't in the current dirrectory ( maby not possible )
" Mirror ( only for the function under the cursor 
