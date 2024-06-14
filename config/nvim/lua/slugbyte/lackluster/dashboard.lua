require('dashboard').setup({
    theme = 'hyper',
    header = {
        text = 'neovim'
    },
    config = {
        center = {
            {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find File           ',
                desc_hl = 'String',
                key = 'b',
                keymap = 'SPC f f',
                key_hl = 'Number',
                key_format = ' %s',     -- remove default surrounding `[]`
                action = 'lua print()'
            },
            {
                icon = ' ',
                desc = 'Find Dotfiles',
                key = 'f',
                keymap = 'SPC f d',
                key_format = ' %s',     -- remove default surrounding `[]`
                action = 'lua print(3)'
            },
        },
        footer = {}     --your footer
    }

})
