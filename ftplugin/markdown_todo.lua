-- Inherit markdown settings
vim.cmd("runtime! ftplugin/markdown.vim ftplugin/markdown.lua")

-- Enable treesitter highlighting with markdown parser
vim.treesitter.language.register("markdown", "markdown_todo")
vim.treesitter.start()
