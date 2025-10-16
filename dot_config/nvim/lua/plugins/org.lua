return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  opts = {
    org_agenda_files = '~/Code/notes/**/*',
    org_default_notes_file = '~/Code/notes/index.org',
    mappings = {
      global = {
        org_babel_tangle = '<localleader>obt',
      },
    },
  },
}
