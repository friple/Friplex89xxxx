# Roblox Brainrot Stealer - Enhanced AI Panel

An advanced, feature-rich AI panel for the Roblox "Steal a Brainrot" game mode with ESP, speed control, and intelligent auto-grab capabilities.

## 🎮 Features

### 1. ⚡ Enhanced Auto Grab
- Automatically collects brainrot items from other players' bases
- Simulates E button press for natural interaction
- Multi-method collection system:
  - ProximityPrompt triggering (primary method)
  - ClickDetector activation
  - Touch event simulation
- 10-stud detection radius for reliable collection
- Works on all interactable objects in the game

### 2. 👁️ ESP/Wallhack System
- Toggle-able ESP showing bases and items through walls
- Displays real-time information:
  - 🏠 Base type identification
  - ⏱️ Timer countdowns
  - 🟢 Open/🔴 Closed status for friend access
- Visual highlighting with colored boxes:
  - Green for accessible bases
  - Red for restricted bases
  - Gold for brainrot items
- Auto-refreshing every second for performance

### 3. 🏃 Speed Control
- Adjustable speed slider (16-30 WalkSpeed)
- Real-time value display
- Continuous application works even while holding brainrot
- Smooth, draggable slider interface
- Persists across respawns

### 4. 🎨 Beautiful Modern Design
- Large 350×350px panel with room for all features
- Stunning gradient backgrounds with glow effects
- Rounded corners and modern aesthetics
- Professional dark theme (blue/purple)
- Smooth animations and transitions
- Emoji icons for visual clarity

### 5. 🔧 Quality of Life
- **Draggable Panel**: Click and drag to reposition
- **Hotkey Support**: Press INSERT to toggle panel
- **Smart Cleanup**: Automatically cleans up when closing
- **Persistent**: Panel survives character respawns
- **Safe**: All exploit functions wrapped in error protection

## 📦 Installation

1. Copy the contents of `AI_Panel.lua`
2. In Roblox Studio or executor, create a LocalScript
3. Paste the code into the LocalScript
4. For Studio: Place in `StarterPlayer > StarterPlayerScripts`
5. For executor: Run the script
6. Press INSERT to toggle the panel

## 🎯 Usage Guide

### Getting Started
1. Press **INSERT** key to open the panel
2. Panel appears centered and can be dragged anywhere
3. Toggle features on/off with buttons

### Auto Grab Feature
- **OFF State**: Button shows "⚡ Auto Grab: OFF" in gray
- **ON State**: Button shows "⚡ Auto Grab: ON" in green
- Automatically approaches and collects brainrot items
- Works within 10 studs of your character
- No need to press E manually!

### ESP Feature
- **OFF State**: Button shows "👁️ Base ESP: OFF" in gray
- **ON State**: Button shows "👁️ Base ESP: ON" in green
- See all bases and items through walls
- Color-coded status indicators
- Automatic information updates

### Speed Control
- Drag the white slider button left or right
- See real-time speed value (16-30)
- Speed applies immediately
- Works while holding items
- Perfect for quick getaways!

### Closing Panel
- Click "❌ Close Panel" button to hide
- Press INSERT anytime to reopen
- All active features are safely disabled when closing

## 🔑 Keybinds

| Key | Action |
|-----|--------|
| **INSERT** | Toggle panel visibility |
| **Left Mouse** | Drag panel / Click buttons / Move slider |

## 🎨 UI Overview

```
┌─────────────────────────────────┐
│    🧠 BRAINROT STEALER 🧠       │
├─────────────────────────────────┤
│  ⚡ Auto Grab: OFF/ON            │
│  👁️ Base ESP: OFF/ON            │
│                                  │
│  🏃 Speed Control         [16]  │
│  ●─────────────────────────○    │
│                                  │
│       ❌ Close Panel            │
└─────────────────────────────────┘
```

## ⚙️ Technical Details

### Auto Grab System
- Scans all workspace descendants every frame
- Prioritizes ProximityPrompts (E button simulation)
- Falls back to ClickDetectors if needed
- Uses touch events as final method
- All methods protected with pcall

### ESP Implementation
- BillboardGui for text labels
- Highlight objects for wall visibility
- Searches for base Models with specific attributes
- Color-codes based on accessibility
- Updates every 1 second (60 FPS friendly)

### Speed System
- Modifies Humanoid.WalkSpeed directly
- Heartbeat loop ensures consistency
- Overrides game speed restrictions
- Range: 16 (default) to 30 (fast)

### UI Framework
- Pure Lua implementation
- No external dependencies
- Frame-based layout system
- Event-driven architecture
- Memory-efficient design

## 🛡️ Safety Features

- **Error Protection**: All exploit functions wrapped in pcall
- **Nil Checks**: Validates character and objects exist
- **Connection Cleanup**: Prevents memory leaks
- **Safe Defaults**: Panel starts with all features OFF
- **Graceful Failures**: Script continues even if features fail

## 🎮 Game Compatibility

Designed specifically for **"Steal a Brainrot"** Roblox game mode:
- Detects bases automatically
- Finds brainrot items in workspace
- Adapts to different base structures
- Works with various game versions

## 📊 Performance

- **CPU Usage**: Low (optimized scan loops)
- **Memory**: Minimal footprint
- **Network**: No remote calls required
- **FPS Impact**: Negligible with proper optimization

## 🐛 Troubleshooting

**Panel won't appear:**
- Press INSERT key
- Check if script executed successfully
- Look for console message: "🧠 Brainrot Stealer loaded!"

**Auto Grab not working:**
- Make sure you're within 10 studs of items
- Check if items have ProximityPrompt or ClickDetector
- Some items may require specific game conditions

**ESP not showing bases:**
- Verify bases exist in workspace
- Check if base Models have proper structure
- Try toggling ESP off and on again

**Speed not applying:**
- Check if game has speed restrictions
- Try adjusting slider again
- Some games may override speed frequently

## 📝 Notes

- This script requires an executor that supports exploit functions
- Functions used: `fireproximityprompt`, `fireclickdetector`, `firetouchinterest`
- Works best in games without strong anti-cheat
- For educational purposes only

## 🔄 Version History

- **v2.0** (Current): Full enhancement with ESP, speed, and multi-method grab
- **v1.0**: Basic auto grab functionality

## 📜 License

This is a demonstration project for educational purposes.

## 🙏 Credits

Created for the "Steal a Brainrot" Roblox community
Enhanced with advanced features and modern UI design
