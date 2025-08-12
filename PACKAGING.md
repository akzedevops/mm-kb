# Myanmar Keyboard Package - Packaging Guide

This document provides information about building and distributing packages for the Myanmar keyboard input method.

## Package Contents

The `mm-kb` package includes:

- **IBus table databases**: `mm-myanmar3.db` and `mm-zawgyi.db` for Unicode and ZawGyi-One input methods
- **Icons**: SVG icons for the input methods in IBus
- **Fonts**: Collection of 8 Myanmar fonts (NotoSansMyanmar, Ours-Unicode, Tharlon, ZawGyi-One, etc.)
- **Font switcher**: GUI utility (`mmfs`) for changing system fallback font
- **Desktop integration**: Application launcher for the font switcher

## Supported Platforms

### Debian/Ubuntu (.deb)
- All Debian-based distributions
- Tested on Ubuntu 18.04+ and Debian 9+
- Dependencies: `ibus-table`, `zenity`, `fontconfig`

### Fedora/CentOS/RHEL (.rpm)
- Fedora 30+
- CentOS 8+
- RHEL 8+
- Dependencies: `ibus-table`, `zenity`, `fontconfig`

## Building Packages

### Prerequisites

#### For Debian/Ubuntu:
```bash
sudo apt-get install devscripts build-essential ibus-table
```

#### For Fedora/CentOS/RHEL:
```bash
sudo dnf install rpm-build rpmdevtools ibus-table
# or for older systems:
sudo yum install rpm-build rpmdevtools ibus-table
```

### Build Commands

Use the provided build script:

```bash
# Build Debian package
./build-package.sh deb

# Build RPM package
./build-package.sh rpm

# Build with custom version
./build-package.sh -v 1.0.1 deb

# Clean build artifacts
./build-package.sh clean
```

### Manual Building

#### Debian Package:
```bash
debuild -us -uc -b
```

#### RPM Package:
```bash
# Setup RPM build environment
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

# Create source tarball
tar --exclude='.git' --exclude='debian' --exclude='*.rpm' --exclude='*.deb' \
    -czf ~/rpmbuild/SOURCES/mm-kb-1.0.0.tar.gz \
    --transform "s,^,mm-kb-1.0.0/," .

# Copy spec file
cp mm-kb.spec ~/rpmbuild/SPECS/

# Build package
rpmbuild -ba ~/rpmbuild/SPECS/mm-kb.spec
```

## Package Installation

### Debian/Ubuntu:
```bash
sudo dpkg -i mm-kb_1.0.0-1_all.deb
sudo apt-get install -f  # if dependencies are missing
```

### Fedora/CentOS/RHEL:
```bash
sudo dnf install mm-kb-1.0.0-1.noarch.rpm
# or
sudo yum install mm-kb-1.0.0-1.noarch.rpm
```

## Package Validation

After installation, verify the package:

```bash
./validate-package.sh
```

This script checks:
- IBus table databases are installed
- Icons are in place
- Fonts are accessible
- Myanmar font switcher is executable
- All dependencies are available

## Post-Installation Setup

1. **Restart IBus**: `ibus-daemon -rdx`
2. **Configure input method**: `im-config -n ibus`
3. **Add keyboards**: Use your desktop environment's keyboard settings to add "Burmese (mm-myanmar3)" for Unicode and "Burmese (mm-zawgyi)" for ZawGyi-One
4. **Font switching**: Launch "Myanmar Font Switcher" from applications menu

## File Locations

After installation, files are placed in:

- `/usr/share/ibus-table/tables/` - Input method databases
- `/usr/share/ibus-table/icons/` - Input method icons
- `/usr/share/fonts/mm/` - Myanmar fonts
- `/usr/share/mmfs/` - Font switcher configuration
- `/usr/bin/mmfs` - Font switcher executable
- `/usr/share/applications/` - Desktop application file

## Troubleshooting

### IBus not recognizing input methods
- Restart IBus daemon: `ibus-daemon -rdx`
- Check IBus engines: `ibus list-engine | grep mm`

### Font switcher not working
- Ensure zenity is installed: `zenity --version`
- Check executable permissions: `ls -la /usr/bin/mmfs`

### Fonts not appearing
- Update font cache: `sudo fc-cache -fv`
- Check font directory: `ls -la /usr/share/fonts/mm/`