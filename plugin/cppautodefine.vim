if exists('g:loaded_id3')
  finish
endif

let g:loaded_id3 = '0.1.0' " version number

command! -buffer Test call cppautodefine#WriteMessage()
