local g = vim.g

function getWikiPath()
  if os.getenv('os') == 'Windows_NT'
    then
      return 'D:/Nextcloud/Notes'
    else
      return '~/Nextcloud/Notes'
    end
  end

g['vimwiki_list'] = {{path = getWikiPath(), syntax = 'markdown', ext = '.md'}}
