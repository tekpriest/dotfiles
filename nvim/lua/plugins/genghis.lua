return {
  { -- convenience file operations
    'chrisgrieser/nvim-genghis',
    dependencies = 'stevearc/dressing.nvim',
    init = function() vim.g.genghis_disable_commands = true end,
    keys = {
      -- stylua: ignore start
      -- { "<C-p>", function() require("genghis").copyFilepathWithTilde() end, desc = " Copy path (with ~)" },
      { "<leader>mp", function() require("genghis").copyRelativePath() end, desc = " Copy relative path" },
      { "<leader>mc", function() require("genghis").copyFilename() end, desc = " Copy filename" },
      { "<leader>mr", function() require("genghis").renameFile() end, desc = " Rename file" },
      { "<leader>mm", function() require("genghis").moveToFolderInCwd() end, desc = " Move file" },
      { "<leader>mx", function() require("genghis").chmodx() end, desc = " chmod +x" },
      { "<leader>md", function() require("genghis").duplicateFile() end, desc = " Duplicate file" },
      { "<leader>me", function() require("genghis").trashFile() end, desc = " Move file to trash" },
      { "<leader>mn", function() require("genghis").createNewFile() end, desc = " Create new file" },
      { "<leader>mm", function() require("genghis").moveSelectionToNewFile() end, mode = "x", desc = " Selection to new file" },
      -- stylua: ignore end
    },
  },
}
