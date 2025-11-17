return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage selected hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset selected hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff this ~" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })
      end,
    },
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    keys = {
      { "<leader>gaf", "<cmd>G add %<cr>", desc = "Git add current file" },
      { "<leader>gaa", "<cmd>G add .<cr>", desc = "Git add all files" },
      { "<leader>gs", "<cmd>G<cr>", desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gca", "<cmd>Git commit --amend<cr>", desc = "Git amend last commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gd", "<cmd>Git diff<cr>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gB", "<cmd>Git branch<cr>", desc = "Git branch list" },
      { "<leader>gcr", "<cmd>Gvdiffsplit!<cr>", desc = "Resolve Conflicts" },
      { "]x", "<cmd>Gdiffsplit!<cr>", desc = "Next Conflict" },
      { "[x", "<cmd>Gdiffsplit!<cr>", desc = "Previous Conflict" },
      { "<leader>gcc", "<cmd>diffget //2<cr>", desc = "Choose Conflict (ours)" },
      { "<leader>gct", "<cmd>diffget //3<cr>", desc = "Choose Conflict (theirs)" },
      {
        "<leader>gcb",
        function()
          vim.ui.input({ prompt = "New branch name: " }, function(input)
            if input then
              vim.cmd("Git checkout -b " .. input)
            end
          end)
        end,
        desc = "Git create branch",
      },
      {
        "<leader>gco",
        function()
          vim.ui.input({ prompt = "Checkout branch: " }, function(input)
            if input then
              vim.cmd("Git checkout " .. input)
            end
          end)
        end,
        desc = "Git checkout branch",
      },
      {
        "<leader>gm",
        function()
          vim.ui.input({ prompt = "Merge branch: " }, function(input)
            if input then
              vim.cmd("Git merge " .. input)
            end
          end)
        end,
        desc = "Git merge branch",
      },
      {
        "<leader>gr",
        function()
          vim.ui.input({ prompt = "Rebase onto: " }, function(input)
            if input then
              vim.cmd("Git rebase " .. input)
            end
          end)
        end,
        desc = "Git rebase branch",
      },
      { "<leader>glog", "<cmd>Git log<cr>", desc = "Git log" },
      {
        "<leader>gch",
        function()
          vim.ui.input({ prompt = "Cherry-pick commit: " }, function(input)
            if input then
              vim.cmd("Git cherry-pick " .. input)
            end
          end)
        end,
        desc = "Git cherry-pick",
      },
      {
        "<leader>grs",
        function()
          vim.ui.input({ prompt = "Reset to: " }, function(input)
            if input then
              vim.cmd("Git reset " .. input)
            end
          end)
        end,
        desc = "Git reset",
      },
      { "<leader>gstash", "<cmd>Git stash<cr>", desc = "Git stash" },
      { "<leader>gpop", "<cmd>Git stash pop<cr>", desc = "Git stash pop" },
      { "<leader>gcf", "<cmd>Git checkout %<cr>", desc = "Git checkout current file" },
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView File History" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
    },
    opts = {
      enhanced_diff_hl = true,
      use_icons = true,
    },
  },
}