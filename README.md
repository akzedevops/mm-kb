Myanmar Keyboards
=================

##Introduction

- This package contains two types of Burmese Keyboard, Unicode and ZawGyi-One.

##Installation

### Option 1: Using Pre-built Packages (Recommended)

#### Ubuntu/Debian (.deb package)
```bash
# Download the .deb package from releases
sudo dpkg -i mm-kb_1.0.0-1_all.deb
# Or install dependencies if needed
sudo apt-get install -f
```

#### Fedora/CentOS/RHEL (.rpm package)
```bash
# Download the .rpm package from releases
sudo dnf install mm-kb-1.0.0-1.noarch.rpm
# Or for older systems
sudo yum install mm-kb-1.0.0-1.noarch.rpm
```

### Option 2: Manual Installation from Source

- Type the following command one after another.
```
$ git clone https://github.com/akzedevops/mm-kb.git
$ cd mm-kb
$ sudo make install
$ ibus-daemon -rdx
$ im-config -n ibus
$ gsettings set org.freedesktop.ibus.panel show 0
```

### Option 3: Building Packages from Source

#### Prerequisites
- For Debian/Ubuntu: `sudo apt-get install devscripts build-essential ibus-table`
- For Fedora/CentOS: `sudo dnf install rpm-build rpmdevtools ibus-table`

#### Building packages
```bash
$ git clone https://github.com/akzedevops/mm-kb.git
$ cd mm-kb

# Build Debian package
$ ./build-package.sh deb

# Build RPM package  
$ ./build-package.sh rpm

# Clean build artifacts
$ ./build-package.sh clean
```

For detailed packaging information, see [PACKAGING.md](PACKAGING.md).

### Post-installation Setup

After installation (regardless of method), complete the setup:
Now you can add the keyboard as follow.

- Click on **Text Entry Settings...**
![Text Entry Setting](https://dl.dropboxusercontent.com/u/26716001/Ubuntu/ScreenShots/mm-kb/Ubuntu%2064-bit-2014-10-01-22-11-27.png)

- Click on **"+"** button and search **Burmese** input. You will see Burmese, Burmese (mm-myanmar3), and Burmese (mm-zawgyi).
![input](https://dl.dropboxusercontent.com/u/26716001/Ubuntu/ScreenShots/mm-kb/Ubuntu%2064-bit-2014-10-01-22-12-22.png)

- Add **Burmese (mm-myanmar3)** for ***Unicode*** keyboard and **Burmese (mm-zawgyi)** for ***ZawGyi-One*** keyboard.

- Now you can change keyboard layout by pressing (**Super + Space**) key.

- Whatever you are using, Burmese (mm-myanmar3) or Burmese (mm-zawgyi), you can switch between Burmese and English characters by a single press of **Left Shift** key.

##Changing System Fallback Font

After installation, your system font will be changed into **ZawGyi-One**. If you want to switch to **Unicode** fonts, search **Myanmar Font Switcher** in Unity Dashboard and open it. You can change the font you want in there.

![myanmar-font-switcher](https://dl.dropboxusercontent.com/u/26716001/Ubuntu/ScreenShots/mm-kb/myanmar-font-switcher.png)

![myanmar-font-switcher](https://dl.dropboxusercontent.com/u/26716001/Ubuntu/ScreenShots/mm-kb/Screenshot%20from%202014-10-02%2015%3A07%3A32.png)

##Contact

```
Naing Ye` Minn
naingyeminn@gmail.com
nym@ubuntu-mm.net
FreeNode IRC : yeminn
website : http://nym.ubuntu-mm.net
```
