Name:           mm-kb
Version:        1.0.0
Release:        1%{?dist}
Summary:        Myanmar keyboard input method for IBus

License:        OFL-1.1
URL:            https://github.com/akzedevops/mm-kb
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  ibus-table
Requires:       ibus-table
Requires:       zenity
Requires:       fontconfig

%description
This package provides Myanmar (Burmese) keyboard input methods for IBus,
supporting both Unicode and ZawGyi-One encodings. It includes:

- IBus table-based Myanmar keyboards
- Collection of Myanmar fonts
- Myanmar font switcher utility with GUI
- Desktop integration for easy font switching

The package enables users to type in Myanmar language using either Unicode
or ZawGyi-One encoding and provides a convenient way to switch between
different Myanmar fonts as the system fallback font.

%prep
%setup -q

%build
# Build ibus table databases
ibus-table-createdb -n mm-myanmar3.db -s src/tables/mm-myanmar3.txt
ibus-table-createdb -n mm-zawgyi.db -s src/tables/mm-zawgyi.txt

%install
rm -rf $RPM_BUILD_ROOT

# Install ibus table databases
install -d $RPM_BUILD_ROOT%{_datadir}/ibus-table/tables
install -m 644 mm-myanmar3.db $RPM_BUILD_ROOT%{_datadir}/ibus-table/tables/
install -m 644 mm-zawgyi.db $RPM_BUILD_ROOT%{_datadir}/ibus-table/tables/

# Install icons
install -d $RPM_BUILD_ROOT%{_datadir}/ibus-table/icons
install -m 644 src/icons/*.svg $RPM_BUILD_ROOT%{_datadir}/ibus-table/icons/

# Install fonts
install -d $RPM_BUILD_ROOT%{_datadir}/fonts/mm
install -m 644 src/fonts/*.ttf $RPM_BUILD_ROOT%{_datadir}/fonts/mm/

# Install Myanmar font switcher
install -d $RPM_BUILD_ROOT%{_datadir}/mmfs
install -m 644 src/mmfs/fonts.conf $RPM_BUILD_ROOT%{_datadir}/mmfs/
install -d $RPM_BUILD_ROOT%{_bindir}
install -m 755 src/mmfs/mmfs $RPM_BUILD_ROOT%{_bindir}/

# Install desktop file
install -d $RPM_BUILD_ROOT%{_datadir}/applications
install -m 644 src/mmfs/myanmar-font-switcher.desktop $RPM_BUILD_ROOT%{_datadir}/applications/

%post
# Update font cache
if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -fv %{_datadir}/fonts/mm || true
fi

# Restart ibus if running
if pgrep -x "ibus-daemon" > /dev/null; then
    echo "Restarting IBus daemon to load new input methods..."
    pkill -x ibus-daemon || true
    sleep 1
    ibus-daemon -drx || true
fi

%postun
if [ $1 -eq 0 ] ; then
    # Update font cache
    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -fv || true
    fi
    
    # Restart ibus if running to unload input methods
    if pgrep -x "ibus-daemon" > /dev/null; then
        echo "Restarting IBus daemon to unload input methods..."
        pkill -x ibus-daemon || true
        sleep 1
        ibus-daemon -drx || true
    fi
fi

%files
%doc README.md
%license OFL-Tharlon.txt
%{_datadir}/ibus-table/tables/mm-myanmar3.db
%{_datadir}/ibus-table/tables/mm-zawgyi.db
%{_datadir}/ibus-table/icons/mm-myanmar3.svg
%{_datadir}/ibus-table/icons/mm-zawgyi.svg
%{_datadir}/fonts/mm/*.ttf
%{_datadir}/mmfs/fonts.conf
%{_bindir}/mmfs
%{_datadir}/applications/myanmar-font-switcher.desktop

%changelog
* Mon Aug 12 2024 Naing Ye Minn <naingyeminn@gmail.com> - 1.0.0-1
- Initial release
- Myanmar keyboard input method for IBus
- Support for Unicode and ZawGyi-One encodings
- Includes Myanmar fonts collection
- Myanmar font switcher utility with GUI