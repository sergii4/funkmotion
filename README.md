# Funkmotion
[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension

## Installation
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua

use {
    'sergii4/funkmotion',
    requires = {
        { 'nvim-telescope/telescope.nvim' },
    },
} 
```
Then load it:
```
require 'telescope'.load_extension 'funkmotion'
```

## Usage

From command-line mode: `:Telescope funkmotion`, with mapping:
```
nnoremap <leader>fm <cmd>Telescope funkmotion<cr>
```
