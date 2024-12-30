--[[ 
   Wezterm configuration:
       https://wezfurlong.org/wezterm/config/lua/config/index.html
   Using WSL with Wezterm:
       https://wezfurlong.org/wezterm/config/lua/config/default_domain.html
--]]

local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

local current_os = wezterm.target_triple
if current_os and current_os:match("linux") then
    config.default_prog = { "/bin/bash" }
elseif current_os and current_os:match("windows") then
    -- config.default_domain = "WSL:Ubuntu-22.04"
    config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }
    config.set_environment_variables = {
        TERM = "xterm-256color",
    }
elseif current_os and current_os:match("apple") then
    config.default_prog = { "/opt/homebrew/bin/bash", "-l" }
    config.native_macos_fullscreen_mode = true
end

config.font_dirs = { "~/wez/.fonts/" }
config.font = wezterm.font("RobotoMono Nerd Font")

config.keys = {
    {
        key = "F11",
        action = wezterm.action.ToggleFullScreen,
    },
}

config.window_decorations = "RESIZE " -- NONE  | TITLE

-- Don't show tab bar
config.tab_bar_at_bottom = true
config.enable_tab_bar = true --  true | false
config.color_scheme = "Argonaut"

config.visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 150,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 150,
    target = "CursorColor",
}
-- config.default_gui_startup_args = {'ssh', 'homelab'}

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():set_position(200, 200)
end)

return config
