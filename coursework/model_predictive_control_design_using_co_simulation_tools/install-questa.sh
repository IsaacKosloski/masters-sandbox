#!/usr/bin/env bash
#
# install-questa.sh
# ---------------------------------------------------------------------------
# Installs the free simulator that pairs with Quartus Prime Lite 25.1.
#
# IMPORTANT: "ModelSim - Altera/Intel FPGA Edition" was DISCONTINUED and
# replaced by "Questa - Altera FPGA Starter Edition" starting with Quartus 21.1.
# There is NO ModelSim build for Quartus 25.1 — Questa is its successor and the
# CLI is nearly identical (vsim, vlog, vcom, etc.). This script installs Questa.
#
# Unlike old ModelSim, the free Questa Starter Edition REQUIRES a free license
# file (node-locked to your network card). This script installs the tool, then
# helps you wire up that license. You still have to generate the .dat file once
# from Altera's Self-Service Licensing Center (a web step this script can't do).
#
# Run as your normal user (NOT sudo). It uses sudo only for apt + any lib fixups.
# ---------------------------------------------------------------------------

set -euo pipefail

# ----------------------------- configuration -------------------------------
VERSION="25.1std.0.1129"
INSTALLER="QuestaSetup-${VERSION}-linux.run"
URL="https://downloads.intel.com/akdlm/software/acdsinst/25.1std/1129/ib_installers/${INSTALLER}"
SHA1="149fe1e1cf253f2929804582c6cb658bca941dd5"
DOWNLOAD_DIR="${HOME}/Downloads/quartus"
INSTALL_DIR="${HOME}/intelFPGA_lite/25.1"   # Questa installs a questa_fse/ folder under here
MIN_FREE_GB=12

# ------------------------------- helpers -----------------------------------
c_green='\033[0;32m'; c_yellow='\033[1;33m'; c_red='\033[0;31m'; c_reset='\033[0m'
info()  { echo -e "${c_green}==>${c_reset} $*"; }
warn()  { echo -e "${c_yellow}[!]${c_reset} $*"; }
die()   { echo -e "${c_red}[x] $*${c_reset}" >&2; exit 1; }

# --------------------------- sanity checks ---------------------------------
[[ "${EUID}" -ne 0 ]] || die "Do not run this as root/sudo. Run it as your normal user."
command -v sudo >/dev/null 2>&1 || die "'sudo' is required but not installed."
[[ "$(uname -m)" == "x86_64" ]] || die "Questa requires a 64-bit x86_64 system."

avail_gb="$(df -BG --output=avail "${HOME}" | tail -1 | tr -dc '0-9')"
if [[ -n "${avail_gb}" && "${avail_gb}" -lt "${MIN_FREE_GB}" ]]; then
    warn "Only ${avail_gb} GB free in ${HOME}. Recommend at least ${MIN_FREE_GB} GB. Continuing."
fi

# --------------------- step 1: OS dependencies -----------------------------
info "Installing OS dependencies (needs sudo)..."
sudo dpkg --add-architecture i386
sudo apt-get update -y

# Questa's GUI + FLEXlm licensing bits pull in a few 32-bit libs on Ubuntu.
# Missing packages are skipped rather than aborting the run.
DEPS=(
    wget ca-certificates
    libc6:i386 libstdc++6:i386 lib32ncurses6
    libncurses5:i386 libtinfo5:i386
    libxft2 libxft2:i386 libxext6 libxext6:i386
    libx11-6 libxrender1 libfontconfig1 libsm6 libxi6
)
for pkg in "${DEPS[@]}"; do
    sudo apt-get install -y "${pkg}" 2>/dev/null || warn "Could not install '${pkg}' (skipping)."
done

# Newer Ubuntu dropped libncurses.so.5 / libtinfo.so.5, which some Questa/FLEXlm
# binaries still look for. Create compatibility symlinks from the .so.6 if absent.
ensure_so5_compat() {
    local dir="$1" lib
    for lib in libncurses libtinfo; do
        if [[ -e "${dir}/${lib}.so.6" && ! -e "${dir}/${lib}.so.5" ]]; then
            sudo ln -sf "${dir}/${lib}.so.6" "${dir}/${lib}.so.5" && \
                info "Created ${lib}.so.5 -> .so.6 in ${dir}"
        fi
    done
}
ensure_so5_compat /usr/lib/x86_64-linux-gnu
ensure_so5_compat /usr/lib/i386-linux-gnu
sudo ldconfig || true

# --------------------- step 2: locate (or download) installer --------------
SEARCH_DIRS=(
    "${HOME}/Downloads"
    "${DOWNLOAD_DIR}"
    "$(pwd)"
    "$(dirname "$(readlink -f "$0")")"
)

verify() { echo "${SHA1}  $1" | sha1sum -c --status - 2>/dev/null; }

find_installer() {
    local d f
    for d in "${SEARCH_DIRS[@]}"; do
        if [[ -f "${d}/${INSTALLER}" ]]; then echo "${d}/${INSTALLER}"; return 0; fi
    done
    for d in "${SEARCH_DIRS[@]}"; do
        [[ -d "${d}" ]] || continue
        f="$(ls -t "${d}"/QuestaSetup-*-linux.run 2>/dev/null | head -1 || true)"
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
        warn "Different build than ${VERSION}; skipping checksum, using it as-is."
    fi
else
    warn "No installer found in: ${SEARCH_DIRS[*]}"
    info "Downloading ${INSTALLER} (~3.1 GB) into ${DOWNLOAD_DIR}..."
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
  * When prompted for the component/edition, choose
        "Questa - Altera FPGA Starter Edition"   (this is the FREE one).
    Do NOT pick the full "Questa - Altera FPGA Edition" unless you have a paid seat.
  * Install folder default: ${INSTALL_DIR}
    (Use the SAME base folder as your Quartus install so it sits beside it.)

EOF
read -rp "Press Enter to launch the installer..."

"${INSTALLER_PATH}" --installdir "${INSTALL_DIR}" || die "Installer exited with an error."

# Find the vsim binary (starter edition = questa_fse, full = questa_fe).
VSIM=""
for cand in "${INSTALL_DIR}"/questa_f*/bin/vsim \
            "${HOME}"/intelFPGA_lite/*/questa_f*/bin/vsim \
            /opt/intelFPGA_lite/*/questa_f*/bin/vsim; do
    if [[ -x "${cand}" ]]; then VSIM="${cand}"; break; fi
done
[[ -n "${VSIM}" ]] || die "Could not find vsim after install. Check the installer output."
QUESTA_BIN_DIR="$(dirname "${VSIM}")"
info "Questa installed. vsim is at: ${VSIM}"

# --------------------- step 4: PATH + license env --------------------------
BASHRC="${HOME}/.bashrc"

add_bashrc_line() {   # add a line to ~/.bashrc only if a marker substring is absent
    local marker="$1" line="$2"
    if ! grep -qF "${marker}" "${BASHRC}" 2>/dev/null; then
        printf '\n# Added by install-questa.sh\n%s\n' "${line}" >> "${BASHRC}"
        return 0
    fi
    return 1
}

if add_bashrc_line "${QUESTA_BIN_DIR}" "export PATH=\"\$PATH:${QUESTA_BIN_DIR}\""; then
    info "Added Questa to PATH in ${BASHRC}."
else
    info "Questa PATH entry already present."
fi

# --------------------- step 5: license setup -------------------------------
# Node-locked "NIC ID" that the licensing portal needs = your primary MAC (no colons).
iface="$(ip -o -4 route show to default 2>/dev/null | awk '{print $5; exit}' || true)"
[[ -n "${iface}" ]] || iface="$(ls /sys/class/net 2>/dev/null | grep -v '^lo$' | head -1 || true)"
nic_id="$(tr -d ':' < "/sys/class/net/${iface}/address" 2>/dev/null || true)"

cat <<EOF

--------------------------------------------------------------------------
LICENSE SETUP (required — Questa won't run without it)

Your NIC ID (host ID) for the license portal:
        ${nic_id:-<could not detect — run: ip link>}   (interface: ${iface:-?})

To get the free license:
  1. Go to Altera's Self-Service Licensing Center (SSLC), sign in / register.
  2. Generate a FIXED (node-locked) license for:
        "Questa - FPGA Starter Edition"   (product code SW-QUESTA)
     using the NIC ID above. Enter 1 for the number of seats.
  3. A .dat license file is emailed to you. Save it somewhere permanent,
     e.g.  ${HOME}/altera_licenses/questa.dat
--------------------------------------------------------------------------

EOF

read -rp "If you ALREADY have the .dat license file, paste its full path (or press Enter to skip): " lic_path
if [[ -n "${lic_path}" ]]; then
    lic_path="${lic_path/#\~/$HOME}"
    if [[ -f "${lic_path}" ]]; then
        if add_bashrc_line "LM_LICENSE_FILE=${lic_path}" "export LM_LICENSE_FILE=\"${lic_path}\""; then
            info "Set LM_LICENSE_FILE -> ${lic_path} in ${BASHRC}."
        else
            info "LM_LICENSE_FILE already points there."
        fi
    else
        warn "No file at '${lic_path}'. Skipping — set LM_LICENSE_FILE yourself later:"
        warn "    export LM_LICENSE_FILE=\"/path/to/questa.dat\""
    fi
else
    warn "Skipped license wiring. Once you have the .dat, add to ~/.bashrc:"
    warn "    export LM_LICENSE_FILE=\"/path/to/questa.dat\""
fi

# ------------------------------- done --------------------------------------
cat <<EOF

$(info "Done.")

Next steps:
  1. Open a NEW terminal (or: source ~/.bashrc ) to pick up PATH + license.
  2. Launch the simulator GUI with:   vsim
     (or run it directly: ${VSIM})
  3. Point Quartus at it: Tools > Options > EDA Tool Options, set
     "Questa - Altera FPGA" (or the ModelSim field) to:
        ${QUESTA_BIN_DIR}

If vsim reports a license error, double-check LM_LICENSE_FILE and that the
.dat's NIC ID matches ${nic_id:-your machine's MAC}.

Prefer the OLD ModelSim instead (no license needed)? It only exists for Quartus
<= 20.1 — tell me and I'll adapt this script to that version.
EOF
