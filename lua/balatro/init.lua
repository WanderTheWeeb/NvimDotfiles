local M = {}
local win, buf
local timer = vim.loop.new_timer()

local function get_all_ascii_modules()
  local path = vim.fn.stdpath("config") .. "/lua/balatro/raws"
  local files = vim.fn.globpath(path, "*.lua", false, true)
  local modules = {}

  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t:r")
    local modname = "balatro.raws." .. filename
    table.insert(modules, modname)
  end

  return modules
end

local function trim_left(card_data)
  local lines = card_data.lines
  local highlights = card_data.highlights

  if not lines or #lines == 0 then
    return { lines = { "no ascii art found" }, highlights = nil }
  end

  local min_indent = math.huge

  for _, line in ipairs(lines) do
    if line:match("%S") then
      local indent = line:match("^(%s*)")
      if indent and #indent < min_indent then
        min_indent = #indent
      end
    end
  end

  if min_indent == math.huge then
    min_indent = 0
  end

  local trimmed_lines = {}
  for _, line in ipairs(lines) do
    if line:match("%S") then
      table.insert(trimmed_lines, line:sub(min_indent + 1))
    else
      table.insert(trimmed_lines, "")
    end
  end

  return { lines = trimmed_lines, highlights = highlights }
end

local function pick_random_card()
  local mods = get_all_ascii_modules()

  if #mods == 0 then
    return { lines = { "no ascii modules found" }, highlights = nil }
  end

  local modname = mods[math.random(1, #mods)]

  package.loaded[modname] = nil

  local success, module_data = pcall(require, modname)

  if not success then
    return { lines = { "error loading module: " .. modname, tostring(module_data) }, highlights = nil }
  end

  if type(module_data) == "table" and module_data.val and module_data.opts and module_data.opts.hl then
    return { lines = module_data.val, highlights = module_data.opts.hl }
  elseif type(module_data) == "table" and module_data.val then
    return { lines = module_data.val, highlights = nil }
  elseif type(module_data) == "table" and #module_data > 0 then
    return { lines = module_data, highlights = nil }
  else
    return { lines = { "invalid module format: " .. modname }, highlights = nil }
  end
end

function M.show()
  local function render_card()
    local card_data = trim_left(pick_random_card())
    local lines = card_data.lines
    local highlights = card_data.highlights

    if not lines or #lines == 0 then
      lines = { "no ascii art found" }
      highlights = nil
    end

    local width = 1
    for _, line in ipairs(lines) do
      width = math.max(width, vim.fn.strdisplaywidth(line))
    end
    width = math.max(width, 10)

    local height = math.max(#lines, 3)

    if not buf or not vim.api.nvim_buf_is_valid(buf) then
      buf = vim.api.nvim_create_buf(false, true)
    end

    if not win or not vim.api.nvim_win_is_valid(win) then
      win = vim.api.nvim_open_win(buf, false, {
        relative = "editor",
        row = 1,
        col = vim.o.columns - width - 2,
        width = width,
        height = height,
        style = "minimal",
        border = "none",
        focusable = false,
        noautocmd = true,
      })
    end

    vim.api.nvim_win_set_config(win, {
      relative = "editor",
      row = 1,
      col = vim.o.columns - width - 2,
      width = width,
      height = height,
    })

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    if highlights then
      vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)

      for line_idx, line_highlights in ipairs(highlights) do
        if line_highlights and line_idx <= #lines then
          for _, hl in ipairs(line_highlights) do
            local hl_group, start_col, end_col = hl[1], hl[2], hl[3]
            vim.api.nvim_buf_add_highlight(buf, -1, hl_group, line_idx - 1, start_col, end_col)
          end
        end
      end
    end
  end

  render_card()

  timer:start(
    0,
    5000,
    vim.schedule_wrap(function()
      if vim.api.nvim_get_mode().mode == "c" then
        return
      end
      render_card()
    end)
  )
end

function M.hide()
  if timer then
    timer:stop()
  end

  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = nil
  end

  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
    buf = nil
  end
end

return M
