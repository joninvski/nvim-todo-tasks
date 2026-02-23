vim.filetype.add({
  filename = {
    ["TODO.md"] = "markdown_todo",
  },
})

-- Tell treesitter to use markdown parser for this filetype
vim.treesitter.language.register("markdown", "markdown_todo")
