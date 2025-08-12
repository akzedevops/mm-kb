#!/bin/bash
# Package building script for mm-kb

set -e

PACKAGE_NAME="mm-kb"
VERSION="1.0.0"

show_help() {
    echo "Usage: $0 [OPTIONS] COMMAND"
    echo ""
    echo "Commands:"
    echo "  deb       Build Debian package"
    echo "  rpm       Build RPM package"
    echo "  clean     Clean build artifacts"
    echo "  help      Show this help"
    echo ""
    echo "Options:"
    echo "  -v, --version VERSION    Set package version (default: $VERSION)"
    echo ""
    echo "Examples:"
    echo "  $0 deb                   Build .deb package"
    echo "  $0 rpm                   Build .rpm package"
    echo "  $0 -v 1.0.1 deb         Build .deb package with version 1.0.1"
}

build_deb() {
    echo "Building Debian package..."
    
    # Check if debhelper is available
    if ! command -v debuild >/dev/null 2>&1; then
        echo "Error: debuild not found. Install devscripts package:"
        echo "  sudo apt-get install devscripts build-essential"
        exit 1
    fi
    
    # Check if ibus-table is available
    if ! command -v ibus-table-createdb >/dev/null 2>&1; then
        echo "Error: ibus-table-createdb not found. Install ibus-table package:"
        echo "  sudo apt-get install ibus-table"
        exit 1
    fi
    
    # Build the package
    debuild -us -uc -b
    
    echo "Debian package built successfully!"
    echo "Package files are in the parent directory."
}

build_rpm() {
    echo "Building RPM package..."
    
    # Check if rpmbuild is available
    if ! command -v rpmbuild >/dev/null 2>&1; then
        echo "Error: rpmbuild not found. Install rpm-build package:"
        echo "  sudo dnf install rpm-build rpmdevtools"
        echo "  or"
        echo "  sudo yum install rpm-build rpmdevtools"
        exit 1
    fi
    
    # Check if ibus-table is available
    if ! command -v ibus-table-createdb >/dev/null 2>&1; then
        echo "Error: ibus-table-createdb not found. Install ibus-table package:"
        echo "  sudo dnf install ibus-table"
        echo "  or"
        echo "  sudo yum install ibus-table"
        exit 1
    fi
    
    # Setup RPM build environment
    mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
    
    # Create source tarball
    TARBALL="${PACKAGE_NAME}-${VERSION}.tar.gz"
    tar --exclude='.git' --exclude='debian' --exclude='*.rpm' --exclude='*.deb' \
        -czf ~/rpmbuild/SOURCES/$TARBALL \
        --transform "s,^,${PACKAGE_NAME}-${VERSION}/," \
        .
    
    # Copy spec file
    cp ${PACKAGE_NAME}.spec ~/rpmbuild/SPECS/
    
    # Build the package
    rpmbuild -ba ~/rpmbuild/SPECS/${PACKAGE_NAME}.spec
    
    echo "RPM package built successfully!"
    echo "Package files are in ~/rpmbuild/RPMS/"
}

clean_build() {
    echo "Cleaning build artifacts..."
    rm -f *.deb *.rpm *.tar.gz *.dsc *.changes *.build *.buildinfo
    rm -f mm-myanmar3.db mm-zawgyi.db
    echo "Clean completed."
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--version)
            VERSION="$2"
            shift 2
            ;;
        deb)
            build_deb
            exit 0
            ;;
        rpm)
            build_rpm
            exit 0
            ;;
        clean)
            clean_build
            exit 0
            ;;
        help|--help|-h)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# If no command provided, show help
show_help