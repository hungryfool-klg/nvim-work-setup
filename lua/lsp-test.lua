-- Test configuration for LSP setup
-- This file helps verify that LSP configuration is working properly

local M = {}

-- Function to check if LSP client is available
function M.check_lsp_client(client_name)
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.name == client_name then
      return true
    end
  end
  return false
end

-- Function to list all active LSP clients
function M.list_active_clients()
  local clients = vim.lsp.get_clients()
  local active_clients = {}
  for _, client in ipairs(clients) do
    table.insert(active_clients, client.name)
  end
  return active_clients
end

-- Function to test LSP configuration
function M.test_lsp_config()
  print("Testing LSP Configuration...")
  
  -- Check if vim.lsp.config is available
  if vim.lsp.config then
    print("✓ vim.lsp.config is available")
  else
    print("✗ vim.lsp.config is not available")
    return false
  end
  
  -- Test if we can create a dummy config
  local test_config = {
    cmd = { 'echo', 'test' },
    filetypes = { 'test' },
    root_markers = { 'test.txt' }
  }
  
  local success = pcall(vim.lsp.config, 'test_server', test_config)
  if success then
    print("✓ vim.lsp.config works correctly")
  else
    print("✗ vim.lsp.config failed")
    return false
  end
  
  print("✓ LSP configuration test passed")
  return true
end

-- Function to display LSP server status
function M.lsp_status()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print("No LSP clients are currently active")
  else
    print("Active LSP clients:")
    for _, client in ipairs(clients) do
      print(string.format("  - %s (ID: %d)", client.name, client.id))
    end
  end
end

-- Keybinding to test LSP status
vim.keymap.set('n', '<leader>ls', M.lsp_status, { desc = 'Show LSP status' })

return M