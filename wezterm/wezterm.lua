local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true

config.default_prog = { "pwsh.exe", "-NoLogo" }
config.launch_menu = {
	{
		label = "WSL: Ubuntu-24.04",
		args = { "wsl.exe", "-d", "Ubuntu-24.04" },
	},
	{
		label = "PowerShell 7",
		args = { "pwsh.exe", "-NoLogo" },
		domain = { DomainName = "local" },
	},
	{
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
		domain = { DomainName = "local" },
	},
	{
		label = "Command Prompt",
		args = { "cmd.exe" },
		domain = { DomainName = "local" },
	},
}

-- ~/.ssh/config からHostを読み取ってlaunch_menuに追加
local ssh_config_path = wezterm.home_dir .. "/.ssh/config"
local f = io.open(ssh_config_path, "r")
if f then
	for line in f:lines() do
		local host = line:match("^Host%s+(.+)")
		if host and not host:find("[*?]") then
			table.insert(config.launch_menu, {
				label = "SSH: " .. host,
				args = { "ssh", host },
			})
		end
	end
	f:close()
end

config.color_scheme = "Tokyo Night"
config.background = {
	{
		source = { File = wezterm.home_dir .. "/.config/wezterm/backgrounds/yuki_tsunoda_2025.jpg" },
		hsb = { brightness = 0.1 },
		width = "Cover",
		height = "Cover",
		horizontal_align = "Center",
		vertical_align = "Middle",
	},
	{
		source = { Color = "#1a1b26" },
		width = "100%",
		height = "100%",
		opacity = 0.75,
	},
}
config.font_size = 15.0
config.use_ime = true
config.window_decorations = "RESIZE"

local act = wezterm.action

config.keys = {
	{ key = "t", mods = "CTRL", action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|TABS" }) },
	{ key = "d", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({ name = "claude_chord", one_shot = true, timeout_milliseconds = 1000 }),
	},
	{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
	-- ペイン移動 (vim風)
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	-- ペインリサイズ (Ctrl+矢印)
	{ key = "LeftArrow",  mods = "CTRL", action = act.AdjustPaneSize({ "Left",  1 }) },
	{ key = "RightArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow",    mods = "CTRL", action = act.AdjustPaneSize({ "Up",    1 }) },
	{ key = "DownArrow",  mods = "CTRL", action = act.AdjustPaneSize({ "Down",  1 }) },
}

config.key_tables = {
	claude_chord = {
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = act.SplitPane({
				direction = "Right",
				size = { Percent = 30 },
				command = { args = { "claude" }, domain = "CurrentPaneDomain" },
			}),
		},
	},
}

-- タブバーの見た目
config.use_fancy_tab_bar = true
config.window_frame = {
	font = wezterm.font({ family = "PlemolJP Console NF", weight = "Bold" }),
	font_size = 15.0,
	active_titlebar_bg = "#1a1b26",
	inactive_titlebar_bg = "#16161e",
}
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
		},
		inactive_tab = {
			bg_color = "#24283b",
			fg_color = "#565f89",
		},
		inactive_tab_hover = {
			bg_color = "#364a82",
			fg_color = "#c0caf5",
		},
		new_tab = {
			bg_color = "#1a1b26",
			fg_color = "#7aa2f7",
		},
		new_tab_hover = {
			bg_color = "#364a82",
			fg_color = "#c0caf5",
		},
	},
}

-- タブバー右端にステータス情報を表示
wezterm.on("update-status", function(window, pane)
	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		local charge = math.floor(b.state_of_charge * 100 + 0.5)
		local icon = charge > 70 and "🔋" or charge > 20 and "🪫" or "⚠️"
		bat = icon .. " " .. charge .. "%"
	end

	local date = wezterm.strftime("%Y-%m-%d %H:%M")

	window:set_right_status(wezterm.format({
		{ Text = bat .. "  🗓️ " .. date .. "  " },
	}))
end)

return config
