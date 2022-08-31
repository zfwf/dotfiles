local wezterm = require 'wezterm';

wezterm.on("update-right-status", function(window, pane)
  -- "Wed Mar 3 08:14"
  local date = wezterm.strftime("%a %b %-d %H:%M ");

  local bat = ""
  for _, b in ipairs(wezterm.battery_info()) do
    bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format({
    {Text=bat .. "   "..date},
  }));
end)

return {
  leader = { key="a", mods="CTRL" },
  keys = {
    -- just LEADER won't work
    {key="x", mods="LEADER|SHIFT",
     action=wezterm.action{CloseCurrentPane={confirm=true}}},
    {key="%", mods="LEADER|SHIFT",
     action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="\"", mods="LEADER|SHIFT",
     action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  },
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  font_size = 18.0,
  color_scheme = "Dracula",
  use_ime = true,
  use_dead_keys = false,
  scrollback_lines = 99999,
}
