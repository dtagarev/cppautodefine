<p align="center">
  <h2 align="center"> cppautodefine </h2>
</p>

## About
A simple vim plugin to automatically define C++ functions.
It is designed to releave you from the burden of always switching between header and cpp files.
With this plugin you can manage the function definitions inside both files and easily create new functions.
No need to create the corresponding files, they wil be automatically created.
## Features

- Extensive support for `TreeSitter` syntax highlighting, and _many_ popular plugins
- Compilation to lua byte code for super fast startup times

## Installation

Download with your favorite package manager.

```vim
call plug#begin()

" Cpp auto-define 
Plug 'dtagarev/cppautodefine'

call plug#end()
```
```lua
use "dtagarev/cppautodefine"
```

## Usage

Using the plugin is pretty simple. Type the command, get the job done.
The commands work both in header and cpp files.
- For the plugin to work the files must be in the same directory 

### Commands

| Command                             | Description                                                                                         |
| ----------------------------------- | --------------------------------------------------------------------------------------------------  |
| `DefineFunc`                        | Defines the function under the cursor. If the corresponding file doesn't exist, one is created.     |
| `DefineAllFunc`                     | Defines all functions in the current file. If the corresponding file doesn't exist, one is created. |
| `MirrorFunc`                        | Renames the function under the cursor in both the header and the cpp file.                          |

