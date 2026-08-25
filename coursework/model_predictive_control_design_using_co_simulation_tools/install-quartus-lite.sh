#!/usr/bin/env bash
#
# install-quartus-lite.sh
# ---------------------------------------------------------------------------
# Installs Intel/Altera Quartus Prime Lite Edition 25.1 on Ubuntu.
#
# What this script does:
#   1. Checks basic prerequisites (64-bit CPU, disk space, sudo).
#   2. Installs the OS libraries Quartus + the USB-Blaster driver need.
#   3. Downloads the official installer and verifies its SHA1 checksum.
#   4. Launches the installer GUI (you pick install dir + your device family).
#   5. Installs udev rules so the USB-Blaster / USB-Blaster II works without root.
#   6. Adds Quartus to your PATH.
#
# Note on Ubuntu 26.04: Quartus 25.1's officially *supported* Linux is up to
# Ubuntu 24.04 LTS. 26.04 normally works fine, but it is newer than Intel/Altera's
# tested matrix, so if you hit an odd runtime issue, that is the likely reason.
#
# Run it as your normal user (NOT with sudo). It will ask for your password
# only for the steps that genuinely need root (apt + udev rules).
# ---------------------------------------------------------------------------

set -euo pipefail

# ----------------------------- configuration -------------------------------
VERSION="25.1std.0.1129"
INSTALLER="QuartusLiteSetup-${VERSION}-linux.run"
URL="https://downloads.intel.com/akdlm/software/acdsinst/25.1std/1129/ib_installers/${INSTALLER}"
SHA1="ce0773469eacab5b7035c175484625f4ec3737d1"
DOWNLOAD_DIR="${HOME}/Downloads/quartus"
INSTALL_DIR="${HOME}/intelFPGA_lite/25.1"   # default target; you can change it in the GUI
MIN_FREE_GB=20                              # rough space needed for installer + 1 device family

# ------------------------------- helpers -----------------------------------
c_green='\033[0;32m'; c_yellow='\033[1;33m'; c_red='\033[0;31m'; c_reset='\033[0m'
info()  { echo -e "${c_green}==>${c_reset} $*"; }
warn()  { echo -e "${c_yellow}[!]${c_reset} $*"; }
die()   { echo -e "${c_red}[x] $*${c_reset}" >&2; exit 1; }

# --------------------------- sanity checks ---------------------------------
[[ "${EUID}" -ne 0 ]] || die "Do not run this script as root/sudo. Run it as your normal user."
command -v sudo >/dev/null 2>&1 || die "'sudo' is required but not installed."
[[ "$(uname -m)" == "x86_64" ]] || die "Quartus requires a 64-bit x86_64 system (found $(uname -m))."

# Warn (don't hard-fail) if free space looks tight.
avail_gb="$(df -BG --output=avail "${HOME}" | tail -1 | tr -dc '0-9')"
if [[ -n "${avail_gb}" && "${avail_gb}" -lt "${MIN_FREE_GB}" ]]; then
    warn "Only ${avail_gb} GB free in ${HOME}. Recommend at least ${MIN_FREE_GB} GB. Continuing anyway."
fi

# --------------------- step 1: OS dependencies -----------------------------
info "Installing OS dependencies (needs sudo)..."
sudo dpkg --add-architecture i386      # required for the original USB-Blaster driver (libudev1:i386)
sudo apt-get update -y

# The GUI installer bundles most of its own Qt libs; these cover the common gaps
# on a desktop Ubuntu plus the USB-Blaster JTAG driver. Missing packages are
# skipped rather than aborting the whole run.
DEPS=(
    wget ca-certificates
    libc6:i386 libudev1:i386          # USB-Blaster (device 09fb:6001) needs 32-bit libudev
    libfontconfig1 libx11-6 libxext6 libxrender1 libxft2
    libxtst6 libxi6 libsm6 libglib2.0-0
)
for pkg in "${DEPS[@]}"; do
    sudo apt-get install -y "${pkg}" 2>/dev/null || warn "Could not install '${pkg}' (skipping)."
done

# --------------------- step 2: locate (or download) installer --------------
# Look for an installer you already have before downloading anything.
SEARCH_DIRS=(
    "${HOME}/Downloads"
    "${DOWNLOAD_DIR}"
    "$(pwd)"
    "$(dirname "$(readlink -f "$0")")"
)

verify() { echo "${SHA1}  $1" | sha1sum -c --status - 2>/dev/null; }

find_installer() {
    local d f
    # 1) exact expected filename
    for d in "${SEARCH_DIRS[@]}"; do
        if [[ -f "${d}/${INSTALLER}" ]]; then echo "${d}/${INSTALLER}"; return 0; fi
    done
    # 2) any Quartus Lite .run (newest first) in case you have a different build
    for d in "${SEARCH_DIRS[@]}"; do
        [[ -d "${d}" ]] || continue
        f="$(ls -t "${d}"/QuartusLiteSetup-*-linux.run 2>/dev/null | head -1 || true)"
        if [[ -n "${f}" ]]; then echo "${f}"; return 0; fi
    done
    return 1
}

INSTALLER_PATH="$(find_installer || true)"

if [[ -n "${INSTALLER_PATH}" ]]; then
    info "Found installer: ${INSTALLER_PATH}"
    if [[ "$(basename "${INSTALLER_PATH}")" == "${INSTALLER}" ]]; then
        info "Verifying checksum..."
        if verify "${INSTALLER_PATH}"; then
            info "Checksum OK."
        else
            warn "Checksum does NOT match the expected ${VERSION} build."
            read -rp "Use this file anyway? [y/N] " ans
            [[ "${ans,,}" == "y" ]] || die "Aborted. Replace the file and re-run."
        fi
    else
        warn "This is a different build than ${VERSION}; skipping checksum, using it as-is."
    fi
else
    warn "No installer found in: ${SEARCH_DIRS[*]}"
    info "Downloading ${INSTALLER} (~1.8 GB) into ${DOWNLOAD_DIR}..."
    mkdir -p "${DOWNLOAD_DIR}"
    INSTALLER_PATH="${DOWNLOAD_DIR}/${INSTALLER}"
    wget -c "${URL}" -O "${INSTALLER_PATH}" || die "Download failed. Check your connection and re-run."
    info "Verifying checksum..."
    if ! verify "${INSTALLER_PATH}"; then
        rm -f "${INSTALLER_PATH}"
        die "Checksum mismatch — the file was removed. Re-run to download again."
    fi
fi
chmod +x "${INSTALLER_PATH}"

# --------------------- step 3: run the installer ---------------------------
cat <<EOF

$(basename "${INSTALLER_PATH}") is ready. The graphical installer will now open.

In the installer:
  * Keep or change the install folder (default: ${INSTALL_DIR}).
  * Under "Devices", tick the family for YOUR board, e.g.:
        - MAX 10        -> DE10-Lite
        - Cyclone V     -> DE1-SoC / DE10-Standard / DE10-Nano
        - Cyclone IV E  -> DE2-115 / DE0
    Any family you tick that isn't bundled is downloaded automatically.
  * You can untick Questa/ModelSim if you don't need simulation (saves space).

EOF
read -rp "Press Enter to launch the installer..."

"${INSTALLER_PATH}" --installdir "${INSTALL_DIR}" || die "Installer exited with an error."

# Detect where Quartus actually landed (in case you changed the folder).
QUARTUS_BIN=""
for cand in "${INSTALL_DIR}/quartus/bin/quartus" \
            "${HOME}"/intelFPGA_lite/*/quartus/bin/quartus \
            /opt/intelFPGA_lite/*/quartus/bin/quartus; do
    if [[ -x "${cand}" ]]; then QUARTUS_BIN="${cand}"; break; fi
done
[[ -n "${QUARTUS_BIN}" ]] || die "Could not find the quartus binary after install. Nothing else to configure."
QUARTUS_DIR="$(dirname "$(dirname "${QUARTUS_BIN}")")"   # .../quartus

# --------------------- step 4: USB-Blaster udev rules ----------------------
info "Installing USB-Blaster udev rules (needs sudo)..."
sudo tee /etc/udev/rules.d/51-usbblaster.rules >/dev/null <<'RULES'
# Intel/Altera USB-Blaster
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
# Intel/Altera USB-Blaster II
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
RULES
sudo udevadm control --reload-rules && sudo udevadm trigger

# --------------------- step 5: add Quartus to PATH -------------------------
BASHRC="${HOME}/.bashrc"
PATH_LINE="export PATH=\"\$PATH:${QUARTUS_DIR}/bin\""
if ! grep -qF "${QUARTUS_DIR}/bin" "${BASHRC}" 2>/dev/null; then
    {
        echo ""
        echo "# Added by install-quartus-lite.sh"
        echo "${PATH_LINE}"
    } >> "${BASHRC}"
    info "Added Quartus to PATH in ${BASHRC}."
else
    info "Quartus PATH entry already present in ${BASHRC}."
fi

# ------------------------------- done --------------------------------------
cat <<EOF

$(info "Done.")

Quartus Prime Lite ${VERSION%std*} is installed at:
    ${QUARTUS_DIR%/quartus}

Next steps:
  1. Open a NEW terminal (or run:  source ~/.bashrc ) to pick up the PATH.
  2. Launch the GUI with:          quartus
  3. If you use the original USB-Blaster, unplug and replug it now so the new
     udev rule applies. Check the board is seen with:   jtagconfig

If 'quartus' isn't found, run it directly:
    ${QUARTUS_BIN}
EOF
