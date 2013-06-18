---------------------------
-- Default awesome theme --
---------------------------

-- Color palette
local background   = "#262626"
local foreground   = "#FFFFFF"

local dark_black   = "#000000"
local light_black  = "#666666"

local dark_red     = "#ff0087"
local light_red    = "#ff5faf"

local dark_green   = "#5fd700"
local light_green  = "#87ff00"

local dark_yellow  = "#d7d700"
local light_yellow = "#d7ff5f"

local dark_blue    = "#005fff"
local light_blue   = "#00afff"

local dark_purple  = "#af00d7"
local light_purple = "#d75fd7"

local dark_cyan    = "#00d7ff"
local light_cyan   = "#5fffff"

local dark_white   = "#DDDDDD"
local light_white  = "#FFFFFF"


theme = {}

theme.font_tags     = "DejaVuSans 8"
theme.font          = "DejaVuSans 8"

theme.bg_normal     = background
theme.bg_focus      = light_blue
theme.bg_urgent     = background
theme.bg_minimize   = background
theme.bg_systray    = background

theme.fg_normal     = light_white
theme.fg_focus      = background
theme.fg_urgent     = light_red
theme.fg_minimize   = dark_blue

theme.border_width  = 1
theme.border_normal = background
theme.border_focus  = light_blue
theme.border_marked = light_red

theme.taglist_bg_focus = dark_green
theme.tooltip_fg_color = light_blue

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/mytheme/taglist/squarefz.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/mytheme/taglist/squarez.png"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
