
# Boxel - ComputerCraft Inventory Manager

A powerful GUI-based inventory management system for ComputerCraft that helps you organize and track items across multiple chests and barrels.

## Overview

Boxel provides a beautiful interface to:
- **Monitor inventory** across all connected storage devices
- **Search for items** quickly and easily
- **Track item locations** down to the specific chest and slot
- **View statistics** about your storage system
- **Configure preferences** for how your inventory is displayed
- **Automatically update** as your inventory changes

Perfect for managing large storage systems in ComputerCraft!

## Installation

### Quick Install

Run this command on your ComputerCraft computer:

```
wget run https://raw.githubusercontent.com/Jerry-Todd/Boxel/refs/heads/main/install.lua
```

The installer will:
1. Download boxel.lua and boxelAPI.lua
2. Install the required Basalt framework (if not already present)
3. Create a startup script for automatic loading
4. Reboot your computer to start Boxel

### Requirements

- **ComputerCraft** (any reasonably recent version)
- **At least one chest or barrel** connected to your computer
- **Advanced Computer or Advanced Turtle** (for the GUI display)

## Getting Started

### Initial Setup

1. Connect at least one chest or barrel to your computer
2. Place a barrel adjacent to the computer (this acts as the interface)
3. Run `boxel` to start the application

The application will automatically detect all connected chests and scan them for items.

### Main Interface

The main menu displays across the top of your screen:

| Button | Function |
|--------|----------|
| **Boxel** | Application title |
| **Search** | Find specific items in your inventory |
| **Info** | View storage statistics and totals |
| **Config** | Customize display preferences |
| **Reload** | Rescan all chests for changes |
| **Quit** | Exit the application |

## Features

### Search
Quickly find items by name. The search function displays:
- Item name
- Total quantity across all storage

### Information Tab
View comprehensive statistics about your storage system:
- Total number of items stored
- Number of chests connected
- Storage efficiency metrics

### Configuration
Customize how items are displayed:
- **Sort Only Mode**: Toggle to display only sorted items
- Settings are automatically saved to `data.dat`

### Auto-Reload
Boxel continuously monitors your chests and updates in real-time when you add or remove items.

## File Structure

- **boxel.lua** - Main application with GUI (requires Basalt)
- **boxelAPI.lua** - Core API for chest management and item tracking
- **install.lua** - Installation and setup script
- **data.dat** - Configuration file (created automatically)
- **basalt.lua** - GUI framework (installed automatically if missing)

## Configuration

Boxel saves your preferences in `data.dat`. The configuration includes:
- Display preferences
- Sort settings

All settings are managed through the GUI config menu.

## Troubleshooting

### "Please connect a barrel"
Boxel requires a barrel to be connected as the main interface. Make sure you have at least one barrel adjacent to your computer.

### Items not appearing
Try using the **Reload** button to rescan all connected chests. This clears the cache and re-reads all items.

### Basalt not found
The installer will automatically fetch Basalt if it's missing. If the automatic install fails, you can install it manually:
```
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua
```

### Chests not detected
Make sure your chests and barrels are connected with adjacent cables or directly adjacent to the computer. Use the Info tab to verify how many chests are detected.

## API Reference

The boxelAPI.lua provides functions for programmatic access to your inventory:

- `M.ItemList()` - Get a list of all items
- `M.CheckChests(onChange)` - Monitor chests for changes and trigger callback
- `M.ClearCache()` - Force a refresh of all chest data

## License

Boxel is open source and available on GitHub at [Jerry-Todd/Boxel](https://github.com/Jerry-Todd/Boxel)

## Support

If you encounter any issues or have feature requests, please visit the GitHub repository.