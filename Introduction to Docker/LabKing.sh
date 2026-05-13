#!/bin/bash

# ==============================
#        COLOR DESIGN
# ==============================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
RESET='\033[0m'
BOLD='\033[1m'

clear

# ==============================
#        WELCOME SCREEN
# ==============================

echo -e "${MAGENTA}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${MAGENTA}║${CYAN}             🚀 LABKING AUTO EXECUTOR 🚀              ${MAGENTA}║${RESET}"
echo -e "${MAGENTA}║${WHITE}         Google Cloud Arcade Lab Automation           ${MAGENTA}║${RESET}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════╝${RESET}"
echo

read -p "$(echo -e ${YELLOW}${BOLD}Enter Your REGION: ${RESET})" REGION

echo
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}[✓] Checking Google Cloud Authentication...${RESET}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

gcloud auth list

echo
echo -e "${CYAN}[1/10] Creating Workspace Folder...${RESET}"

mkdir -p labking && cd labking

echo
echo -e "${CYAN}[2/10] Generating Dockerfile...${RESET}"

cat > Dockerfile <<'EOF'
FROM node:lts

WORKDIR /usr/src/app

COPY . .

EXPOSE 80

CMD ["node", "server.js"]
EOF

echo
echo -e "${CYAN}[3/10] Creating Node.js Server...${RESET}"

cat > server.js <<'EOF'
const http = require('http');

const HOST = '0.0.0.0';
const PORT = 80;

const app = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Welcome to Cloud\n');
});

app.listen(PORT, HOST, () => {
    console.log(`Server started on http://${HOST}:${PORT}`);
});
EOF

echo
echo -e "${CYAN}[4/10] Building Docker Image...${RESET}"

docker build -t labking-app:v1 .

echo
echo -e "${CYAN}[5/10] Starting Docker Container...${RESET}"

docker run -d -p 8080:80 --name labking-container labking-app:v1

echo
echo -e "${CYAN}[6/10] Active Containers:${RESET}"

docker ps

echo
echo -e "${CYAN}[7/10] Creating Artifact Registry Repository...${RESET}"

gcloud artifacts repositories create labking-repo \
--repository-format=docker \
--location=$REGION \
--description="LabKing Docker Repo"

echo
echo -e "${CYAN}[8/10] Configuring Docker Permissions...${RESET}"

gcloud auth configure-docker ${REGION}-docker.pkg.dev --quiet

PROJECT_ID=$(gcloud config get-value project)

echo
echo -e "${CYAN}[9/10] Uploading Image to Artifact Registry...${RESET}"

docker build -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/labking-repo/labking-app:v1 .

docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/labking-repo/labking-app:v1

echo
echo -e "${CYAN}[10/10] Launching Final Container from Registry...${RESET}"

docker stop $(docker ps -aq) >/dev/null 2>&1
docker rm $(docker ps -aq) >/dev/null 2>&1

docker run -d -p 4000:80 \
${REGION}-docker.pkg.dev/${PROJECT_ID}/labking-repo/labking-app:v1

echo
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║${WHITE}             🎉 LAB COMPLETED SUCCESSFULLY 🎉         ${GREEN}║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${RESET}"

echo
echo -e "${YELLOW}━━━━━━━━━━━ CHANNEL INFO ━━━━━━━━━━━${RESET}"
echo -e "${CYAN}📺 YouTube : ${WHITE}LabKing${RESET}"
echo -e "${CYAN}🔥 Support : ${WHITE}Like • Share • Subscribe${RESET}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
