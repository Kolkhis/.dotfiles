local wezterm = require('wezterm')
local config = wezterm.config_builder()
-- https://wezfurlong.org/wezterm/config/lua/config/index.html
-- Using WSL with Wezterm:
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html

local os = wezterm.target_triple
if os and os:match('linux') then
    config.default_prog = { '/bin/bash' }
elseif os and os:match('windows') then
    config.font_dirs = { "E:/Coding/FONTS/RobotoMono", "/e/Coding/FONTS/RobotoMono" }
    config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }
    -- config.default_prog = { "C:/msys64/usr/bin/bash.exe", "-i", "-l" }  -- MSYS2
    config.set_environment_variables = {
        -- HOME = "/home/C", -- Use with MSYS2
        TERM = "xterm-256color",
    }
    config.font = wezterm.font("Roboto Mono")
end

config.keys = {
    {
        key = 'F11',
        action = wezterm.action.ToggleFullScreen,
    }
}
-- config.native_macos_fullscreen_mode = true
config.window_decorations = "RESIZE"

-- Don't show tab bar
-- config.tab_bar_at_bottom = false
config.enable_tab_bar = false
config.color_scheme = "Argonaut"

config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
    target = 'CursorColor'
}
-- config.default_gui_startup_args = {'ssh', 'homelab'}


local mux = wezterm.mux
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():set_position(200, 200)
end)

return config

