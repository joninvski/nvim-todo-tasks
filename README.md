# nvim-todo-tasks

A simple Neovim plugin for managing TODO tasks in markdown files.

## Features

- **`:TodoNew`** - Creates a new task below the current line with a creation date
- **`:TodoComplete`** - Marks the current task as complete and moves it to the `## finished` section

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "jtrindade/nvim-todo-tasks",
  ft = "markdown",
  opts = {},
}
```

Or from a local path:

```lua
{
  dir = "~/workspace/nvim_todo_tasks",
  ft = "markdown",
  opts = {},
}
```

## Configuration

```lua
require("todo_tasks").setup({
  finished_section = "## finished",  -- Header for the finished tasks section
  date_format = "%Y-%m-%d",          -- Date format for created/closed timestamps
})
```

## Usage

### Creating a new task

Position your cursor where you want to add a task and run:

```
:TodoNew
```

This creates a new line below with:

```markdown
- [ ] Task description (created: 2024-01-15)
```

The cursor is positioned for you to type the task description.

### Completing a task

Position your cursor on an open task (`- [ ]`) and run:

```
:TodoComplete
```

This will:
1. Mark the task as complete (`- [x]`)
2. Add a closed date
3. Move the task to the `## finished` section

### Recommended keymaps

```lua
vim.keymap.set("n", "<leader>tn", "<cmd>TodoNew<cr>", { desc = "New TODO task" })
vim.keymap.set("n", "<leader>tc", "<cmd>TodoComplete<cr>", { desc = "Complete TODO task" })
```

## Example markdown file

```markdown
# TODO

## Work

- [ ] Do code review (created: 2024-01-10)
- [ ] Write documentation (created: 2024-01-12)

## Personal

- [ ] Clean garden (created: 2024-01-08)

## finished

- [x] Fix bug in auth module (created: 2024-01-05) (closed: 2024-01-07)
- [x] Update dependencies (created: 2024-01-01) (closed: 2024-01-03)
```

## License

MIT
