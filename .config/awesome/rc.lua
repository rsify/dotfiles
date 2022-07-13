-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

local theme = require('./theme')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
vaultpopup_rotation_index = 0

-- Themes define colours, icons, font and wallpapers.
beautiful.init(theme)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"

-- editor = os.getenv("EDITOR") or "nano"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor

vaultpopup_class = "vaultpopup"
singleton_vault_popups = false

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
}
-- }}}

-- {{{ Wibar

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = awful.button({ }, 1, function(t) t:view_only() end)
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        s.mytaglist,
        -- Middle widget
        wibox.container.margin (
            awful.widget.tasklist {
                screen  = s,
                filter  = awful.widget.tasklist.filter.currenttags,
                buttons = awful.button({ }, 1, function (c)
                    c:emit_signal(
                        "request::activate",
                        "tasklist",
                        {raise = true}
                    )
                end),
                layout = {
                    layout = wibox.layout.flex.horizontal,
                    max_widget_size = 200
                },
                widget_template = {
                    {
                        {
                            id = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                        left = 10,
                        right = 10,
                        widget = wibox.container.margin
                    },
                    id = 'background_role',
                    widget = wibox.container.background,
                }
            },
            1
        ),
        { -- Right widget
           {
              layout = wibox.layout.fixed.horizontal,
              awful.widget.watch('bash -c "curl https://wttr.in/$(cat .config/private/current-city)?format=%C%20%t"', 1800 --[[ 30 minutes ]]),
              wibox.widget.textbox(" | "),
              awful.widget.watch({ os.getenv("HOME")..'/.config/bin/iwd-ssid.sh', "wlan0" }, 10),
              wibox.widget.textbox(" | "),
              awful.widget.watch(os.getenv("HOME")..'/.config/bin/wibar-loadavg.sh', 5),
              wibox.widget.textbox(" | "),
              awful.widget.watch(os.getenv("HOME")..'/.config/bin/wibar-memory.sh', 5),
              wibox.widget.textbox(" | "),
              awful.widget.watch(os.getenv("HOME")..'/.config/bin/wibar-storage-root.sh', 60),
              wibox.widget.textbox(" |"),
              awful.widget.keyboardlayout(),
              wibox.widget.textbox("|"),
              wibox.widget.systray(),
              wibox.widget.textclock(" %Y-%m-%d %a %H:%M "),
              wibox.widget.textbox("("),
              awful.widget.watch('bash -c "cal | tail -n 1 | awk \'{print $NF}\'"', 5),
              wibox.widget.textbox(") "),
              awful.widget.layoutbox(s)
           },
           left = 3,
           top = 3,
           bottom = 3,
           right = 3,
           layout = wibox.container.margin
        }
    }
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "a", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey            }, "l", function ()
        -- make sure that there's no window focused if the screen being
        -- switched to is empty (otherwise the only indication is the cursor
        -- moving and it's hard to notice any change
        client.focus = nil
        awful.screen.focus_relative( 1)
    end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey            }, "h", function ()
        -- make sure that there's no window focused if the screen being
        -- switched to is empty (otherwise the only indication is the cursor
        -- moving and it's hard to notice any change
        client.focus = nil
        awful.screen.focus_relative(-1)
    end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function ()
        if client.focus and client.focus.pid then
            awful.spawn.easy_async_with_shell(
                -- note: only grabs the top child process without going deeper,
                -- so things like pid's of nested shells or ranger shells won't be returned.
                "readlink -f /proc/(pgrep -nP "..client.focus.pid..")/cwd | tr -d '\n'",
                function (stdout)
                    if stdout and stdout:len() > 0 then
                        awful.spawn(terminal.." --working-directory "..stdout)
                    else
                        awful.spawn(terminal)
                    end

                    -- naughty.notify({text = "pgrep cwd: `"..stdout.."` pid("..client.focus.pid..")"})
                end)
        else
            awful.spawn(terminal)
        end
    end, {description = "terminal", group = "launcher"}),
    awful.key({ modkey,           }, "f", function () awful.spawn("firefox") end,
              {description = "firefox", group = "launcher"}),
    awful.key({ modkey,           }, "d", function () awful.spawn("alacritty --command ranger") end,
              {description = "ranger", group = "launcher"}),

    awful.key({modkey, "Shift"    }, "s", function ()
        -- screenshot with selection, save & copy to clipboard
        awful.spawn.with_shell("maim -s -f png | tee ~/Screenshots/(date +%s%N)-(shuf -n 1 ~/.config/misc/words).png | xclip -selection clipboard -t image/png")
    end, {description = "screenshot", group = "launcher"}),

    -- Obsidian vault launcher.
    -- Spawns alacritty with a fuzzy file finder in an obsidian vault in ~/vet,
    -- or attaches to one already spawned on the current tag.
    --
    -- fzf bindings:
    -- - enter to edit the selected
    -- - alt+enter to edit a new file named with whatever is in the fzf prompt
    -- - ctrl+c to exit
    awful.key({ modkey,           }, "v", function ()
        exists = false

        if singleton_vault_popups then
            for c in awful.client.iterate(function (c)
                return c.instance == vaultpopup_class and c.first_tag == awful.screen.focused().selected_tag
            end) do
                exists = true
                client.focus = c
            end
        end

        if not exists then
            awful.spawn(
                "alacritty --class "..vaultpopup_class.." --command fish .config/bin/alacritty-vaultpopup.fish"
            )
        end
    end, {description = "vet", group = "launcher"}),

    awful.key({ modkey, "Shift"   }, "v", function ()
        awful.spawn("alacritty --class "..vaultpopup_class.." --command fish -c vim")
    end, {description = "vim", group = "launcher"}),

    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey,           }, "Escape", function () awful.spawn('slock') end,
              {description = "lock", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.01)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.01)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next layout", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous layout", group = "layout"}),

    -- Rofi
    awful.key({ modkey }, "r", function() awful.spawn("rofi -show run") end,
              {description = "run prompt", group = "launcher"}),
    -- Rofi
    awful.key({ modkey, "Shift" }, "r", function() awful.spawn("rofi -show run -filter ,") end,
              {description = "run prompt with , prefix", group = "launcher"}),

    awful.key({ modkey }, "p", function() awful.spawn("rofi -show drun") end,
              {description = "launcher", group = "launcher"}),

    awful.key({ modkey }, "i", function() awful.spawn("rofi -show window -matching fuzzy") end,
              {description = "fuzzy select windows", group = "client"}),

    -- https://wiki.archlinux.org/title/Awesome#Media_Controls
    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", function ()
        awful.util.spawn("amixer -q -c 2 sset PCM 5%-", false) end),
    awful.key({}, "XF86AudioRaiseVolume", function ()
        awful.util.spawn("amixer -q -c 2 sset PCM 5%+", false) end),
    awful.key({}, "XF86AudioMute", function ()
        awful.util.spawn("amixer -q -c 2 set PCM toggle", false) end),

    -- Media Keys
    awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false) end),
    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl next", false) end),
    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl previous", false) end)
)

clientkeys = gears.table.join(
    awful.key({ modkey            }, "w",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        -- Activate on left click
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ }, 2, function (c)
        -- Activate on middle click
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true }},

    -- Add titlebars to dialogs
    { rule_any = {type = { "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    {
        rule_any = { instance = { vaultpopup_class } },
        properties = {
            floating = true,
            ontop = true,
            placement = function (client)
                awful.placement.centered(client)

                geo = client:geometry()

                r = 50
                angle = vaultpopup_rotation_index
                vaultpopup_rotation_index = vaultpopup_rotation_index + 0.4

                client:geometry({
                    x = geo.x + r * math.cos(angle) * 1.5,
                    y = geo.y + r * math.sin(angle),
                    height = geo.height,
                    width = geo.width
                })
            end,
        }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Left
            --awful.titlebar.widget.iconwidget(c),
            wibox.container.margin(awful.titlebar.widget.iconwidget(c), 3, 6, 3, 3),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Title
                align  = "left",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            -- awful.titlebar.widget.floatingbutton (c),
            -- awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.ontopbutton    (c),
            -- awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

-- {{{ Mouse bindings
-- root.buttons(gears.table.join(
--     awful.button({ }, 3, function () mymainmenu:toggle() end),
--     awful.button({ }, 4, awful.tag.viewnext),
--     awful.button({ }, 5, awful.tag.viewprev)
-- ))
-- }}}

-- local tasklist_buttons = gears.table.join(
--                      awful.button({ }, 1, function (c)
--                                               if c == client.focus then
--                                                   c.minimized = true
--                                               else
--                                                   c:emit_signal(
--                                                       "request::activate",
--                                                       "tasklist",
--                                                       {raise = true}
--                                                   )
--                                               end
--                                           end),
--                      awful.button({ }, 3, function()
--                                               awful.menu.client_list({ theme = { width = 250 } })
--                                           end),
--                      awful.button({ }, 4, function ()
--                                               awful.client.focus.byidx(1)
--                                           end),
--                      awful.button({ }, 5, function ()
--                                               awful.client.focus.byidx(-1)
--                                           end))

-- Create a wibox for each screen and add it
-- local taglist_buttons = gears.table.join(
--                     awful.button({ }, 1, function(t) t:view_only() end),
--                     awful.button({ modkey }, 1, function(t)
--                                               if client.focus then
--                                                   client.focus:move_to_tag(t)
--                                               end
--                                           end),
--                     awful.button({ }, 3, awful.tag.viewtoggle),
--                     awful.button({ modkey }, 3, function(t)
--                                               if client.focus then
--                                                   client.focus:toggle_tag(t)
--                                               end
--                                           end),
--                     awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
--                     awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
--                 )

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- (commented out removes tmux hotkeys from showing)
-- require("awful.hotkeys_popup.keys")
--
-- clientkeys
-- awful.key({ modkey,           }, "f",
--     function (c)
--         c.fullscreen = not c.fullscreen
--         c:raise()
--     end,
--     {description = "toggle fullscreen", group = "client"}),
-- awful.key({ modkey,           }, "n",
--     function (c)
--         -- The client currently has the input focus, so it cannot be
--         -- minimized, since minimized clients can't have the focus.
--         c.minimized = true
--     end ,
--     {description = "minimize", group = "client"}),

-- globalkeys
-- Toggle tag display.
-- awful.key({ modkey, "Control" }, "#" .. i + 9,
--           function ()
--               local screen = awful.screen.focused()
--               local tag = screen.tags[i]
--               if tag then
--                  awful.tag.viewtoggle(tag)
--               end
--           end,
--           {description = "toggle tag #" .. i, group = "tag"}),
-- Move client to tag.
-- Toggle tag on focused client.
-- awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--           function ()
--               if client.focus then
--                   local tag = client.focus.screen.tags[i]
--                   if tag then
--                       client.focus:toggle_tag(tag)
--                   end
--               end
--           end,
--           {description = "toggle focused client on tag #" .. i, group = "tag"})

-- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
--           {description = "increase master width factor", group = "layout"}),
-- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
--           {description = "decrease master width factor", group = "layout"}),
-- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
--           {description = "increase the number of master clients", group = "layout"}),
-- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
--           {description = "decrease the number of master clients", group = "layout"}),

-- awful.key({ modkey, "Control" }, "n",
--           function ()
--               local c = awful.client.restore()
--               -- Focus restored client
--               if c then
--                 c:emit_signal(
--                     "request::activate", "key.unminimize", {raise = true}
--                 )
--               end
--           end,
--           {description = "restore minimized", group = "client"}),

-- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
--           {description = "show main menu", group = "awesome"}),

-- layouts
-- awful.layout.suit.floating,
-- awful.layout.suit.tile.left,
-- awful.layout.suit.tile.top,
-- awful.layout.suit.fair.horizontal,
-- awful.layout.suit.spiral,
-- awful.layout.suit.spiral.dwindle,
-- awful.layout.suit.max,
-- awful.layout.suit.max.fullscreen,
-- awful.layout.suit.magnifier,
-- awful.layout.suit.corner.nw,
-- awful.layout.suit.corner.ne,
-- awful.layout.suit.corner.sw,
-- awful.layout.suit.corner.se,
