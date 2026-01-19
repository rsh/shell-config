config.load_autoconfig()

config.bind('td', 'config-cycle colors.webpage.darkmode.enabled true false')

# Device-specific settings (e.g., GPD Pocket 3)
try:
    config.source('gpd.py')
except FileNotFoundError:
    pass
