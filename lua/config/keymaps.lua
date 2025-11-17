vim.keymap.set("n", "<leader>cf", function()
  local file_path = vim.fn.expand("%:p")
  local new_file_path = vim.fn.input("Copy to: ", file_path, "file")
  if new_file_path ~= "" then
    vim.fn.system({ "cp", file_path, new_file_path })
    print("File copied to: " .. new_file_path)
  end
end, { desc = "Copy current file" })

vim.keymap.set("n", "<leader>cp", function()
  local relative_path = vim.fn.expand("%")
  vim.fn.setreg("+", relative_path)
  print("Relative path copied: " .. relative_path)
end, { desc = "Copy relative filepath to clipboard" })

vim.keymap.set("n", "<leader>sr", function()
  local search_term = vim.fn.input("Search for: ")
  if search_term ~= "" then
    vim.cmd("grep! " .. vim.fn.shellescape(search_term) .. " **/*")
    vim.cmd("copen")
  end
end, { desc = "Search and replace workflow" })

vim.keymap.set("n", "<leader>sR", function()
  local search_term = vim.fn.input("Search for: ")
  if search_term ~= "" then
    local replace_term = vim.fn.input("Replace with: ")
    if replace_term ~= "" then
      vim.cmd("grep! " .. vim.fn.shellescape(search_term) .. " **/*")
      vim.cmd("cdo s/" .. vim.fn.escape(search_term, "/") .. "/" .. vim.fn.escape(replace_term, "/") .. "/gc")
    end
  end
end, { desc = "Quick search and replace in all files" })

vim.keymap.set("n", "<leader>qn", ":cnext<cr>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>qp", ":cprev<cr>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>qo", ":copen<cr>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", ":cclose<cr>", { desc = "Close quickfix list" })

vim.keymap.set("n", "<leader>qr", function()
  local old_term = vim.fn.input("Replace (in quickfix): ")
  if old_term ~= "" then
    local new_term = vim.fn.input("Replace with: ")
    if new_term ~= "" then
      vim.cmd("cdo s/" .. vim.fn.escape(old_term, "/") .. "/" .. vim.fn.escape(new_term, "/") .. "/gc")
      vim.cmd("cfdo update")
    end
  end
end, { desc = "Replace in all quickfix items" })