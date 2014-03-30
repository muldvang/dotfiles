--------------------------------------------------------------------------------
-- IMPORTS
--------------------------------------------------------------------------------

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- Menubar library
local menubar = require("menubar")

-- Vicious widget library
local vicious = require("vicious")

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

function check_for_startup_errors()
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
      awesome.connect_signal(
         "debug::error",
         function (err)
            -- Make sure we don't go into an endless error loop
            if in_error then return end
            in_error = true

            naughty.notify({ preset = naughty.config.presets.critical,
                             title = "Oops, an error happened!",
                             text = err })
            in_error = false
         end)
   end
end

function create_main_menu()
   return awful.menu(
      { items = { { "Lock screen",
                    function ()
                       awful.util.spawn("slimlock")
                    end },
                  { "Reboot",
                    function ()
                       awful.util.spawn("systemctl reboot")
                    end },
                  { "Poweroff",
                    function ()
                       awful.util.spawn("systemctl poweroff")
                    end },
                  { "Restart XBMC",
                    function ()
                       awful.util.spawn_with_shell("pkill --signal 9 xbmc; and xbmc &")
                    end }}})
end

function awesome_launcher(menu)
   return awful.widget.launcher(
      { image = beautiful.awesome_icon,
        menu = menu })
end

function date_clock_widget()
   local clock = awful.widget.textclock(" %b %d, %H:%M ", 30)
   return clock
end

function battery_widget()
   local icon = wibox.widget.imagebox()
   local old_state = -1
   vicious.register(icon,
                    vicious.widgets.bat,
                    function (widget, args)
                       local new_state = "" .. args[1] .. args[2]
                       if old_state == new_state then
                          old_state = new_state
                          return
                       end
                       old_state = new_state

                       -- Create menu
                       -- menu:delete(1)
                       -- menu:delete(1)
                       -- menu:delete(1)
                       -- local status
                       -- if args[1] == "+" then
                       --    status = "Charging"
                       -- else
                       --    status = "Discharging"
                       -- end
                       -- menu:add({ status .. " - " .. args[2] .. "%",
                       --            function()
                       --            end
                       -- })
                       -- menu:add({ args[3] .. " remaining",
                       --            function()
                       --            end
                       -- })

                       -- Notify if battery level is below 10 percent
                       if args[2] <= 10 and args[1] == "-" then
                          naughty.notify({ text="Low battery level! " ..
                                              args[2] ..
                                              " percent remaining." })
                       end

                       -- Set icon image
                       local image

                       if args[2] < 10 then
                          image = "000"
                       elseif args[2] < 20 then
                          image = "020"
                       elseif args[2] < 40 then
                          image = "040"
                       elseif args[2] < 60 then
                          image = "060"
                       elseif args[2] < 80 then
                          image = "080"
                       else
                          image = "100"
                       end

                       if args[1] == "+" then
                          -- Charging
                          image = image .. "-charging"
                       end
                       icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/16/battery-" .. image .. ".svg")
                    end,
                    30,
                    "BAT0")
   return icon
end

function wifi_widget()
   local icon = wibox.widget.imagebox()
   local old_state = -1
   vicious.register(icon,
                    vicious.widgets.wifi,
                    function (widget, args)
                       local new_state = args["{link}"]
                       if old_state == new_state then
                          old_state = new_state
                          return
                       end
                       old_state = new_state

                       if args["{ssid}"] == "N/A" then
                          -- Not connected
                          icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/16/nm-no-connection.svg")
                       else
                          -- Connected
                          local image
                          if args["{link}"] == 0 then
                             image = "0"
                          elseif args["{link}"] < 25 then
                             image = "25"
                          elseif args["{link}"] < 50 then
                             image = "50"
                          elseif args["{link}"] < 75 then
                             image = "75"
                          else
                             image = "100"
                          end
                          icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/16/nm-signal-" .. image .. ".svg")
                       end
                    end,
                    5,
                    "wls1")
   return icon
end

function sound_widget()
   local icon = wibox.widget.imagebox()
   local tooltip = awful.tooltip({objects = {icon}})
   local old_state = -1
   vicious.register(icon,
                    vicious.widgets.volume,
                    function (widget, args)
                       local new_state = args[1]
                       if old_state == new_state then
                          old_state = new_state
                          return
                       end
                       old_state = new_state

                       -- High, medium, low, zero
                       local level = args[1]
                       tooltip:set_text("" .. level)

                       local level_name
                       if level > 66 then
                          level_name = "high"
                       elseif level > 33 then
                          level_name = "medium"
                       elseif level >= 1 then
                          level_name = "low"
                       else
                          level_name = "low-zero"
                       end
                       icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/22/audio-volume-" .. level_name .. "-panel.svg")
                    end,
                    30,
                    "PCM")
   return icon
end

function package_widget()
   local icon =  wibox.widget.imagebox()
   local tooltip = awful.tooltip({objects = {icon}})
   local update_count = 0
   local old_state = -1
   vicious.register(icon,
                    vicious.widgets.pkg,
                    function (widget, args)
                       update_count = args[1]

                       local new_state = update_count
                       if old_state == new_state then
                          old_state = new_state
                          return
                       end
                       old_state = new_state

                       tooltip:set_text("" .. update_count)
                       if update_count == 0 then
                          -- Find a better way to hide the widget?
                          -- E.g. by letting the cron-job update the
                          -- widget after each repository sync. The
                          -- widget could be updated to zero after
                          -- each upgrade by issueing pacman -Su &&
                          -- "update".
                          icon:set_image()
                       else
                          icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/22/system-devices-panel.svg")
                       end
                    end,
                    30,
                    "Arch")
   return icon
end

function gmail_widget()
   local icon = wibox.widget.imagebox()
   local tooltip = awful.tooltip({objects = {icon}})

   local old_state = -1
   vicious.register(icon,
                    vicious.widgets.gmail,
                    function(widget, args)
                       local count = args["{count}"]
                       local new_state = count
                       if old_state == new_state then
                          old_state = new_state
                          return
                       end
                       old_state = new_state

                       tooltip:set_text(args["{subject}"])
                       if count > 0 then
                          icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/16/indicator-messages-new.svg")

                       else
                          icon:set_image("/usr/share/icons/ubuntu-mono-dark/status/16/indicator-messages.svg")
                       end
                    end,
                    300)
   return icon
end

function dropbox_widget()
   local icon = wibox.widget.imagebox()
   local tooltip = awful.tooltip({objects = {icon}})
   local image
   local old_state = -1
   vicious.register(icon,
                    vicious.widgets.mpd,
                    function(widget, args)
                       local status = awful.util.pread("dropbox status")

                       local new_state = status
                       if old_state == new_state then
                          old_state = new_state
                          if status == "Do" or status == "Sy" then
                             -- Downloading
                             if image == "busy" then
                                image = "busy2"
                             else
                                image = "busy"
                             end
                             icon:set_image("/usr/share/icons/ubuntu-mono-dark/apps/22/dropboxstatus-" .. image .. ".svg")
                          end
                          return
                       end
                       old_state = new_state


                       tooltip:set_text(status)
                       status = status:sub(0, 2)

                       if status == "Do" or status == "Sy" or status == "In" or status == "St" then
                          -- Downloading, indexing, starting
                          if image == "busy" then
                             image = "busy2"
                          else
                             image = "busy"
                          end
                       elseif status == "Co" or status == "Dr" then
                          -- Connecting
                          image = "x"
                       elseif status == "Id" or status == "Up" then
                          -- Idle, Up to date
                          image = "idle"
                       else
                          image = "logo"
                       end
                       icon:set_image("/usr/share/icons/ubuntu-mono-dark/apps/22/dropboxstatus-" .. image .. ".svg")
                    end,
                    1)
   return icon
end

function tasklist_widget(screen)
   local tasklist_buttons = awful.util.table.join(
      awful.button({ }, 1,
                   function (c)
                      if c == client.focus then
                         c.minimized = true
                      else
                         -- Without this, the following :isvisible() makes no
                         -- sense
                         c.minimized = false
                         if not c:isvisible() then
                            awful.tag.viewonly(c:tags()[1])
                         end
                         -- This will also un-minimize the client, if needed
                         client.focus = c
                         c:raise()
                      end
                   end))

   return awful.widget.tasklist(screen,
                                awful.widget.tasklist.filter.currenttags,
                                tasklist_buttons)
end

function taglist_widget(screen)
   local taglist_buttons = awful.util.table.join(
      awful.button({}, 1, awful.tag.viewonly),
      awful.button({modkey}, 1, awful.client.movetotag),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({modkey}, 3, awful.client.toggletag))

   local style = { font = beautiful.font_tags }
   return awful.widget.taglist(screen,
                               awful.widget.taglist.filter.all,
                               taglist_buttons,
                               style)
end

function spawn_on_keypress(modkeys, key, cmd)
   return awful.key(modkeys, key,
                    function ()
                       awful.util.spawn(cmd)
                    end
                   )
end

function spawn_with_shell_on_keypress(modkeys, key, cmd)
   return awful.key(modkeys, key,
                    function ()
                       awful.util.spawn_with_shell(cmd)
                    end
                   )
end

function clone_screen_vga()
   local xrandr = io.popen("xrandr -q | grep \"VGA1 connected\"")
   if xrandr then
      awful.util.spawn("xrandr --output LVDS1 --mode 1440x900")
   else
      awful.util.spawn("xrandr --output LVDS1 --mode 1024x768 --output VGA1 --mode 1024x768")
   end

end

function add_rule(rule)
   if awful.rules.rules then
      table.insert(awful.rules.rules, rule)
   else
      awful.rules.rules = { rule }
   end
end

-- First check for errors.
check_for_startup_errors()

-- Set the modkey
modkey = "Mod4"

-- Set the theme
beautiful.init("/home/muldvang/.config/awesome/themes/mytheme/theme.lua")

-- Settings for the menubar
menubar.utils.terminal = "urxvt"
menubar.show_categories = false
menubar.cache_entries = true

-- Set the wallpaper
local hostname = awful.util.pread("hostname")

if hostname == "Tor\n" then
   gears.wallpaper.maximized(
      '/home/muldvang/.config/awesome/themes/mytheme/awesome_arch_1280x1024.jpg', 1, true)
   gears.wallpaper.maximized(
      '/home/muldvang/.config/awesome/themes/mytheme/awesome_arch_1920x1080.jpg', 2, true)
else
   for s = 1, screen.count() do
         gears.wallpaper.maximized(
            '/home/muldvang/.config/awesome/themes/mytheme/awesome_arch_1440x900.jpg', s, true)
   end
end

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {awful.layout.suit.max,
                 awful.layout.suit.tile,
                 awful.layout.suit.tile.bottom
}

-- Use three tags as standard.
for s = 1, screen.count() do
   awful.tag.add("1", { layout = layouts[1], screen = s })
   awful.tag.add("2", { layout = layouts[1], screen = s })
   awful.tag.add("3", { layout = layouts[1], screen = s })
   awful.tag.viewtoggle(awful.tag.gettags(s)[1])
end

function widget_button(widget, cmd, keep_open)
   local bg = wibox.widget.background()
   local window_name = cmd:gsub("%s+", "")
   widget:buttons(awful.button({ },
                          1,
                          function()
                             local matcher = function (c)
                                return awful.rules.match(c, {name = window_name})
                             end
                             if keep_open then
                                spawn_cmd = "termite --hold -e \"".. cmd .. "\""
                             else
                                spawn_cmd = "termite -e \"" .. cmd .. "\""
                             end
                             awful.client.run_or_raise(spawn_cmd, matcher)
                          end))
   bg:set_widget(widget)
   return bg
end

-- Create a menu to shutdown computer and stuff like that.
local mainmenu = create_main_menu()

-- Create a wibox at the top of the screen and add a bunch of stuff to it.
local wibox_top = {}
local taglist = {}
local promptbox = {}
local tasklist = {}
local layoutbox = {}
for s = 1, screen.count() do
   taglist[s] = taglist_widget(s)
   promptbox[s] = awful.widget.prompt()
   tasklist[s] = tasklist_widget(s)
   layoutbox[s] = awful.widget.layoutbox(1)

   local mainmenu_launcher = awesome_launcher(mainmenu)
   local battery = battery_widget()
   local wifi = wifi_widget()
   local sound = sound_widget()
   local mail = gmail_widget()
   local dropbox = dropbox_widget()
   local pacman = package_widget()
   local date_clock = date_clock_widget()

   local left_layout = wibox.layout.fixed.horizontal()
   left_layout:add(mainmenu_launcher)
   left_layout:add(taglist[s])
   left_layout:add(promptbox[s])

   local right_layout = wibox.layout.fixed.horizontal()
   -- if s == 1 then
   --    local systray = wibox.widget.systray()
   --    right_layout:add(systray)
   -- end
   if hostname == "Tor\n" then
      widgets = { pacman, mail, dropbox, sound, date_clock }
   else
      widgets = { pacman, mail, dropbox, wifi, battery, sound, date_clock }
   end
   for _, widget in pairs(widgets) do
      right_layout:add(widget)
   end
   right_layout:add(layoutbox[s])

   local layout = wibox.layout.align.horizontal()
   layout:set_left(left_layout)
   layout:set_middle(tasklist[s])
   layout:set_right(right_layout)

   wibox_top[s] = awful.wibox({ position = "top", height = "16", screen = s })
   wibox_top[s]:set_widget(layout)
end

--------------------------------------------------------------------------------
-- GLOBAL KEY BINDINGS
--------------------------------------------------------------------------------
local volume_notification
globalkeys = awful.util.table.join(
   -- Clone screen
   awful.key({}, "#235", function() clone_screen_vga() end),

   -- Use modkey + F1-F2 to launch most used programs
   spawn_on_keypress({ modkey }, "F1", "emacsclient -c"),
   spawn_on_keypress({ modkey }, "F2", "dwb"),
   spawn_on_keypress({ modkey }, "F3", "urxvt -e ranger"),
   spawn_on_keypress({ modkey }, "F4", "urxvt -e ncmpcpp"),

   -- Start radio with DR P6 BEAT
   spawn_with_shell_on_keypress({ }, "#156", "mpc clear; and mpc load \"DR P6 BEAT\"; and mpc play"),

   -- Lock screen
   spawn_on_keypress({ }, "#160", "slimlock"),

   -- Screenshot
   spawn_on_keypress({ }, "#107", "gnome-screenshot --interactive"),

   -- Termite
   spawn_on_keypress({ modkey }, "Return", "termite"),

   -- Control ncmpcpp
   spawn_with_shell_on_keypress({}, "#171",
                                "ncmpcpp next"),
   spawn_with_shell_on_keypress({}, "#172",
                                "ncmpcpp toggle"),
   spawn_with_shell_on_keypress({}, "#173",
                                "ncmpcpp prev"),
   spawn_with_shell_on_keypress({}, "#174",
                                "ncmpcpp stop"),

   -- Volume down
   awful.key({},
             "#122",
             function ()
                local amixer = awful.util.pread("amixer set PCM 1%-")
                local volume = string.match(amixer, "%d+%%")
                volume_notification = naughty.notify({ title="Volume",
                                                       text="Volume lowered to " .. volume,
                                                       replaces_id=volume_notification }).id
             end ),

   -- Volume up
   awful.key({},
             "#123",
             function ()
                local amixer = awful.util.pread("amixer set PCM 1%+")
                local volume = string.match(amixer, "%d+%%")
                volume_notification = naughty.notify({ title="Volume",
                                                       text="Volume raised to " .. volume,
                                                       replaces_id=volume_notification }).id
             end ),


   -- Next/previous tag
   awful.key({ modkey, "Mod1" }, "k", awful.tag.viewprev),
   awful.key({ modkey, "Mod1" }, "j", awful.tag.viewnext),

   -- Move client to next/previous tag
   awful.key({ modkey }, "j",
         function ()
           awful.client.focus.byidx(1)
           if client.focus then client.focus:raise() end
         end),

   awful.key({ modkey }, "k",
         function ()
           awful.client.focus.byidx(-1)
           if client.focus then client.focus:raise() end
         end),

   -- Show the main menu
   awful.key({ modkey }, "w",
             function ()
                mainmenu:show()
             end),

   -- Move client inside tag
   awful.key({ modkey, "Shift" }, "j",
             function ()
                awful.client.swap.byidx(1)
             end),

   awful.key({ modkey, "Shift" }, "k",
             function ()
                awful.client.swap.byidx(-1)
             end),

   -- Next/previous screen
   awful.key({ modkey, "Control" }, "j",
             function ()
                awful.screen.focus_relative(1)
             end),

   awful.key({ modkey, "Control" }, "k",
             function ()
                awful.screen.focus_relative(-1)
             end),

   -- Restart awesome
   awful.key({ modkey, "Control" }, "r", awesome.restart),

   -- Increase/decrease size of master client
   awful.key({ modkey }, "l",
             function ()
                awful.tag.incmwfact( 0.05)
             end),

   awful.key({ modkey }, "h",
             function ()
                awful.tag.incmwfact(-0.05)
             end),

   -- Increase/decrease number of master clients
   awful.key({ modkey, "Shift" }, "h",
             function ()
                awful.tag.incnmaster(1)
             end),

   awful.key({ modkey, "Shift" }, "l",
             function ()
                awful.tag.incnmaster(-1)
             end),

   -- Increase/decrease columns of secondary clients
   awful.key({ modkey, "Control" }, "h",
             function ()
                awful.tag.incncol(1)
             end),

   awful.key({ modkey, "Control" }, "l",
             function ()
                awful.tag.incncol(-1)
             end),

   -- Switch layout forwards/backwards
   awful.key({ modkey }, "space",
             function ()
                awful.layout.inc(layouts,  1)
             end),

   awful.key({ modkey, "Shift" }, "space",
             function ()
                awful.layout.inc(layouts, -1)
             end),

   -- Restore minimized client
   awful.key({ modkey, "Control" }, "n", awful.client.restore),

   -- Show prompt
   awful.key({ modkey }, "r",
             function ()
                promptbox[mouse.screen]:run()
             end),

   -- Show menubar
   awful.key({ modkey }, "p",
             function()
                menubar.show()
   end),

   -- Add and remove tags
   awful.key({ modkey }, "+",
             function ()
                local props = {selected = true,
                               layout = layouts[1] }
                local name = #awful.tag.gettags(mouse.screen) + 1
                awful.tag.add(name, props)
             end
   ),

   awful.key({ modkey }, "-",
             function()
                awful.tag.delete()
             end
   ),

   -- Move client to the left or the right and switch to that tag
   awful.key({ modkey, "Mod1"   }, "h",
             function (c)
                local curidx = awful.tag.getidx()
                local tags = awful.tag.gettags(mouse.screen)
                if curidx == 1 then
                   awful.client.movetotag(tags[#tags])
                else
                   awful.client.movetotag(tags[curidx - 1])
                end
                awful.tag.viewidx(-1)
             end
   ),
   awful.key({ modkey, "Mod1"   }, "l",
             function (c)
                local curidx = awful.tag.getidx()
                local tags = awful.tag.gettags(mouse.screen)
                if curidx == #tags then
                   awful.client.movetotag(tags[1])
                else
                   awful.client.movetotag(tags[curidx + 1])
                end
                awful.tag.viewidx(1)
             end
   )
)


-- Compute the maximum number of digit we need, limited to 9
-- local keynumber = 9
-- for s = 1, screen.count() do
--    keynumber = math.min(9, math.max(#tags[s], keynumber))
-- end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, keynumber do
--   globalkeys = awful.util.table.join(
--      globalkeys,
--      awful.key({ modkey }, "#" .. i + 9,
--                function ()
--                   local screen = mouse.screen
--                   if tags[screen][i] then
--                      awful.tag.viewonly(tags[screen][i])
--                   end
--                end),
--      awful.key({ modkey, "Control" }, "#" .. i + 9,
--                function ()
--                   local screen = mouse.screen
--                   if tags[screen][i] then
--                      awful.tag.viewtoggle(tags[screen][i])
--                   end
--                end),
--      awful.key({ modkey, "Shift" }, "#" .. i + 9,
--                function ()
--                   if client.focus and tags[client.focus.screen][i] then
--                      awful.client.movetotag(tags[client.focus.screen][i])
--                   end
--                end),
--      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--                function ()
--                   if client.focus and tags[client.focus.screen][i] then
--                      awful.client.toggletag(tags[client.focus.screen][i])
--                   end
--                end))
-- end

-- Set keys
root.keys(globalkeys)

--------------------------------------------------------------------------------
-- CLIENT MOUSE BUTTON AND KEY BINDINGS
--------------------------------------------------------------------------------

clientkeys = awful.util.table.join(
  awful.key({ modkey }, "f",
         function (c)
           c.fullscreen = not c.fullscreen
         end),

  awful.key({ modkey }, "c",
         function (c)
           c:kill()
         end),

  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),

  awful.key({ modkey, "Control" }, "Return",
         function (c)
           c:swap(awful.client.getmaster())
         end),

  awful.key({ modkey }, "o", awful.client.movetoscreen),

  awful.key({ modkey }, "t",
         function (c)
           c.ontop = not c.ontop
         end),

  awful.key({ modkey }, "n",
         function (c)
           -- The client currently has the input focus, so it cannot be
           -- minimized, since minimized clients can't have the focus.
           c.minimized = true
         end),

  awful.key({ modkey }, "m",
         function (c)
           c.maximized_horizontal = not c.maximized_horizontal
           c.maximized_vertical  = not c.maximized_vertical
         end)
                       )

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

--------------------------------------------------------------------------------
-- RULES
--------------------------------------------------------------------------------

local all_clients_rule = { rule = { },
                           properties = { border_width = beautiful.border_width,
                                          border_color = beautiful.border_normal,
                                          focus = awful.client.focus.filter,
                                          keys = clientkeys,
                                          buttons = clientbuttons,
                           } }

local gimp_rule = { rule = { class = "Gimp-2.8" },
                    properties = { floating = true } }
local xbmc_rule = { rule = { class = "xbmc" },
                    properties = {
                       tag = awful.tag.gettags(math.min(screen.count(), 2))[1],
                       fullscreen = true } }
local firefox_plugins_rule = { rule = { instance = "plugin-container" },
                               properties = { floating = true } }

add_rule(all_clients_rule)
add_rule(gimp_rule)
add_rule(xbmc_rule)
add_rule(firefox_plugins_rule)

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal(
   "manage",
   function (c, startup)
      -- Enable sloppy focus
      c:connect_signal(
         "mouse::enter",
         function(c)
            if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
               and awful.client.focus.filter(c) then
            client.focus = c
            end
         end)

      if not startup then
         -- Set the windows at the slave,
         -- i.e. put it at the end of others instead of setting it master.
         -- awful.client.setslave(c)

         -- Put windows in a smart way, only if they does not set an initial position.
         if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
         end
      end
   end)

client.connect_signal("focus",
                      function(c)
                         c.border_color = beautiful.border_focus
                      end)

client.connect_signal("unfocus",
                      function(c)
                         c.border_color = beautiful.border_normal
                      end)
