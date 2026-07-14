vim.api.nvim_create_user_command("CSquickfix", function()
  local handle = io.popen("coding-style . 2>&1")
  local output = handle:read("*a")
  handle:close()
  local logfile = "coding-style-reports.log"
  local items = {}
  local f = io.open(logfile, "r")
  if not f then
    vim.notify("Fichier " .. logfile .. " introuvable", vim.log.levels.ERROR)
    return
  end
  for line in f:lines() do
    local filename, lnum, text = line:match("^([^:]+):(%d+):%s*(.*)")
    if filename and lnum and text then
      table.insert(items, {
        filename = filename,
        lnum = tonumber(lnum),
        text = text,
      })
    else
      table.insert(items, { text = line })
    end
  end
  f:close()
  vim.fn.setqflist({}, ' ', { title = "Coding Style", items = items })
end, { desc = "Lance coding-style . et met le log dans la quickfixlist" })