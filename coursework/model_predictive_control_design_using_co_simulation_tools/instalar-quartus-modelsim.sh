#!/usr/bin/env bash
#
# instalar-quartus-modelsim.sh
# ---------------------------------------------------------------------------
# Instala Quartus Prime Lite 20.1.1 + ModelSim-Intel FPGA Starter Edition
# no Ubuntu (testado como alvo: 26.04).
#
# Por que a 20.1.1? E' a ultima versao com o ModelSim "de verdade", que NAO
# exige licenca. Nas versoes 21.1+ o simulador virou Questa (exige licenca).
#
# Um instalador so: o QuartusLiteSetup detecta o ModelSimSetup na mesma pasta
# e oferece os dois. O ModelSim e' 32-bit, entao instalamos libs :i386.
#
# Rode como seu usuario normal (SEM sudo). O sudo e' pedido so no apt/udev.
# ---------------------------------------------------------------------------

set -euo pipefail

# ----------------------------- configuracao --------------------------------
VER="20.1.1.720"
Q_RUN="QuartusLiteSetup-${VER}-linux.run"
M_RUN="ModelSimSetup-${VER}-linux.run"
M_SHA1="c50f51479de963f4e79a8115dc9200e744b3ab3d"   # sha1 conhecido do ModelSim
# CDN da Altera (host alternativo: downloads.intel.com com o mesmo caminho)
BASE1="https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers"
BASE2="https://downloads.intel.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers"
DL_DIR="${HOME}/Downloads/quartus"
INSTALL_DIR="${HOME}/intelFPGA_lite/20.1"
MIN_FREE_GB=15

# ------------------------------- ajudantes ---------------------------------
c_g='\033[0;32m'; c_y='\033[1;33m'; c_r='\033[0;31m'; c_0='\033[0m'
info(){ echo -e "${c_g}==>${c_0} $*"; }
warn(){ echo -e "${c_y}[!]${c_0} $*"; }
die(){  echo -e "${c_r}[x] $*${c_0}" >&2; exit 1; }

# --------------------------- verificacoes ----------------------------------
[[ "${EUID}" -ne 0 ]] || die "Nao rode como root/sudo. Use seu usuario normal."
command -v sudo >/dev/null 2>&1 || die "'sudo' e' necessario."
[[ "$(uname -m)" == "x86_64" ]] || die "E' necessario um sistema x86_64 de 64 bits."

avail_gb="$(df -BG --output=avail "${HOME}" | tail -1 | tr -dc '0-9')"
if [[ -n "${avail_gb}" && "${avail_gb}" -lt "${MIN_FREE_GB}" ]]; then
    warn "So ha ${avail_gb} GB livres em ${HOME}. Recomendado >= ${MIN_FREE_GB} GB. Seguindo."
fi

# --------------------- passo 1: dependencias do SO -------------------------
info "Instalando dependencias (pede sudo)..."
sudo dpkg --add-architecture i386
sudo apt-get update -y

# 64-bit (GUI do Quartus) + 32-bit (ModelSim) + USB-Blaster.
DEPS=(
    wget ca-certificates
    libfontconfig1 libx11-6 libxext6 libxrender1 libxft2 libsm6 libxi6
    libc6:i386 libstdc++6:i386 zlib1g:i386
    libx11-6:i386 libxext6:i386 libxft2:i386 libxrender1:i386
    libfontconfig1:i386 libfreetype6:i386
    libncurses5:i386 libtinfo5:i386 lib32ncurses6
    libudev1:i386
)
for p in "${DEPS[@]}"; do
    sudo apt-get install -y "${p}" 2>/dev/null || warn "Nao instalou '${p}' (pulando)."
done

# Ubuntu novo removeu libncurses.so.5 / libtinfo.so.5, que o ModelSim procura.
# Cria links de compatibilidade a partir do .so.6 quando faltar.
fix_so5(){
    local dir="$1" lib
    for lib in libncurses libtinfo; do
        if [[ -e "${dir}/${lib}.so.6" && ! -e "${dir}/${lib}.so.5" ]]; then
            sudo ln -sf "${dir}/${lib}.so.6" "${dir}/${lib}.so.5" && info "link ${lib}.so.5 em ${dir}"
        fi
    done
}
fix_so5 /usr/lib/i386-linux-gnu
fix_so5 /usr/lib/x86_64-linux-gnu
sudo ldconfig || true

# --------------------- passo 2: obter os instaladores ----------------------
SEARCH_DIRS=( "${HOME}/Downloads" "${DL_DIR}" "$(pwd)" "$(dirname "$(readlink -f "$0")")" )

# procura um arquivo pelos diretorios; ecoa o caminho se achar
achar(){
    local nome="$1" d
    for d in "${SEARCH_DIRS[@]}"; do
        if [[ -f "${d}/${nome}" ]]; then echo "${d}/${nome}"; return 0; fi
    done
    return 1
}

# baixa tentando host 1 e depois host 2
baixar(){
    local nome="$1" destino="$2"
    info "Baixando ${nome}..."
    wget -c "${BASE1}/${nome}" -O "${destino}" && return 0
    warn "Host da Altera falhou; tentando host da Intel..."
    wget -c "${BASE2}/${nome}" -O "${destino}"
}

mkdir -p "${DL_DIR}"

# Quartus
Q_PATH="$(achar "${Q_RUN}" || true)"
if [[ -n "${Q_PATH}" ]]; then
    info "Quartus encontrado: ${Q_PATH}"
else
    Q_PATH="${DL_DIR}/${Q_RUN}"
    baixar "${Q_RUN}" "${Q_PATH}" || die "Falha ao baixar o Quartus."
fi

# ModelSim
M_PATH="$(achar "${M_RUN}" || true)"
if [[ -n "${M_PATH}" ]]; then
    info "ModelSim encontrado: ${M_PATH}"
else
    M_PATH="${DL_DIR}/${M_RUN}"
    baixar "${M_RUN}" "${M_PATH}" || die "Falha ao baixar o ModelSim."
fi
# confere o checksum do ModelSim (temos o sha1 oficial)
if echo "${M_SHA1}  ${M_PATH}" | sha1sum -c --status - 2>/dev/null; then
    info "Checksum do ModelSim OK."
else
    warn "Checksum do ModelSim nao confere. Se der erro na instalacao, apague e rode de novo."
fi

# Os dois .run precisam estar NA MESMA PASTA para o Quartus oferecer o ModelSim.
if [[ "$(dirname "${Q_PATH}")" != "$(dirname "${M_PATH}")" ]]; then
    info "Juntando os dois instaladores em ${DL_DIR}..."
    cp -n "${Q_PATH}" "${DL_DIR}/" 2>/dev/null || true
    cp -n "${M_PATH}" "${DL_DIR}/" 2>/dev/null || true
    Q_PATH="${DL_DIR}/${Q_RUN}"
fi
chmod +x "$(dirname "${Q_PATH}")"/*.run

# --------------------- passo 3: instalar (GUI) -----------------------------
cat <<EOF

Vai abrir o instalador grafico. Nele:
  * Marque QUARTUS PRIME e MODELSIM (ModelSim-Intel FPGA Starter Edition).
  * Em "Select devices", marque a familia da SUA placa. Exemplos:
        - MAX 10       -> DE10-Lite
        - Cyclone V    -> DE1-SoC / DE10-Nano / DE10-Standard
        - Cyclone IV E -> DE2-115 / DE0
  * Pasta padrao: ${INSTALL_DIR}

EOF
read -rp "Pressione Enter para abrir o instalador..."
"${Q_PATH}" --installdir "${INSTALL_DIR}" || die "O instalador terminou com erro."

# localiza os binarios (aceita caso voce tenha mudado a pasta)
QUARTUS=""; MODELSIM=""
for c in "${INSTALL_DIR}/quartus/bin/quartus" "${HOME}"/intelFPGA_lite/*/quartus/bin/quartus /opt/intelFPGA_lite/*/quartus/bin/quartus; do
    [[ -x "${c}" ]] && { QUARTUS="${c}"; break; }
done
for c in "${INSTALL_DIR}/modelsim_ase/bin/vsim" "${HOME}"/intelFPGA_lite/*/modelsim_ase/bin/vsim /opt/intelFPGA_lite/*/modelsim_ase/bin/vsim; do
    [[ -x "${c}" ]] && { MODELSIM="${c}"; break; }
done
[[ -n "${QUARTUS}" ]] || die "Nao achei o binario do Quartus apos instalar."
Q_DIR="$(dirname "$(dirname "${QUARTUS}")")"           # .../quartus
M_DIR=""; [[ -n "${MODELSIM}" ]] && M_DIR="$(dirname "${MODELSIM}")"   # .../modelsim_ase/bin

# --------------------- passo 4: regras udev (USB-Blaster) ------------------
info "Instalando regras udev do USB-Blaster (pede sudo)..."
sudo tee /etc/udev/rules.d/51-usbblaster.rules >/dev/null <<'RULES'
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
RULES
sudo udevadm control --reload-rules && sudo udevadm trigger

# --------------------- passo 5: PATH ---------------------------------------
BASHRC="${HOME}/.bashrc"
add_path(){  # adiciona ao PATH no .bashrc se ainda nao existir
    local dir="$1"
    [[ -n "${dir}" ]] || return 0
    if ! grep -qF "${dir}" "${BASHRC}" 2>/dev/null; then
        printf '\n# quartus/modelsim\nexport PATH="$PATH:%s"\n' "${dir}" >> "${BASHRC}"
        info "PATH += ${dir}"
    fi
}
add_path "${Q_DIR}/bin"
add_path "${M_DIR}"

# ------------------------------- fim ---------------------------------------
cat <<EOF

$(info "Concluido.")

Quartus:  ${Q_DIR%/quartus}
ModelSim: ${M_DIR:-<nao instalado - reabra o instalador e marque ModelSim>}

Faca:
  1) source ~/.bashrc   (ou abra um novo terminal)
  2) quartus            para abrir o Quartus
  3) No Quartus: Tools > Options > EDA Tool Options, aponte "ModelSim-Altera" para:
        ${M_DIR:-.../modelsim_ase/bin}

Se o ModelSim NAO abrir no Ubuntu novo (erro de plataforma ou fonte), use a
correcao conhecida (fontes 32-bit do sistema):
    cd "$(dirname "${M_DIR:-/tmp}")/linuxaloem" 2>/dev/null && \\
      for f in libfreetype*.so*; do [ -e "\$f" ] && mv "\$f" "\$f.bak"; done
EOF
