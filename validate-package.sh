#!/bin/bash
# Package validation script for mm-kb

set -e

echo "=== Myanmar Keyboard Package Validation ==="
echo

# Check if ibus table databases exist
echo "Checking IBus table databases..."
if [ -f "/usr/share/ibus-table/tables/mm-myanmar3.db" ]; then
    echo "✓ mm-myanmar3.db found"
else
    echo "✗ mm-myanmar3.db missing"
    exit 1
fi

if [ -f "/usr/share/ibus-table/tables/mm-zawgyi.db" ]; then
    echo "✓ mm-zawgyi.db found"
else
    echo "✗ mm-zawgyi.db missing"
    exit 1
fi

# Check if icons exist
echo "Checking IBus icons..."
if [ -f "/usr/share/ibus-table/icons/mm-myanmar3.svg" ]; then
    echo "✓ mm-myanmar3.svg found"
else
    echo "✗ mm-myanmar3.svg missing"
    exit 1
fi

if [ -f "/usr/share/ibus-table/icons/mm-zawgyi.svg" ]; then
    echo "✓ mm-zawgyi.svg found"
else
    echo "✗ mm-zawgyi.svg missing"
    exit 1
fi

# Check if fonts exist
echo "Checking Myanmar fonts..."
FONT_COUNT=$(find /usr/share/fonts/mm -name "*.ttf" 2>/dev/null | wc -l)
if [ "$FONT_COUNT" -gt 0 ]; then
    echo "✓ Found $FONT_COUNT Myanmar fonts"
else
    echo "✗ No Myanmar fonts found"
    exit 1
fi

# Check if Myanmar font switcher exists
echo "Checking Myanmar font switcher..."
if [ -x "/usr/bin/mmfs" ]; then
    echo "✓ mmfs executable found"
else
    echo "✗ mmfs executable missing"
    exit 1
fi

if [ -f "/usr/share/mmfs/fonts.conf" ]; then
    echo "✓ fonts.conf found"
else
    echo "✗ fonts.conf missing"
    exit 1
fi

if [ -f "/usr/share/applications/myanmar-font-switcher.desktop" ]; then
    echo "✓ myanmar-font-switcher.desktop found"
else
    echo "✗ myanmar-font-switcher.desktop missing"
    exit 1
fi

# Check if IBus can see the input methods
echo "Checking IBus input methods..."
if command -v ibus >/dev/null 2>&1; then
    # Note: This requires ibus-daemon to be running
    echo "  IBus is available - input methods should be accessible"
    echo "  Run 'ibus list-engine' to see available input methods"
else
    echo "  Warning: IBus not found - this is expected on minimal systems"
fi

# Check if zenity is available for font switcher GUI
echo "Checking GUI dependencies..."
if command -v zenity >/dev/null 2>&1; then
    echo "✓ zenity found - font switcher GUI available"
else
    echo "✗ zenity missing - font switcher GUI will not work"
    exit 1
fi

# Check if fc-cache is available for font management
if command -v fc-cache >/dev/null 2>&1; then
    echo "✓ fc-cache found - font cache management available"
else
    echo "✗ fc-cache missing - font cache management not available"
    exit 1
fi

echo
echo "=== Validation Complete ==="
echo "✓ All package components are correctly installed"
echo
echo "Next steps:"
echo "1. Restart IBus: ibus-daemon -rdx"
echo "2. Configure input method: im-config -n ibus"
echo "3. Add Myanmar keyboards in your desktop environment"
echo "4. Use Myanmar Font Switcher from applications menu"