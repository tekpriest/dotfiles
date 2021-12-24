local colors = require ".utils.colors"
local Utils = {}
Utils.normal = {
    a = {
        bg = colors.base01,
        fg = colors.white
    },
    b = {
        bg = colors.base01,
        fg = colors.white
    },
    c = {
        bg = colors.base01,
        fg = colors.white
    }
}
Utils.insert = {
    a = {
        bg = colors.base01,
        fg = colors.green
    },
    b = {
        bg = colors.base01,
        fg = colors.green
    },
    c = {
        bg = colors.base01,
        fg = colors.green
    }
}
Utils.visual = {
    a = {
        bg = colors.base01,
        fg = colors.orange
    },
    b = {
        bg = colors.base01,
        fg = colors.orange
    },
    c = {
        bg = colors.base01,
        fg = colors.orange
    }
}
Utils.replace = {
    a = {
        bg = colors.base01,
        fg = colors.red
    },
    b = {
        bg = colors.base01,
        fg = colors.red
    },
    c = {
        bg = colors.base01,
        fg = colors.red
    }
}
Utils.command = {
    a = {
        bg = colors.base01,
        fg = colors.cyan
    },
    b = {
        bg = colors.base01,
        fg = colors.cyan
    },
    c = {
        bg = colors.base01,
        fg = colors.cyan
    }
}

Utils.terminal = Utils.normal

Utils.inactive = {
    a = {
        bg = colors.base01,
        fg = colors.base03
    },
    b = {
        bg = colors.base01,
        fg = colors.base03
    },
    c = {
        bg = colors.base01,
        fg = colors.base03
    }
}
return Utils
