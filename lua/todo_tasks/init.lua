local M = {}

M.config = {
  finished_section = "## finished",
  date_format = "%Y-%m-%d",
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.get_date()
  return os.date(M.config.date_format)
end

function M.new_task()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  if filetype ~= "markdown" then
    vim.notify("TodoTasks: Only works in markdown files", vim.log.levels.WARN)
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local date = M.get_date()
  local new_line = string.format("- [ ]  (created: %s)", date)

  vim.api.nvim_buf_set_lines(bufnr, row, row, false, { new_line })
  vim.api.nvim_win_set_cursor(0, { row + 1, 6 })
  vim.cmd("startinsert")
end

function M.find_finished_section(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local pattern = M.config.finished_section:lower()

  for i, line in ipairs(lines) do
    if line:lower():match("^##%s*finished") then
      return i
    end
  end

  return nil
end

function M.complete_task()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  if filetype ~= "markdown" then
    vim.notify("TodoTasks: Only works in markdown files", vim.log.levels.WARN)
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]

  if not line:match("^%s*%- %[ %]") then
    vim.notify("TodoTasks: Current line is not an open task", vim.log.levels.WARN)
    return
  end

  local finished_row = M.find_finished_section(bufnr)
  if not finished_row then
    vim.notify("TodoTasks: Could not find '## finished' section", vim.log.levels.ERROR)
    return
  end

  local date = M.get_date()
  local completed_line = line:gsub("^(%s*)%- %[ %]", "%1- [x]")

  if completed_line:match("%(created:") then
    completed_line = completed_line:gsub("%s*$", "") .. " (closed: " .. date .. ")"
  else
    completed_line = completed_line:gsub("%s*$", "") .. " (closed: " .. date .. ")"
  end

  vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, {})

  local new_finished_row = M.find_finished_section(bufnr)
  if not new_finished_row then
    vim.notify("TodoTasks: Could not find '## finished' section after deletion", vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_set_lines(bufnr, new_finished_row, new_finished_row, false, { completed_line })

  local new_cursor_row = math.min(row, vim.api.nvim_buf_line_count(bufnr))
  vim.api.nvim_win_set_cursor(0, { new_cursor_row, 0 })

  vim.notify("TodoTasks: Task completed and moved to finished section", vim.log.levels.INFO)
end

return M
