<p align="center">
  <h2 align="center"> C++ auto-define </h2>
</p>

## About

A simple vim plugin to automatically define C++ functions.
It is designed to releave you from the burden of always switching between header and cpp files.
With this plugin you can manage the function definitions inside both files and easily create new functions.
No need to create the corresponding files, they will be automatically created.

## Installation

Download with your favorite package manager.

```vim
call plug#begin()

" Cpp auto-define 
Plug 'dtagarev/cppautodefine'

" If you want it to only load when C++ file is opened
Plug 'dtagarev/cppautodefine', { 'for': 'cpp' }

call plug#end()
```

```lua
use "dtagarev/cppautodefine"
```

## Usage

Using the plugin is pretty simple. Type the command, get the job done.
The commands work both in header and cpp files.
- For the plugin to work correctly the files must be in the same directory. Otherwise a new file will be created the current directory

### Commands

| Command                             | Description                                                                                         |
| ----------------------------------- | --------------------------------------------------------------------------------------------------  |
| `DefineFunc`                        | Defines the function under the cursor. If the corresponding file doesn't exist, one is created. If you are inside a header file it teleports you to the cpp file so you can start typing right away.   |
| `DefineAllFunc`                     | Defines all functions in the current file. If the corresponding file doesn't exist, one is created. |
| `MirrorFunc`                        | Renames the function under the cursor in both the header and the cpp file.                          |

### Example mappings

```vim
"C++ auto-define
nmap df :DefineFunc<CR>
nmap da :DefineAllFunc<CR>
nmap mr :MirrorFunc<CR>
```
