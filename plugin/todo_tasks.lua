if vim.g.loaded_todo_tasks then
  return
end
vim.g.loaded_todo_tasks = true

vim.api.nvim_create_user_command("TodoNew", function()
  require("todo_tasks").new_task()
end, { desc = "Create a new TODO task below current line" })

vim.api.nvim_create_user_command("TodoComplete", function()
  require("todo_tasks").complete_task()
end, { desc = "Complete current task and move to finished section" })
