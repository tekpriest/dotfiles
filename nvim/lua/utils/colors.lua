local Utils = {}
Utils.colors = {
    base00 = "#1b2b34",
    base01 = "#343d46",
    base02 = "#4f5b66",
    base03 = "#65737e",
    base04 = "#a7adba",
    base05 = "#c0c5ce",
    base06 = "#cdd3de",
    base07 = "#d8dee9",
    red = "#ec5f67",
    orange = "#f99157",
    yellow = "#fac863",
    green = "#99c794",
    cyan = "#62b3b2",
    blue = "#6699cc",
    purple = "#c594c5",
    brown = "#ab7967",
    white = "#a5afbe",
    grey = "#5c6370",
    grey_light = "#3e4452",
    grey_lighter = "#2c323c",
    transparent = "#333840",
    background = "#282c34",
    background_light = "#3C4048"
}

vim.cmd("colorscheme gruvbox")

function Utils.setItalics()
    vim.cmd("hi Comment gui=italic")
    vim.cmd("hi Keyword gui=italic")
    vim.cmd("hi Keyword gui=italic")
    vim.cmd("hi Identifier gui=italic")
    vim.cmd("hi StorageClass gui=italic")
    vim.cmd("hi jsLineComment gui=italic")
    vim.cmd("hi xmlAttrib gui=italic")
    vim.cmd("hi htmlArg gui=italic")
    vim.cmd("hi pythonSelf gui=italic")
end

return Utils
