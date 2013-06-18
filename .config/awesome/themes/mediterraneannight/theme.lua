---------------------------
-- Default awesome theme --
---------------------------

-- Color palette

local dark_gray = "#282828"
local light_gray = "#EAEAEA"
local blue = "#4D6E92"
local white = "#FCFCFC"

theme = {}

theme.font_tags     = "DejaVuSansMono 8"
theme.font          = "DejaVuSansMono 8"

theme.bg_normal     = dark_gray
theme.bg_focus      = light_gray
theme.bg_urgent     = dark_gray
theme.bg_minimize   = dark_gray
theme.bg_systray    = dark_gray

theme.fg_normal     = white
theme.fg_focus      = dark_gray
theme.fg_urgent     = white
theme.fg_minimize   = white

theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = blue
theme.border_marked = dark_gray

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


--theme.wallpaper = "/home/muldvang/pictures/wallpapers/Archlinux_Wallpaper_1680x1050_3691.jpg"
theme.wallpaper = "/home/muldvang/pictures/wallpapers/awesome_arch_1280x1024.jpg"

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
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
