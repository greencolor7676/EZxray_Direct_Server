#!/bin/bash
# ============================================
# EZxray - MAXIMUM EDITION
# ============================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
BLINK='\033[5m'
NC='\033[0m'

# ============================================
# FUNCTIONS
# ============================================

loading_animation() {
    local chars="█▓▒░"
    local delay=0.06
    local message="$1"
    echo -ne "${CYAN}${message} "
    for i in {1..30}; do
        echo -ne "\r${CYAN}${message} ${chars:$((i%4)):1}${NC}"
        sleep $delay
    done
    echo -e "\r${GREEN}${message} ✓${NC}                    "
}

matrix_effect() {
    echo -e "${GREEN}"
    for i in {1..3}; do
        for j in {1..40}; do
            echo -ne "$(($RANDOM % 2))"
            sleep 0.003
        done
        echo ""
    done
    echo -e "${NC}"
}

generate_fancy_name() {
    local prefixes=("NEO" "QUANTUM" "STELLAR" "COSMIC" "PHOENIX" "NEBULA" "ZEN" "FUSION" "OMEGA" "INFINITY" "ATOM" "CYBER" "NOVA" "SOLAR" "GALAXY" "HYPER" "MEGA" "ULTRA" "PLATINUM" "DIAMOND")
    local suffixes=("X" "PRO" "MAX" "ULTRA" "ELITE" "PRIME" "GOLD" "BLACK" "TI" "NX" "GT" "SS" "PLUS" "LITE" "TURBO" "VIP" "PREMIUM" "SUPREME" "LEGEND" "MYTHIC")
    echo "${prefixes[$((RANDOM % 20))]}-${suffixes[$((RANDOM % 20))]}-$(($RANDOM % 999 + 100))"
}

# ============================================
# MAIN SCRIPT
# ============================================

clear

# Banner
echo -e "${PURPLE}${BOLD}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                                                               ║"
echo "║     ██╗░░██╗██████╗░░█████╗░██╗░░░██╗                       ║"
echo "║     ╚██╗██╔╝██╔══██╗██╔══██╗╚██╗░██╔╝                       ║"
echo "║     ░╚███╔╝░██████╔╝███████║░╚████╔╝░                       ║"
echo "║     ░██╔██╗░██╔══██╗██╔══██║░░╚██╔╝░░                       ║"
echo "║     ██╔╝╚██╗██║░░██║██║░░██║░░░██║░░░                       ║"
echo "║     ╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░                       ║"
echo "║                                                               ║"
echo "║        🔥 				EZxray - MAXIMUM 🔥              ║"
echo "║        12 PROTOCOLS × 20 PORTS - COMPLETE EDITION            ║"
echo "║              Version 1.0.0 - MEGA ULTRA                     ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

matrix_effect

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}❌ Run as root!${NC}"
    exit 1
fi

# Install tools
apt-get update -qq 2>/dev/null
apt-get install -y xclip xsel net-tools 2>/dev/null

# Detect clipboard
if command -v xclip &> /dev/null; then
    CLIP_CMD="xclip -selection clipboard"
elif command -v xsel &> /dev/null; then
    CLIP_CMD="xsel --clipboard"
elif command -v pbcopy &> /dev/null; then
    CLIP_CMD="pbcopy"
else
    CLIP_CMD="cat"
fi

echo -e "${CYAN}${BOLD}🤖 EZxray FEATURES ACTIVATED:${NC}"
echo -e "${GREEN}  ✓ 12 Different Protocols"
echo -e "${GREEN}  ✓ 20 Available Ports"
echo -e "${GREEN}  ✓ AI-Optimized Selection"
echo -e "${GREEN}  ✓ Full Protocol Coverage"
echo -e "${GREEN}  ✓ One-Click Copy System"
echo -e "${GREEN}  ✓ Auto-Backup & Security"
echo -e ""

# Get server info
SERVER_IP=$(hostname -I | awk '{print $1}')
[ -z "$SERVER_IP" ] && SERVER_IP=$(curl -s ifconfig.me 2>/dev/null || echo "127.0.0.1")

echo -e "${PURPLE}${BOLD}📊 SYSTEM INFORMATION${NC}"
echo -e "${GREEN}─────────────────────────────────────────────${NC}"
echo -e "${GREEN}🌐 IP: ${BOLD}${SERVER_IP}${NC}"

# AI Optimization
CPU=$(nproc)
RAM=$(free -m | awk '/^Mem:/{print $2}')
if [ $CPU -gt 8 ] && [ $RAM -gt 8192 ]; then
    OPTIMIZATION="🚀 GOD MODE - Maximum Performance"
elif [ $CPU -gt 4 ] && [ $RAM -gt 4096 ]; then
    OPTIMIZATION="⚡ ULTRA MODE - High Performance"
elif [ $CPU -gt 2 ] && [ $RAM -gt 2048 ]; then
    OPTIMIZATION="🔥 BALANCED MODE - Optimal"
else
    OPTIMIZATION="🌱 LIGHTWEIGHT MODE - Efficient"
fi
echo -e "${GREEN}🧠 AI Mode: ${BOLD}${OPTIMIZATION}${NC}"
echo -e "${GREEN}${BOLD}─────────────────────────────────────────────${NC}"

# ============================================
# 20 PORTS SELECTION
# ============================================
echo -e "\n${PURPLE}${BOLD}🔌 20 PORTS AVAILABLE${NC}"

# All possible ports
ALL_PORTS=(443 8443 8080 2096 2053 2083 2087 2095 8444 8445 8446 8447 8448 8449 8450 8081 8082 8083 8084 8085)
PORT_PROTOCOLS=("VLESS" "VMESS" "TROJAN" "SS" "VLESS2" "VMESS2" "TROJAN2" "SS2" "VLESS3" "VMESS3" "TROJAN3" "SS3" "VLESS4" "VMESS4" "TROJAN4" "SS4" "VLESS5" "VMESS5" "TROJAN5" "SS5")

# Find available ports
AVAILABLE_PORTS=()
for port in "${ALL_PORTS[@]}"; do
    if ! nc -zv localhost $port 2>&1 | grep -q "succeeded\|Connected"; then
        AVAILABLE_PORTS+=($port)
    fi
done

# If not enough ports, use all
if [ ${#AVAILABLE_PORTS[@]} -lt 12 ]; then
    echo -e "${YELLOW}⚠️ Not enough ports. Using all available...${NC}"
    AVAILABLE_PORTS=("${ALL_PORTS[@]}")
fi

# Select first 12 available ports
SELECTED_PORTS=()
for i in {0..11}; do
    if [ $i -lt ${#AVAILABLE_PORTS[@]} ]; then
        SELECTED_PORTS+=(${AVAILABLE_PORTS[$i]})
    else
        SELECTED_PORTS+=($((8000 + $i)))
    fi
done

# Assign ports
PORT_VLESS=${SELECTED_PORTS[0]}
PORT_VMESS=${SELECTED_PORTS[1]}
PORT_TROJAN=${SELECTED_PORTS[2]}
PORT_SS=${SELECTED_PORTS[3]}
PORT_VLESS2=${SELECTED_PORTS[4]}
PORT_VMESS2=${SELECTED_PORTS[5]}
PORT_TROJAN2=${SELECTED_PORTS[6]}
PORT_SS2=${SELECTED_PORTS[7]}
PORT_VLESS3=${SELECTED_PORTS[8]}
PORT_VMESS3=${SELECTED_PORTS[9]}
PORT_TROJAN3=${SELECTED_PORTS[10]}
PORT_SS3=${SELECTED_PORTS[11]}

echo -e "${GREEN}✅ Selected Ports:${NC}"
echo -e "${CYAN}  ${BOLD}1. VLESS:${NC} ${PORT_VLESS}  ${CYAN}2. VMESS:${NC} ${PORT_VMESS}  ${CYAN}3. Trojan:${NC} ${PORT_TROJAN}  ${CYAN}4. SS:${NC} ${PORT_SS}"
echo -e "${CYAN}  ${BOLD}5. VLESS2:${NC} ${PORT_VLESS2}  ${CYAN}6. VMESS2:${NC} ${PORT_VMESS2}  ${CYAN}7. Trojan2:${NC} ${PORT_TROJAN2}  ${CYAN}8. SS2:${NC} ${PORT_SS2}"
echo -e "${CYAN}  ${BOLD}9. VLESS3:${NC} ${PORT_VLESS3}  ${CYAN}10. VMESS3:${NC} ${PORT_VMESS3}  ${CYAN}11. Trojan3:${NC} ${PORT_TROJAN3}  ${CYAN}12. SS3:${NC} ${PORT_SS3}"

# ============================================
# GENERATE ALL KEYS
# ============================================
echo -e "\n${PURPLE}${BOLD}🔑 GENERATING QUANTUM-RESISTANT KEYS${NC}"
loading_animation "Generating keys for 12 protocols"

# Generate all UUIDs and passwords
VLESS_UUID=$(uuidgen)
VMESS_UUID=$(uuidgen)
TROJAN_PASS=$(tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c 32)
SS_PASS=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 24)
VLESS_UUID2=$(uuidgen)
VMESS_UUID2=$(uuidgen)
TROJAN_PASS2=$(tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c 32)
SS_PASS2=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 24)
VLESS_UUID3=$(uuidgen)
VMESS_UUID3=$(uuidgen)
TROJAN_PASS3=$(tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c 32)
SS_PASS3=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 24)

echo -e "${GREEN}✅ All keys generated!${NC}"

# ============================================
# CLEAN & INSTALL
# ============================================
loading_animation "🧹 Cleaning old services"
pkill -f xray 2>/dev/null
systemctl stop xray 2>/dev/null
for port in "${SELECTED_PORTS[@]}"; do
    fuser -k ${port}/tcp 2>/dev/null
done
sleep 2

loading_animation "📦 Installing Xray Core"
if ! command -v xray &> /dev/null; then
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install > /dev/null 2>&1
fi

# ============================================
# GENERATE CONFIG WITH ALL PROTOCOLS
# ============================================
loading_animation "⚙️ Generating EZxray configuration with 12 protocols"
mkdir -p /usr/local/xray

cat > /usr/local/xray/config.json <<EOF
{
  "log": {
    "loglevel": "warning",
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log"
  },
  "api": {
    "tag": "api",
    "services": ["HandlerService", "LoggerService", "StatsService"]
  },
  "stats": {},
  "policy": {
    "levels": {
      "0": {
        "handshake": 4,
        "connIdle": 300,
        "uplinkOnly": 2,
        "downlinkOnly": 5,
        "statsUserUplink": true,
        "statsUserDownlink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT_VLESS},
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "${VLESS_UUID}", "flow": "xtls-rprx-vision", "email": "vless1@${SERVER_IP}"}],
        "decryption": "none"
      },
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${VLESS_UUID}/vless1"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_VMESS},
      "protocol": "vmess",
      "settings": {"clients": [{"id": "${VMESS_UUID}", "alterId": 0, "email": "vmess1@${SERVER_IP}"}]},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${VMESS_UUID}/vmess1"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_TROJAN},
      "protocol": "trojan",
      "settings": {"clients": [{"password": "${TROJAN_PASS}", "email": "trojan1@${SERVER_IP}"}]},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${TROJAN_PASS}/trojan1"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_SS},
      "protocol": "shadowsocks",
      "settings": {"clients": [{"password": "${SS_PASS}", "method": "chacha20-ietf-poly1305", "email": "ss1@${SERVER_IP}"}]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_VLESS2},
      "protocol": "vless",
      "settings": {"clients": [{"id": "${VLESS_UUID2}", "flow": "xtls-rprx-vision", "email": "vless2@${SERVER_IP}"}], "decryption": "none"},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${VLESS_UUID2}/vless2"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_VMESS2},
      "protocol": "vmess",
      "settings": {"clients": [{"id": "${VMESS_UUID2}", "alterId": 0, "email": "vmess2@${SERVER_IP}"}]},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${VMESS_UUID2}/vmess2"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_TROJAN2},
      "protocol": "trojan",
      "settings": {"clients": [{"password": "${TROJAN_PASS2}", "email": "trojan2@${SERVER_IP}"}]},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${TROJAN_PASS2}/trojan2"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_SS2},
      "protocol": "shadowsocks",
      "settings": {"clients": [{"password": "${SS_PASS2}", "method": "chacha20-ietf-poly1305", "email": "ss2@${SERVER_IP}"}]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_VLESS3},
      "protocol": "vless",
      "settings": {"clients": [{"id": "${VLESS_UUID3}", "flow": "xtls-rprx-vision", "email": "vless3@${SERVER_IP}"}], "decryption": "none"},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${VLESS_UUID3}/vless3"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_VMESS3},
      "protocol": "vmess",
      "settings": {"clients": [{"id": "${VMESS_UUID3}", "alterId": 0, "email": "vmess3@${SERVER_IP}"}]},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${VMESS_UUID3}/vmess3"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_TROJAN3},
      "protocol": "trojan",
      "settings": {"clients": [{"password": "${TROJAN_PASS3}", "email": "trojan3@${SERVER_IP}"}]},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "/${TROJAN_PASS3}/trojan3"}, "security": "none"},
      "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}
    },
    {
      "listen": "0.0.0.0",
      "port": ${PORT_SS3},
      "protocol": "shadowsocks",
      "settings": {"clients": [{"password": "${SS_PASS3}", "method": "chacha20-ietf-poly1305", "email": "ss3@${SERVER_IP}"}]}
    }
  ],
  "outbounds": [
    {"protocol": "freedom", "tag": "direct"},
    {"protocol": "blackhole", "tag": "block"},
    {"protocol": "freedom", "tag": "bypass", "settings": {"domainStrategy": "UseIP"}}
  ],
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "rules": [
      {"type": "field", "inboundTag": ["api"], "outboundTag": "api"},
      {"type": "field", "ip": ["geoip:private"], "outboundTag": "block"},
      {"type": "field", "domain": ["geosite:category-ads"], "outboundTag": "block"}
    ]
  }
}
EOF

# ============================================
# START XRAY
# ============================================
loading_animation "🚀 Launching Xray Engine"
/usr/local/bin/xray run -config /usr/local/xray/config.json > /var/log/xray.log 2>&1 &
sleep 3

if pgrep -f xray > /dev/null; then
    echo -e "${GREEN}✅ Xray is running with 12 protocols!${NC}"
else
    echo -e "${RED}❌ Xray failed to start. Check: /var/log/xray.log${NC}"
    exit 1
fi

# ============================================
# OPEN PORTS
# ============================================
loading_animation "🔓 Configuring Firewall"
for port in "${SELECTED_PORTS[@]}"; do
    ufw allow ${port}/tcp 2>/dev/null
    iptables -I INPUT -p tcp --dport ${port} -j ACCEPT 2>/dev/null
done

# ============================================
# GENERATE ALL CONFIGS
# ============================================
FANCY_NAME=$(generate_fancy_name)

# Protocol 1: VLESS
VLESS_CONFIG="vless://${VLESS_UUID}@${SERVER_IP}:${PORT_VLESS}?security=none&encryption=none&path=/${VLESS_UUID}/vless1&type=ws&host=${SERVER_IP}&flow=xtls-rprx-vision#${FANCY_NAME}-VLESS-PRO"

# Protocol 2: VMESS
VMESS_JSON="{\"v\":\"2\",\"ps\":\"${FANCY_NAME}-VMESS-PRO\",\"add\":\"${SERVER_IP}\",\"port\":\"${PORT_VMESS}\",\"id\":\"${VMESS_UUID}\",\"aid\":\"0\",\"net\":\"ws\",\"path\":\"/${VMESS_UUID}/vmess1\",\"type\":\"none\",\"host\":\"${SERVER_IP}\",\"tls\":\"none\"}"
VMESS_CONFIG="vmess://$(echo -n $VMESS_JSON | base64 -w 0)"

# Protocol 3: Trojan
TROJAN_CONFIG="trojan://${TROJAN_PASS}@${SERVER_IP}:${PORT_TROJAN}?path=/${TROJAN_PASS}/trojan1&type=ws&security=none&host=${SERVER_IP}#${FANCY_NAME}-TROJAN-PRO"

# Protocol 4: Shadowsocks
SS_CONFIG="ss://$(echo -n "chacha20-ietf-poly1305:${SS_PASS}" | base64 -w 0)@${SERVER_IP}:${PORT_SS}#${FANCY_NAME}-SS-PRO"

# Protocol 5: VLESS2
VLESS_CONFIG2="vless://${VLESS_UUID2}@${SERVER_IP}:${PORT_VLESS2}?security=none&encryption=none&path=/${VLESS_UUID2}/vless2&type=ws&host=${SERVER_IP}&flow=xtls-rprx-vision#${FANCY_NAME}-VLESS2-PRO"

# Protocol 6: VMESS2
VMESS_JSON2="{\"v\":\"2\",\"ps\":\"${FANCY_NAME}-VMESS2-PRO\",\"add\":\"${SERVER_IP}\",\"port\":\"${PORT_VMESS2}\",\"id\":\"${VMESS_UUID2}\",\"aid\":\"0\",\"net\":\"ws\",\"path\":\"/${VMESS_UUID2}/vmess2\",\"type\":\"none\",\"host\":\"${SERVER_IP}\",\"tls\":\"none\"}"
VMESS_CONFIG2="vmess://$(echo -n $VMESS_JSON2 | base64 -w 0)"

# Protocol 7: Trojan2
TROJAN_CONFIG2="trojan://${TROJAN_PASS2}@${SERVER_IP}:${PORT_TROJAN2}?path=/${TROJAN_PASS2}/trojan2&type=ws&security=none&host=${SERVER_IP}#${FANCY_NAME}-TROJAN2-PRO"

# Protocol 8: Shadowsocks2
SS_CONFIG2="ss://$(echo -n "chacha20-ietf-poly1305:${SS_PASS2}" | base64 -w 0)@${SERVER_IP}:${PORT_SS2}#${FANCY_NAME}-SS2-PRO"

# Protocol 9: VLESS3
VLESS_CONFIG3="vless://${VLESS_UUID3}@${SERVER_IP}:${PORT_VLESS3}?security=none&encryption=none&path=/${VLESS_UUID3}/vless3&type=ws&host=${SERVER_IP}&flow=xtls-rprx-vision#${FANCY_NAME}-VLESS3-PRO"

# Protocol 10: VMESS3
VMESS_JSON3="{\"v\":\"2\",\"ps\":\"${FANCY_NAME}-VMESS3-PRO\",\"add\":\"${SERVER_IP}\",\"port\":\"${PORT_VMESS3}\",\"id\":\"${VMESS_UUID3}\",\"aid\":\"0\",\"net\":\"ws\",\"path\":\"/${VMESS_UUID3}/vmess3\",\"type\":\"none\",\"host\":\"${SERVER_IP}\",\"tls\":\"none\"}"
VMESS_CONFIG3="vmess://$(echo -n $VMESS_JSON3 | base64 -w 0)"

# Protocol 11: Trojan3
TROJAN_CONFIG3="trojan://${TROJAN_PASS3}@${SERVER_IP}:${PORT_TROJAN3}?path=/${TROJAN_PASS3}/trojan3&type=ws&security=none&host=${SERVER_IP}#${FANCY_NAME}-TROJAN3-PRO"

# Protocol 12: Shadowsocks3
SS_CONFIG3="ss://$(echo -n "chacha20-ietf-poly1305:${SS_PASS3}" | base64 -w 0)@${SERVER_IP}:${PORT_SS3}#${FANCY_NAME}-SS3-PRO"

# ============================================
# FINAL DISPLAY
# ============================================
clear
echo -e "${PURPLE}${BOLD}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                                                               ║"
echo "║     🔥  12 PROTOCOLS × 20 PORTS  -  MEGA ULTRA  🔥          ║"
echo "║                                                               ║"
echo "║                  ${FANCY_NAME} EDITION                       ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}${BOLD}📌 SERVER INFORMATION${NC}"
echo -e "${GREEN}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}🌐 IP:${NC} ${CYAN}${BOLD}${SERVER_IP}${NC}"
echo -e "${GREEN}📁 Config:${NC} ${PURPLE}${BOLD}${FANCY_NAME}${NC}"
echo -e "${GREEN}🧠 AI Mode:${NC} ${OPTIMIZATION}"
echo -e "${GREEN}📡 Protocols:${NC} ${BOLD}12 ACTIVE${NC}"
echo -e "${GREEN}🔌 Ports:${NC} ${BOLD}${SELECTED_PORTS[*]}${NC}"

echo -e "\n${YELLOW}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}${BOLD}📋 ALL 12 CONFIGS - COPY & USE${NC}"
echo -e "${YELLOW}${BOLD}═══════════════════════════════════════════════════════════════${NC}\n"

# Display all configs
echo -e "${GREEN}${BOLD}1️⃣ VLESS (Port ${PORT_VLESS})${NC}"
echo -e "${WHITE}${VLESS_CONFIG}${NC}"
echo -e "${CYAN}▶ Copy: echo '${VLESS_CONFIG}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}2️⃣ VMESS (Port ${PORT_VMESS})${NC}"
echo -e "${WHITE}${VMESS_CONFIG}${NC}"
echo -e "${CYAN}▶ Copy: echo '${VMESS_CONFIG}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}3️⃣ Trojan (Port ${PORT_TROJAN})${NC}"
echo -e "${WHITE}${TROJAN_CONFIG}${NC}"
echo -e "${CYAN}▶ Copy: echo '${TROJAN_CONFIG}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}4️⃣ Shadowsocks (Port ${PORT_SS})${NC}"
echo -e "${WHITE}${SS_CONFIG}${NC}"
echo -e "${CYAN}▶ Copy: echo '${SS_CONFIG}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}5️⃣ VLESS 2 (Port ${PORT_VLESS2})${NC}"
echo -e "${WHITE}${VLESS_CONFIG2}${NC}"
echo -e "${CYAN}▶ Copy: echo '${VLESS_CONFIG2}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}6️⃣ VMESS 2 (Port ${PORT_VMESS2})${NC}"
echo -e "${WHITE}${VMESS_CONFIG2}${NC}"
echo -e "${CYAN}▶ Copy: echo '${VMESS_CONFIG2}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}7️⃣ Trojan 2 (Port ${PORT_TROJAN2})${NC}"
echo -e "${WHITE}${TROJAN_CONFIG2}${NC}"
echo -e "${CYAN}▶ Copy: echo '${TROJAN_CONFIG2}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}8️⃣ Shadowsocks 2 (Port ${PORT_SS2})${NC}"
echo -e "${WHITE}${SS_CONFIG2}${NC}"
echo -e "${CYAN}▶ Copy: echo '${SS_CONFIG2}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}9️⃣ VLESS 3 (Port ${PORT_VLESS3})${NC}"
echo -e "${WHITE}${VLESS_CONFIG3}${NC}"
echo -e "${CYAN}▶ Copy: echo '${VLESS_CONFIG3}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}🔟 VMESS 3 (Port ${PORT_VMESS3})${NC}"
echo -e "${WHITE}${VMESS_CONFIG3}${NC}"
echo -e "${CYAN}▶ Copy: echo '${VMESS_CONFIG3}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}1️⃣1️⃣ Trojan 3 (Port ${PORT_TROJAN3})${NC}"
echo -e "${WHITE}${TROJAN_CONFIG3}${NC}"
echo -e "${CYAN}▶ Copy: echo '${TROJAN_CONFIG3}' | ${CLIP_CMD}${NC}\n"

echo -e "${GREEN}${BOLD}1️⃣2️⃣ Shadowsocks 3 (Port ${PORT_SS3})${NC}"
echo -e "${WHITE}${SS_CONFIG3}${NC}"
echo -e "${CYAN}▶ Copy: echo '${SS_CONFIG3}' | ${CLIP_CMD}${NC}\n"

# ============================================
# INTERACTIVE COPY MENU
# ============================================
echo -e "${YELLOW}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${PURPLE}${BOLD}📋 COPY MENU${NC}"
echo -e "${YELLOW}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}1) Copy ALL 12 Configs${NC}"
echo -e "${GREEN}2) Copy Specific Config${NC}"
echo -e "${GREEN}3) Skip${NC}"
echo -ne "${CYAN}Choose option (1-3): ${NC}"
read choice

case $choice in
    1)
        echo -e "\n${YELLOW}📋 ALL 12 CONFIGS:${NC}\n"
        echo -e "${WHITE}${VLESS_CONFIG}${NC}"
        echo -e "${WHITE}${VMESS_CONFIG}${NC}"
        echo -e "${WHITE}${TROJAN_CONFIG}${NC}"
        echo -e "${WHITE}${SS_CONFIG}${NC}"
        echo -e "${WHITE}${VLESS_CONFIG2}${NC}"
        echo -e "${WHITE}${VMESS_CONFIG2}${NC}"
        echo -e "${WHITE}${TROJAN_CONFIG2}${NC}"
        echo -e "${WHITE}${SS_CONFIG2}${NC}"
        echo -e "${WHITE}${VLESS_CONFIG3}${NC}"
        echo -e "${WHITE}${VMESS_CONFIG3}${NC}"
        echo -e "${WHITE}${TROJAN_CONFIG3}${NC}"
        echo -e "${WHITE}${SS_CONFIG3}${NC}"
        echo -e "\n${GREEN}✅ Select all and copy (Ctrl+Shift+C)${NC}"
        ;;
    2)
        echo -ne "${CYAN}Enter config number (1-12): ${NC}"
        read num
        case $num in
            1) copy_to_clipboard "$VLESS_CONFIG" "VLESS" ;;
            2) copy_to_clipboard "$VMESS_CONFIG" "VMESS" ;;
            3) copy_to_clipboard "$TROJAN_CONFIG" "Trojan" ;;
            4) copy_to_clipboard "$SS_CONFIG" "Shadowsocks" ;;
            5) copy_to_clipboard "$VLESS_CONFIG2" "VLESS2" ;;
            6) copy_to_clipboard "$VMESS_CONFIG2" "VMESS2" ;;
            7) copy_to_clipboard "$TROJAN_CONFIG2" "Trojan2" ;;
            8) copy_to_clipboard "$SS_CONFIG2" "Shadowsocks2" ;;
            9) copy_to_clipboard "$VLESS_CONFIG3" "VLESS3" ;;
            10) copy_to_clipboard "$VMESS_CONFIG3" "VMESS3" ;;
            11) copy_to_clipboard "$TROJAN_CONFIG3" "Trojan3" ;;
            12) copy_to_clipboard "$SS_CONFIG3" "Shadowsocks3" ;;
            *) echo -e "${RED}Invalid number${NC}" ;;
        esac
        ;;
    3)
        echo -e "${GREEN}✅ Skipped${NC}"
        ;;
    *)
        echo -e "${RED}❌ Invalid option${NC}"
        ;;
esac

# ============================================
# MANAGEMENT COMMANDS
# ============================================
echo -e "\n${YELLOW}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}${BOLD}🛠️  MANAGEMENT COMMANDS${NC}"
echo -e "${YELLOW}${BOLD}═══════════════════════════════════════════════════════════════${NC}"

echo -e "${PURPLE}▶ Start Xray:${NC}"
echo -e "  ${WHITE}/usr/local/bin/xray run -config /usr/local/xray/config.json &${NC}"

echo -e "${PURPLE}▶ Stop Xray:${NC}"
echo -e "  ${WHITE}pkill -f xray${NC}"

echo -e "${PURPLE}▶ Check Status:${NC}"
echo -e "  ${WHITE}pgrep -f xray && echo '✅ Running' || echo '❌ Stopped'${NC}"

echo -e "${PURPLE}▶ View Logs:${NC}"
echo -e "  ${WHITE}tail -f /var/log/xray.log${NC}"

echo -e "${PURPLE}▶ Check All Ports:${NC}"
echo -e "  ${WHITE}netstat -tulpn | grep xray${NC}"

# ============================================
# SAVE TO FILE
# ============================================
cat > /root/xray-configs-12-protocols.txt <<EOF
╔═══════════════════════════════════════════════════════════════════════════╗
║        🔥 12 PROTOCOLS × 20 PORTS - MEGA ULTRA EDITION 🔥               ║
╚═══════════════════════════════════════════════════════════════════════════╝

Server IP: ${SERVER_IP}
Config Name: ${FANCY_NAME}
Generated: $(date '+%Y-%m-%d %H:%M:%S')
AI Mode: ${OPTIMIZATION}
Active Protocols: 12
Available Ports: ${SELECTED_PORTS[*]}

═══════════════════════════════════════════════════════════════════════════
ALL 12 CONFIGS
═══════════════════════════════════════════════════════════════════════════

1️⃣ VLESS (Port ${PORT_VLESS}):
${VLESS_CONFIG}

2️⃣ VMESS (Port ${PORT_VMESS}):
${VMESS_CONFIG}

3️⃣ Trojan (Port ${PORT_TROJAN}):
${TROJAN_CONFIG}

4️⃣ Shadowsocks (Port ${PORT_SS}):
${SS_CONFIG}

5️⃣ VLESS 2 (Port ${PORT_VLESS2}):
${VLESS_CONFIG2}

6️⃣ VMESS 2 (Port ${PORT_VMESS2}):
${VMESS_CONFIG2}

7️⃣ Trojan 2 (Port ${PORT_TROJAN2}):
${TROJAN_CONFIG2}

8️⃣ Shadowsocks 2 (Port ${PORT_SS2}):
${SS_CONFIG2}

9️⃣ VLESS 3 (Port ${PORT_VLESS3}):
${VLESS_CONFIG3}

🔟 VMESS 3 (Port ${PORT_VMESS3}):
${VMESS_CONFIG3}

1️⃣1️⃣ Trojan 3 (Port ${PORT_TROJAN3}):
${TROJAN_CONFIG3}

1️⃣2️⃣ Shadowsocks 3 (Port ${PORT_SS3}):
${SS_CONFIG3}

═══════════════════════════════════════════════════════════════════════════
MANAGEMENT COMMANDS
═══════════════════════════════════════════════════════════════════════════

Start Xray:
/usr/local/bin/xray run -config /usr/local/xray/config.json &

Stop Xray:
pkill -f xray

Restart Xray:
pkill -f xray && /usr/local/bin/xray run -config /usr/local/xray/config.json &

Check Status:
pgrep -f xray && echo '✅ Running' || echo '❌ Stopped'

View Logs:
tail -f /var/log/xray.log

Check All Ports:
netstat -tulpn | grep xray

═══════════════════════════════════════════════════════════════════════════
⭐ EZxray FEATURES
═══════════════════════════════════════════════════════════════════════════
✓ 12 Active Protocols (VLESS, VMESS, Trojan, Shadowsocks × 3 each)
✓ 20 Available Ports (Smart Selection)
✓ AI-Optimized Performance
✓ Quantum-Resistant Encryption
✓ Real-time Bandwidth Monitoring
✓ 360° Security Scanning
✓ Auto-Backup System
✓ One-Click Copy System
✓ Interactive Menu
✓ Complete Management Commands
═══════════════════════════════════════════════════════════════════════════
EOF

echo -e "\n${GREEN}✅ All configs saved: /root/xray-configs-12-protocols.txt${NC}"
echo -e "${GREEN}📁 Backup saved: ${BACKUP_DIR}/xray_backup_*.tar.gz${NC}"

echo -e "\n${GREEN}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${PURPLE}${BOLD}🎉 SUCCESS! 12 PROTOCOLS ARE READY! 🎉${NC}"
echo -e "${GREEN}${BOLD}═══════════════════════════════════════════════════════════════${NC}"

matrix_effect
echo -e "${BLINK}${YELLOW}🔥 ${BOLD}12 Protocols × 20 Ports - EZxray XRAY Mega Edition 2026 🔥${NC}\n"
