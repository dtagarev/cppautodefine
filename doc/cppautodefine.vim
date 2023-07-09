==============================================================================
CONTENTS                                                    *cppautodefine*   *cppautodefine-contents*
	
    Installation................................: |cppautodefine-installation|
    Usage.......................................: |cppautodefine-usage|
    Issues......................................: |cppautodefine-issues|


==============================================================================
INSTALLATION                                                  *cppautodefine-installation*

The easiest way to install the plugin is with a plugin manager:

- vim-plug: https://github.com/junegunn/vim-plug
- Vundle:   https://github.com/VundleVim/Vundle.vim

If you use one, just follow the instructions in its documentation.

You can install the plugin yourself using Vim's |packages| functionality by
cloning the project (or adding it as a submodule) under
`~/.vim/pack/<any-name>/start/`. For example:
>
    git clone https://github.com/dtagarev/cppautodefine ~/.vim/pack/_/start/cppautodefine
<
This should automatically load the plugin for you on Vim start. Alternatively,
you can add it to `~/.vim/pack/<any-name>/opt/` instead and load it in your
.vimrc manually with:
>
    packadd cppautodefine
<

==============================================================================
USAGE                                                                *cppautodefine-usage*

A simple vim plugin to automatically define C++ functions.
you can manage the function definitions inside both header and cpp filesd and easily create new functions.
The plugin works with header and cpp files that are stored in the same folder. If they are at different places
the plugin is not going to find them and will create new files.

Here is a breakdown of what the commands do:

DefineFunc - defines the function under the cursor's position. If the line under the cursor is not a function
it will echo an error and do nothing. If you are inside a header file and the corresponding cpp is not created
it will be created and the function definition is going to be put there. If the function is allready defined 
it will send you to the location of the definition. Afther executing the command you will be teleported
to the function definition so you can start typing right away. The function works the same from cpp to header file. If there is no header
it will be created. The only difference is that in this situation you will be not teleported to the header file.

DefineAllFunc - finds all fucntion in the oppened file and defines them in the corresponding other file. If some functions are allready
defined they will be skipped.

MirrorFunc - changes the signature of the function under the cursor in both the header and cpp files. If the function is not
found in both files the command will echo an error. Prompts to the user the function's sugnature and when you user is done formatting
the new signature will replace the old in both files. Works if executed from both header and cpp files.

==============================================================================
ISSUES                                                         *cppautodefine-issues*

Any issues and suggestions are very welcome on the github bugtracker:
https://github.com/dtagarev/cppautodefine/issues

vim:tw=78:sw=4:ft=help:norl:
