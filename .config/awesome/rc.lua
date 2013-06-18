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
                  { "Restart",
                    function ()
                       awful.util.spawn("systemctl reboot")
                    end },
                  { "Shutdown",
                    function ()
                       awful.util.spawn("systemctl poweroff")
                    end }}})
end

function awesome_launcher(menu)
   return awful.widget.launcher(
      { image = beautiful.awesome_icon,
        menu = menu })
end

function clock_widget()
   local clock = wibox.widget.textbox()
   vicious.register(clock, vicious.widgets.date, "%b %d, %R", 30)
   return clock
end

function battery_widget()
   local batwidget = wibox.widget.textbox()
   local batwidget_t = awful.tooltip({ objects = { batwidget },})
   vicious.register(batwidget,
                 vicious.widgets.bat,
                 function (widget, args)
                    batwidget_t:set_text(args[3] .. " remaining")
                    if args[2] <= 10 and args[1] == "-" then
                       naughty.notify({ text="Battery is low! " .. args[2] .. " percent remaining." })
                    end
                    return args[2] .. "%"
                 end,
                 120,
                 "BAT0")
   return batwidget
end

function wifi_widget()
   local widget = wibox.widget.textbox()
   local widget_t = awful.tooltip({ objects = { widget },})

   vicious.register(widget,
                    vicious.widgets.wifi,
                    function (widget, args)
                       widget_t:set_text(args["{ssid}"])
                       
                       local vpn = awful.util.pread("ifconfig | grep tun0") 
                       if vpn ~= "" then
                          return "VPN"
                       elseif args["{link}"] > 0 then
                          return "ON"
                       else
                          return "OFF"
                       end
                    end,
                    3,
                    "wlp3s0")
   return widget
end

function sound_widget()
   local sound_widget = wibox.widget.textbox()
   set_sound_widget_volume(sound_widget)
   return sound_widget
end

function set_sound_widget_volume(widget)
   widget:set_text(string.sub(awful.util.pread("amixer get Master | grep % | awk '{print $5}'"), 2, -10) .. "%")
end

function seperator_widget()
   local seperator_widget = wibox.widget.textbox()
   seperator_widget:set_text(" | ")
   return seperator_widget
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



-- First check for errors.
check_for_startup_errors()

-- Set the modkey
modkey = "Mod4"

-- Set the theme
beautiful.init("/home/muldvang/.config/awesome/themes/mytheme/theme.lua")

-- Settings for the menubar
menubar.show_categories = false
menubar.cache_entries = true

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {awful.layout.suit.tile,
           awful.layout.suit.max,
           awful.layout.suit.floating,
           awful.layout.suit.tile.bottom,
}

-- Set the wallpaper
gears.wallpaper.maximized(
   '/home/muldvang/pictures/wallpapers/awesome_arch_1280x1024.jpg', 1, true)
gears.wallpaper.maximized(
   '/home/muldvang/pictures/wallpapers/awesome_arch_1920x1080.jpg', 2, true)

-- Define a tag table which hold all screen tags.
local tags = {}
for s = 1, screen.count() do
   tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7 }, s, layouts[2])
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
   local systray = wibox.widget.systray()
   local battery = battery_widget()
   local wifi = wifi_widget()
   sound = sound_widget()
   local clock = clock_widget()
   local seperator = seperator_widget()

   local left_layout = wibox.layout.fixed.horizontal()
   left_layout:add(mainmenu_launcher)
   left_layout:add(taglist[s])
   left_layout:add(promptbox[s])

   local right_layout = wibox.layout.fixed.horizontal()
   right_layout:add(systray)
   right_layout:add(seperator)
   right_layout:add(battery)
   right_layout:add(seperator)
   right_layout:add(wifi)
   right_layout:add(seperator)
   right_layout:add(sound)
   right_layout:add(seperator)
   right_layout:add(clock)
   right_layout:add(seperator)
   right_layout:add(layoutbox[s])

   local layout = wibox.layout.align.horizontal()
   layout:set_left(left_layout)
   layout:set_middle(tasklist[s])
   layout:set_right(right_layout)

   wibox_top[s] = awful.wibox({ position = "top", screen = s })
   wibox_top[s]:set_widget(layout)
end

--------------------------------------------------------------------------------
-- GLOBAL KEY BINDINGS
--------------------------------------------------------------------------------

globalkeys = awful.util.table.join(
   -- Use modkey + F1-F2 to launch most used programs
   spawn_on_keypress({ modkey }, "F1", "emacsclient -c -a=\"\" "),
   spawn_on_keypress({ modkey }, "F2", "firefox"),
   spawn_on_keypress({ modkey }, "F3", "thunar"),
   spawn_on_keypress({ modkey }, "F4", "gmusicbrowser"),

   -- Lock screen
   spawn_on_keypress({ }, "#160", "slimlock"),

   -- Screenshot
   spawn_on_keypress({ }, "#107", "gnome-screenshot --interactive"),

   -- urxvt
   spawn_on_keypress({ modkey }, "Return", "urxvt"),
   
   -- Control gmusicbrowser
   spawn_with_shell_on_keypress({}, "#171",
                                "gmusicbrowser -nolaunch -cmd NextSong"),
   spawn_with_shell_on_keypress({}, "#172",
                                "gmusicbrowser -nolaunch -cmd PlayPause"),
   spawn_with_shell_on_keypress({}, "#173",
                                "gmusicbrowser -nolaunch -cmd PrevSong"),
   spawn_with_shell_on_keypress({}, "#174",
                                "gmusicbrowser -nolaunch -cmd Stop"),

   -- Lock screen when pressing Fn + F2
   awful.key({},
             "#160",
             function ()
                awful.util.spawn("slimlock")
             end ),

      -- Volume down
   awful.key({},
             "#122",
             function ()
                io.popen("amixer set Master 1dB- unmute")
                set_sound_widget_volume(sound)
             end ),

   -- Volume up
   awful.key({},
             "#123",
             function ()
                io.popen("amixer set Master 1dB+ unmute")
                set_sound_widget_volume(sound)
             end ),


   -- Next/previous tag
   awful.key({ modkey }, "u", awful.tag.viewprev),
   awful.key({ modkey }, "i", awful.tag.viewnext),

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
                promptbox:run()
             end),

   -- Show menubar
   awful.key({ modkey }, "p",
             function()
                menubar.show()
             end)
                                  )


-- Compute the maximum number of digit we need, limited to 9
local keynumber = 0
for s = 1, screen.count() do
  keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
  globalkeys = awful.util.table.join(
     globalkeys,
     awful.key({ modkey }, "#" .. i + 9,
               function ()
                  local screen = mouse.screen
                  if tags[screen][i] then
                     awful.tag.viewonly(tags[screen][i])
                  end
               end),
     awful.key({ modkey, "Control" }, "#" .. i + 9,
               function ()
                  local screen = mouse.screen
                  if tags[screen][i] then
                     awful.tag.viewtoggle(tags[screen][i])
                  end
               end),
     awful.key({ modkey, "Shift" }, "#" .. i + 9,
               function ()
                  if client.focus and tags[client.focus.screen][i] then
                     awful.client.movetotag(tags[client.focus.screen][i])
                  end
               end),
     awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
               function ()
                  if client.focus and tags[client.focus.screen][i] then
                     awful.client.toggletag(tags[client.focus.screen][i])
                  end
               end))
end
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

awful.rules.rules = {
  -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    keys = clientkeys,
                    buttons = clientbuttons,
     } },
   { rule = { class = "Gimp-2.8" },
     properties = { floating = true } },
   { rule = { class = "xbmc" },
     properties = { tag = tags[2][1],
                    maximized_horizontal = true,
                    maximized_vertical = true,
                    border_width = 0 } },
   { rule = { class = "Gmusicbrowser" },
     properties = { tag = tags[1][7],
                    border_width = 0
     }
   },
   { rule = { instance = "plugin-container" },
     properties = { floating = true }
   }
}

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
