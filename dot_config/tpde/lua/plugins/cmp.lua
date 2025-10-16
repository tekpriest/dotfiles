--[[
super tab
	function(fb)
  if cmp.visible() then
    if snip.expandable() then
      snip.expand()
    else
      cmp.confirm { select = true }
    end
  else
    fb()
  end
end
]]
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'petertriho/cmp-git',
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      local cmp = require 'cmp'
      local snip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            snip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<CR>'] = cmp.mapping(function(fb)
            if cmp.visible() then
              if snip.expandable() then
                snip.expand()
              else
                cmp.mapping.confirm { select = true }
              end
            else
              fb()
            end
          end),
          ['<Tab>'] = cmp.mapping(function(fb)
            if cmp.visible() then
              cmp.select_next_item()
            elseif snip.locally_jumpable(1) then
              snip.jump(1)
            else
              fb()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fb)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snip.locally_jumpable(-1) then
              snip.jump(-1)
            else
              fb()
            end
          end, { 'i', 's' }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Esc>'] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }

      -- git
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        }),
      })

      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets', 'benfowler/telescope-luasnip.nvim' },
    init = function() end,
    config = function(_, opts)
      local snip = require 'luasnip'
      local extender = require('luasnip').filetype_extend
      if opts then
        snip.config.setup(opts)
      end
      require('luasnip.loaders.from_vscode').lazy_load()
      -- friendly-snippets - enable standardized comments snippets
      extender('typescript', { 'tsdoc' })
      extender('javascript', { 'jsdoc' })
      extender('lua', { 'luadoc' })
      extender('rust', { 'rustdoc' })
      extender('c', { 'cdoc' })
      extender('cpp', { 'cppdoc' })
      extender('sh', { 'shelldoc' })
    end,
  },
}
