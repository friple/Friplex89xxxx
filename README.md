# Roblox AI Panel

A visually appealing AI panel for Roblox games with Auto Grab functionality.

## Features

### 1. Auto Grab Functionality
- Automatically interacts with nearby objects within a 5-stud radius
- Real-time UI feedback showing "ON" or "OFF" state
- Uses `firetouchinterest` mechanism to process BasePart objects
- Fail-safe implementation with error handling

### 2. Close Button
- Hides the panel when clicked (doesn't destroy it)
- Can be re-enabled by setting `ScreenGui.Enabled = true`

### 3. Beautiful and Compact Design
- Modern design with rounded corners
- Gradient background for visual appeal
- 300x200 pixel compact panel
- Professional color scheme

## Implementation Details

### Panel Layout
- **Main Frame**: 300x200 pixels, centered on screen
- **Title**: "AI Panel Functions" at the top
- **Auto Grab Button**: Toggle button with visual feedback
- **Close Button**: Red button to hide the panel

### Design Elements
- **Rounded Corners**: 12px radius on main frame, 8px on buttons
- **Gradient Background**: 45° diagonal gradient from dark to darker gray
- **Color Scheme**:
  - Background: Dark gray (RGB 25, 25, 25)
  - Auto Grab OFF: Blue (RGB 45, 140, 200)
  - Auto Grab ON: Green (RGB 50, 200, 100)
  - Close Button: Red (RGB 200, 50, 50)

### Auto Grab Logic
- Runs in the `RenderStepped` loop when enabled
- Scans all direct children of Workspace
- Interacts with objects that:
  - Are BasePart instances (or descendants)
  - Are within 5 studs of the player's HumanoidRootPart
- Uses `pcall` to prevent error spam
- Properly disconnects connection when toggled off

### Fail-Safe Features
- **No Duplicate Connections**: Previous connection is disconnected before creating a new one
- **Error Protection**: `pcall` wraps `firetouchinterest` to prevent crashes
- **Nil Checks**: Validates character and HumanoidRootPart exist before use
- **Clean Disconnection**: Properly cleans up RenderStepped connection when disabled

## Installation

1. Copy the contents of `AI_Panel.lua`
2. In Roblox Studio, insert a **LocalScript** in `StarterPlayer > StarterPlayerScripts`
3. Paste the code into the LocalScript
4. Run the game to see the panel

## Usage

1. **Enable Auto Grab**: Click the "Auto Grab: OFF" button to turn it on
2. **Move Near Objects**: Walk within 5 studs of BaseParts in the Workspace
3. **Disable Auto Grab**: Click the "Auto Grab: ON" button to turn it off
4. **Close Panel**: Click the "Close" button to hide the panel

## Technical Requirements

- Roblox LocalScript environment
- PlayerGui access
- RunService access for RenderStepped
- (Optional) firetouchinterest function for full functionality

## Notes

- The `firetouchinterest` function is typically only available in exploit environments
- In standard Roblox Studio/Game, this function may not exist, but the script will still run without errors
- The panel can be reopened programmatically by setting `game.Players.LocalPlayer.PlayerGui.AIPanelUI.Enabled = true`

## Code Structure

```
AI_Panel.lua
├── UI Creation
│   ├── ScreenGui
│   ├── Frame (Main Panel)
│   ├── AutoGrabButton
│   ├── CloseButton
│   └── StatusLabel
├── Styling
│   ├── Rounded Corners (UICorner)
│   └── Gradient (UIGradient)
└── Logic
    ├── Auto Grab Toggle
    ├── RenderStepped Loop
    └── Close Panel Handler
```

## License

This is a demonstration project for educational purposes.
