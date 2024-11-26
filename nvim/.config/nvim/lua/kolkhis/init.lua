require('kolkhis.remap')
require('kolkhis.set')
require('telescope').setup({})

if package.loaded['streamer-mode'] then
    require('streamer-mode').setup({
        default_state = 'off',
        paths = { '*' },
    })
end

