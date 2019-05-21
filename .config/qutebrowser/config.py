# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# List of user stylesheet filenames to use.
# Type: List of File, or File
c.content.user_stylesheets = '~/.config/qutebrowser/userstyle.css'

# Width (in pixels) of the scrollbar in the completion window.
# Type: Int
c.completion.scrollbar.width = 0

# Editor (and arguments) to use for the `open-editor` command. The
# following placeholders are defined: * `{file}`: Filename of the file
# to be edited. * `{line}`: Line in which the caret is found in the
# text. * `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = ['emacsclient', '-c', '{}']

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'never'

# Open a new window for every tab.
# Type: Bool
c.tabs.tabs_are_windows = True

# Search engines which can be used via the address bar. Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` signs. The search engine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': 'https://encrypted.google.com/search?q={}'}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = 'about:blank'

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = '#2e3436'

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#ededed'

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = '#ededed'

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = '#2e3436'

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = '#4a90d9'

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = '#4a90d9'

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = '#4a90d9'

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = '#2e3436'

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = '#a5a5a1'

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.item.selected.border.top = '#a5a5a1'

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = '#a5a5a1'

# Foreground color of the matched text in the completion.
# Type: QssColor
c.colors.completion.match.fg = '#a52a2a'

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = '#2e3436'

# Border used around UI elements in prompts.
# Type: String
c.colors.prompts.border = '0px'

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = '#ededed'

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = '#a5a5a1'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = '#2e3436'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#ededed'

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = '#2e3436'

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = '#ededed'

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = '#ededed'

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = '#2e3436'

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = '#2e3436'

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = '#ededed'

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = '#EDEDED'

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = '#2e3436'

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = '#2e3436'

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = '#2e3436'

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = '#A52A2A'

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = '#0084c8'

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = '#2e3436'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = '#4e9a06'

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = '#ce5c00'

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.monospace = 'monospace'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '9pt input sans compressed'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = 'bold 9pt input sans compressed'

# Font used for the downloadbar.
# Type: Font
c.fonts.downloads = '9pt input sans compressed'

# Font used for error messages.
# Type: Font
c.fonts.messages.error = '9pt input sans compressed'

# Font used for info messages.
# Type: Font
c.fonts.messages.info = '9pt input sans compressed'

# Font used for warning messages.
# Type: Font
c.fonts.messages.warning = '9pt input sans compressed'

# Font used for prompts.
# Type: Font
c.fonts.prompts = '9pt sans'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '9pt input sans compressed'

c.fonts.hints = 'bold 10pt input mono'
c.fonts.keyhint = 'bold 10pt input mono'
