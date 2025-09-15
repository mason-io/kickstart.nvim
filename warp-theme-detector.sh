#!/bin/bash
# Warp Theme Detector for Neovim Integration
# This script helps identify your current Warp theme colors

echo "🎨 Warp Theme Detector for Neovim"
echo "================================="
echo ""

# Function to print colored text
print_color() {
    local color_code=$1
    local text=$2
    printf "\e[${color_code}m${text}\e[0m"
}

# Function to print background colors
print_bg_color() {
    local color_code=$1
    local text=$2
    printf "\e[${color_code}m${text}\e[0m"
}

echo "1. Current Terminal Colors:"
echo "   Normal Colors:"
print_color "30" "■ Black   "; echo ""
print_color "31" "■ Red     "; echo ""
print_color "32" "■ Green   "; echo ""
print_color "33" "■ Yellow  "; echo ""
print_color "34" "■ Blue    "; echo ""
print_color "35" "■ Magenta "; echo ""
print_color "36" "■ Cyan    "; echo ""
print_color "37" "■ White   "; echo ""

echo ""
echo "   Bright Colors:"
print_color "90" "■ Bright Black   "; echo ""
print_color "91" "■ Bright Red     "; echo ""
print_color "92" "■ Bright Green   "; echo ""
print_color "93" "■ Bright Yellow  "; echo ""
print_color "94" "■ Bright Blue    "; echo ""
print_color "95" "■ Bright Magenta "; echo ""
print_color "96" "■ Bright Cyan    "; echo ""
print_color "97" "■ Bright White   "; echo ""

echo ""
echo "2. Background Test:"
print_bg_color "40" "  Black  "; echo ""
print_bg_color "41" "  Red    "; echo ""
print_bg_color "42" "  Green  "; echo ""
print_bg_color "43" "  Yellow "; echo ""
print_bg_color "44" "  Blue   "; echo ""
print_bg_color "45" "  Magenta"; echo ""
print_bg_color "46" "  Cyan   "; echo ""
print_bg_color "47" "  White  "; echo ""

echo ""
echo "3. True Color Test (24-bit):"
printf "RGB Gradient: "
for i in {0..50}; do
    r=$((255 - i * 5))
    g=$((i * 5))
    b=128
    printf "\e[48;2;${r};${g};${b}m "
done
printf "\e[0m\n"

echo ""
echo "4. Warp Theme Information:"
echo "   To find your current Warp theme:"
echo "   1. Open Warp preferences (Cmd+,)"
echo "   2. Go to Appearance → Themes"
echo "   3. Note the selected theme name"
echo ""
echo "   Common Warp themes and their Neovim equivalents:"
echo "   • Warp Dark         → tokyonight-night (transparent)"
echo "   • Warp Light        → tokyonight-day"
echo "   • Dracula           → dracula"
echo "   • One Dark          → onedark"
echo "   • Gruvbox           → gruvbox"
echo "   • Nord              → nord"
echo "   • Catppuccin        → catppuccin"
echo ""

echo "5. Next Steps:"
echo "   1. Note which colors above match your terminal"
echo "   2. Edit lua/custom/plugins/theme.lua"
echo "   3. Uncomment and configure a matching theme"
echo "   4. Restart Neovim to see changes"
echo ""
echo "   For transparent background (recommended):"
echo "   Set 'transparent = true' in your theme config"
echo ""

# Try to detect Warp configuration (if accessible)
if [[ -f "$HOME/.warp/preferences.json" ]]; then
    echo "6. Detected Warp Configuration:"
    if command -v jq &> /dev/null; then
        THEME=$(cat "$HOME/.warp/preferences.json" | jq -r '.theme // "default"')
        echo "   Current theme: $THEME"
    else
        echo "   Found ~/.warp/preferences.json but jq not available"
        echo "   Install jq to auto-detect theme: brew install jq"
    fi
else
    echo "6. Warp preferences not found or not accessible"
fi

echo ""
echo "7. Manual Theme Customization:"
echo "   If none of the presets match perfectly, you can:"
echo "   1. Use transparent mode to inherit terminal colors"
echo "   2. Customize colors in the on_colors() function"
echo "   3. Override specific highlights in on_highlights()"
echo ""