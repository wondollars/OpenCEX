#!/bin/bash
# Đọc các biến từ file config.env
source "$(dirname "$0")/config.env"

if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    echo "Docker not found, install docker..."
    sudo apt-get update > /dev/null 2>&1
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null 2>&1
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update > /dev/null 2>&1
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io git docker-compose-plugin > /dev/null 2>&1
    sudo systemctl enable docker > /dev/null 2>&1
    sudo systemctl start docker > /dev/null 2>&1
    echo "Docker has been successfully installed."
else
    echo "Docker already installed."
fi


mkdir /app/opencex -p
cd /app/opencex || exit
git clone  https://github.com/wondollars/OpenCEX-backend.git ./backend
git clone  https://github.com/wondollars/OpenCEX-frontend.git ./frontend
git clone  https://github.com/wondollars/OpenCEX-static.git ./nuxt
git clone  https://github.com/wondollars/OpenCEX-JS-admin.git ./admin

echo "`cat <<YOLLOPUKKI


 000000\                                 000000\  00000000\ 00\   00\ 
00  __00\                               00  __00\ 00  _____|00 |  00 |
00 /  00 | 000000\   000000\  0000000\  00 /  \__|00 |      \00\ 00  |
00 |  00 |00  __00\ 00  __00\ 00  __00\ 00 |      00000\     \0000  / 
00 |  00 |00 /  00 |00000000 |00 |  00 |00 |      00  __|    00  00<  
00 |  00 |00 |  00 |00   ____|00 |  00 |00 |  00\ 00 |      00  /\00\ 
 000000  |0000000  |\0000000\ 00 |  00 |\000000  |00000000\ 00 /  00 |
 \______/ 00  ____/  \_______|\__|  \__| \______/ \________|\__|  \__|
          00 |                                                        
          00 |                                                        
          \__|  

Hello! This is OpenCEX Setup. Please enter parameters for your exchange.
If you make a mistake when entering a parameter, don't worry, 
at the end of each parameter block you will have the opportunity 
to re-enter the parameters.

* is for the required field. 
		  
YOLLOPUKKI`"

read -p "Press enter to continue"

cd /app/opencex/backend || exit
FILE=/app/opencex/backend/.env
if test ! -f "$FILE"; then

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 1 OF 12. PROJECT VARIABLES
===========================================================

PROJECT_NAME* - name of your exchange
DOMAIN* - base domain of your exchange
ADMIN_BASE_URL* - URL of the admin panel, added to DOMAIN
ADMIN_USER* - email of the user that would have admin rights 
ADMIN_MASTERPASS* - master password, used to create 
   balance accrual/debit transactions
SUPPORT_EMAIL - email address of support

-----------------------------------------------------------
YOLLOPUKKI`"
 
source "$(dirname "$0")/config.env"

 
export PROJECT_NAME
export DOMAIN
export ADMIN_BASE_URL
export ADMIN_USER
export ADMIN_MASTERPASS
export SUPPORT_EMAIL
export TELEGRAM
export FACEBOOK
export TWITTER
export LINKEDIN
export LOGO

echo "PROJECT_NAME: $PROJECT_NAME"
echo "DOMAIN: $DOMAIN"
echo "ADMIN_BASE_URL: $ADMIN_BASE_URL"
echo "ADMIN_USER: $ADMIN_USER"
echo "ADMIN_MASTERPASS: $ADMIN_MASTERPASS"
echo "SUPPORT_EMAIL: $SUPPORT_EMAIL"
echo "TELEGRAM: $TELEGRAM"
echo "FACEBOOK: $FACEBOOK"
echo "TWITTER: $TWITTER"
echo "LINKEDIN: $LINKEDIN"
echo "LOGO: $LOGO"

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 2 OF 12. COMMON SERVICES
===========================================================

RECAPTCHA* - Google Captcha site key
RECAPTCHA_SECRET* - Google Captcha secret key
TELEGRAM_CHAT_ID - used to send alerts to Telegram
TELEGRAM_ALERTS_CHAT_ID - monitoring collection and the state of collectors
TELEGRAM_BOT_TOKEN - token for the Alert bot

-----------------------------------------------------------
YOLLOPUKKI`"

# Đọc các biến từ file config.env
source "$(dirname "$0")/config.env"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
export RECAPTCHA
export RECAPTCHA_SECRET
export TELEGRAM_CHAT_ID
export TELEGRAM_ALERTS_CHAT_ID
export TELEGRAM_BOT_TOKEN

echo "RECAPTCHA: $RECAPTCHA"
echo "RECAPTCHA_SECRET: $RECAPTCHA_SECRET"
echo "TELEGRAM_CHAT_ID: $TELEGRAM_CHAT_ID"
echo "TELEGRAM_ALERTS_CHAT_ID: $TELEGRAM_ALERTS_CHAT_ID"
echo "TELEGRAM_BOT_TOKEN: $TELEGRAM_BOT_TOKEN"


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 3 OF 12. BLOCKCHAIN SERVICES
===========================================================

INFURA_API_KEY* - used for the ETH blockchain data
INFURA_API_SECRET* - used for the ETH blockchain data

ETHERSCAN_KEY* - used for the ETH blockchain data

-----------------------------------------------------------
YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
export INFURA_API_KEY
export INFURA_API_SECRET
export ETHERSCAN_KEY

echo "INFURA_API_KEY: $INFURA_API_KEY"
echo "INFURA_API_SECRET: $INFURA_API_SECRET"
echo "ETHERSCAN_KEY: $ETHERSCAN_KEY"

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 4 OF 12. SAFE ADDRESSES
===========================================================

BTC_SAFE_ADDR* - bitcoin address. All BTC deposits go there
ETH_SAFE_ADDR* - ethereum address. All ETH and ERC-20 deposits go there

-----------------------------------------------------------
YOLLOPUKKI`"

source "$(dirname "$0")/config.env"
export BTC_SAFE_ADDR
export ETH_SAFE_ADDR 

echo "BTC_SAFE_ADDR: $BTC_SAFE_ADDR"
echo "ETH_SAFE_ADDR: $ETH_SAFE_ADDR"


echo "`cat <<YOLLOPUKKI

=======================================================================================
     STEP 5 of 12. BINANCE BSC BLOCKCHAIN, BNB and USDT BEP-20 SUPPORT. (optional)
=======================================================================================

You can set ENABLED_BNB: False or leave it blank to turn it off.

BSCSCAN_KEY* - used for the BSC blockchain data
BNB_SAFE_ADDR* - binance smart chain address. All BNB and BEP-20 deposits go there

---------------------------------------------------------------------------------------
YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_BNB" = "True" ]; then
    export ENABLED_BNB
    export BSCSCAN_KEY
    export BNB_SAFE_ADDR
    echo "ENABLED_BNB: $ENABLED_BNB"
    echo "BSCSCAN_KEY: $BSCSCAN_KEY"
    echo "BNB_SAFE_ADDR: $BNB_SAFE_ADDR"
else
    echo "Binance BSC Blockchain support is disabled."
fi




echo "`cat <<YOLLOPUKKI
 



=======================================================================================
     STEP 6 of 12. TRON BLOCKCHAIN, TRX and USDT TRC-20 SUPPORT. (optional)
=======================================================================================

You can set ENABLED_TRON: False or leave it blank to turn it off.

TRONGRID_API_KEY* - used for the Tron blockchain data
TRX_SAFE_ADDR* - tron address. All TRX and TRC-20 deposits go there

---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_TRON" = "True" ]; then
    export ENABLED_TRON
    export TRONGRID_API_KEY
    export TRX_SAFE_ADDR
    echo "ENABLED_TRON: $ENABLED_TRON"
    echo "TRONGRID_API_KEY: $TRONGRID_API_KEY"
    echo "TRX_SAFE_ADDR: $TRX_SAFE_ADDR"
else
    echo "Tron Blockchain support is disabled."
fi


echo "`cat <<YOLLOPUKKI

=======================================================================================
 STEP 7 of 12. POLYGON BLOCKCHAIN, POLYGON and USDT POLYGON SUPPORT. (optional)
=======================================================================================

You can set ENABLED_WON: False or leave it blank to turn it off.

POLYGONSCAN_KEY* - used for the Won blockchain data
POLYGON_SAFE_ADDR* - Won address. All POLYGON and ERC-20 (POLYGON) deposits go there
---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_MATIC" = "True" ]; then    
 
    export ENABLED_MATIC
    export COMMON_TASKS_MATIC
    export POLYGONSCAN_KEY
    export MATIC_SAFE_ADDR

    echo "ENABLED_MATIC: $ENABLED_MATIC"
    echo "COMMON_TASKS_MATIC: $COMMON_TASKS_MATIC"
    echo "POLYGONSCAN_KEY: $POLYGONSCAN_KEY"
    echo "MATIC_SAFE_ADDR: $MATIC_SAFE_ADDR"
else
    echo "Polygon Blockchain support is disabled."
fi

echo "`cat <<YOLLOPUKKI

=======================================================================================
 STEP 7.1 of 12. WON BLOCKCHAIN, WON and USDT WON SUPPORT. (optional)
=======================================================================================

You can set ENABLED_WON: False or leave it blank to turn it off.

WONSCAN_KEY* - used for the Won blockchain data
WON_SAFE_ADDR* - Won address. All WON and ERC-20 (WON) deposits go there
---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_WON" = "True" ]; then    
 
    export ENABLED_WON
    export COMMON_TASKS_WON
    export WONSCAN_KEY
    export WON_SAFE_ADDR

    echo "ENABLED_WON: $ENABLED_WON"
    echo "COMMON_TASKS_WON: $COMMON_TASKS_WON"
    echo "WONSCAN_KEY: $WONSCAN_KEY"
    echo "WON_SAFE_ADDR: $WON_SAFE_ADDR"
else
    echo "WON Blockchain support is disabled."
fi

echo "`cat <<YOLLOPUKKI

=======================================================================================
 STEP 7.1 of 12. WON BLOCKCHAIN, WON and USDT WON SUPPORT. (optional)
=======================================================================================

You can set ENABLED_WON: False or leave it blank to turn it off.

WONSCAN_KEY* - used for the Won blockchain data
WON_SAFE_ADDR* - Won address. All WON and ERC-20 (WON) deposits go there
---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_CELO" = "True" ]; then    
 
    export ENABLED_CELO
    export COMMON_TASKS_CELO
    export CELOSCAN_KEY
    export CELO_SAFE_ADDR

    echo "ENABLED_CELO: $ENABLED_CELO"
    echo "COMMON_TASKS_CELO: $COMMON_TASKS_CELO"
    echo "CELOSCAN_KEY: $CELOSCAN_KEY"
    echo "CELO_SAFE_ADDR: $CELO_SAFE_ADDR"
else
    echo "WON Blockchain support is disabled."
fi

echo "`cat <<YOLLOPUKKI

=======================================================================================
 STEP 7.1 of 12. WON BLOCKCHAIN, WON and USDT WON SUPPORT. (optional)
=======================================================================================

You can set ENABLED_WON: False or leave it blank to turn it off.

WONSCAN_KEY* - used for the Won blockchain data
WON_SAFE_ADDR* - Won address. All WON and ERC-20 (WON) deposits go there
---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_CORE" = "True" ]; then    
 
    export ENABLED_CORE
    export COMMON_TASKS_CORE
    export CORESCAN_KEY
    export CORE_SAFE_ADDR

    echo "ENABLED_CORE: $ENABLED_CORE"
    echo "COMMON_TASKS_CORE: $COMMON_TASKS_CORE"
    echo "CORESCAN_KEY: $CORESCAN_KEY"
    echo "CORE_SAFE_ADDR: $CORE_SAFE_ADDR"
else
    echo "WON Blockchain support is disabled."
fi

echo "`cat <<YOLLOPUKKI

=======================================================================================
 STEP 7.1 of 12. WON BLOCKCHAIN, WON and USDT WON SUPPORT. (optional)
=======================================================================================

You can set ENABLED_WON: False or leave it blank to turn it off.

WONSCAN_KEY* - used for the Won blockchain data
WON_SAFE_ADDR* - Won address. All WON and ERC-20 (WON) deposits go there
---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_FUSE" = "True" ]; then    
 
    export ENABLED_FUSE
    export COMMON_TASKS_FUSE
    export FUSESCAN_KEY
    export FUSE_SAFE_ADDR

    echo "ENABLED_FUSE: $ENABLED_FUSE"
    echo "COMMON_TASKS_FUSE: $COMMON_TASKS_FUSE"
    echo "FUSESCAN_KEY: $FUSESCAN_KEY"
    echo "FUSE_SAFE_ADDR: $FUSE_SAFE_ADDR"
else
    echo "WON Blockchain support is disabled."
fi

echo "`cat <<YOLLOPUKKI

=======================================================================================
 STEP 7.1 of 12. WON BLOCKCHAIN, WON and USDT WON SUPPORT. (optional)
=======================================================================================

You can set ENABLED_WON: False or leave it blank to turn it off.

WONSCAN_KEY* - used for the Won blockchain data
WON_SAFE_ADDR* - Won address. All WON and ERC-20 (WON) deposits go there
---------------------------------------------------------------------------------------

YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env


if [ "$ENABLED_AVAX" = "True" ]; then    
 
    export ENABLED_AVAX
    export COMMON_TASKS_AVAX
    export AVAXSCAN_KEY
    export AVAX_SAFE_ADDR

    echo "ENABLED_AVAX: $ENABLED_AVAX"
    echo "COMMON_TASKS_AVAX: $COMMON_TASKS_AVAX"
    echo "AVAXSCAN_KEY: $AVAXSCAN_KEY"
    echo "AVAX_SAFE_ADDR: $AVAX_SAFE_ADDR"
else
    echo "WON Blockchain support is disabled."
fi

echo "`cat <<YOLLOPUKKI


===========================================================
     STEP 8 OF 12. EMAIL SERVICE
===========================================================

Used for sending notifications and alerts.

-----------------------------------------------------------
YOLLOPUKKI`"
source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
export EMAIL_HOST
export EMAIL_HOST_USER
export EMAIL_HOST_PASSWORD
export EMAIL_PORT
export EMAIL_USE_TLS

echo "EMAIL_HOST: $EMAIL_HOST"
echo "EMAIL_HOST_USER: $EMAIL_HOST_USER"
echo "EMAIL_HOST_PASSWORD: $EMAIL_HOST_PASSWORD"
echo "EMAIL_PORT: $EMAIL_PORT"
echo "EMAIL_USE_TLS: $EMAIL_USE_TLS"


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 9 OF 12. SMS SERVICE TWILIO (optional)
===========================================================

Used for sending notifications and alerts. 
You can set IS_SMS_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"
source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
if [ "$IS_SMS_ENABLED" = "True" ]; then
    export IS_SMS_ENABLED
    export TWILIO_ACCOUNT_SID
    export TWILIO_AUTH_TOKEN
    export TWILIO_VERIFY_SID
    export TWILIO_PHONE

    echo "IS_SMS_ENABLED: $IS_SMS_ENABLED"
    echo "TWILIO_ACCOUNT_SID: $TWILIO_ACCOUNT_SID"
    echo "TWILIO_AUTH_TOKEN: $TWILIO_AUTH_TOKEN"
    echo "TWILIO_VERIFY_SID: $TWILIO_VERIFY_SID"
    echo "TWILIO_PHONE: $TWILIO_PHONE"
else
    echo "SMS Service is disabled."
fi

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 10 OF 12. KYC PROVIDER SUMSUB (OPTIONAL)
===========================================================

Used for KYC. 
You can set IS_KYC_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
if [ "$IS_KYC_ENABLED" = "True" ]; then
    export IS_KYC_ENABLED
    export SUMSUB_SECRET_KEY
    export SUMSUB_APP_TOKEN
    export SUMSUM_CALLBACK_VALIDATION_SECRET

    echo "IS_KYC_ENABLED: $IS_KYC_ENABLED"
    echo "SUMSUB_SECRET_KEY: $SUMSUB_SECRET_KEY"
    echo "SUMSUB_APP_TOKEN: $SUMSUB_APP_TOKEN"
    echo "SUMSUM_CALLBACK_VALIDATION_SECRET: $SUMSUM_CALLBACK_VALIDATION_SECRET"
else
    echo "KYC Service is disabled."
fi


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 11 OF 12. KYT PROVIDER SCORECHAIN (OPTIONAL)
===========================================================

Used for KYT. 
You can set IS_KYT_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
if [ "$IS_KYT_ENABLED" = "True" ]; then
    export IS_KYT_ENABLED
    export SCORECHAIN_BITCOIN_TOKEN
    export SCORECHAIN_ETHEREUM_TOKEN
    export SCORECHAIN_TRON_TOKEN
    export SCORECHAIN_BNB_TOKEN

    echo "IS_KYT_ENABLED: $IS_KYT_ENABLED"
    echo "SCORECHAIN_BITCOIN_TOKEN: $SCORECHAIN_BITCOIN_TOKEN"
    echo "SCORECHAIN_ETHEREUM_TOKEN: $SCORECHAIN_ETHEREUM_TOKEN"
    echo "SCORECHAIN_TRON_TOKEN: $SCORECHAIN_TRON_TOKEN"
    echo "SCORECHAIN_BNB_TOKEN: $SCORECHAIN_BNB_TOKEN"
else
    echo "KYT Service is disabled."
fi

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 12 OF 12. MARKET MAKING BOT - HUMMINGBOT (OPTIONAL)
===========================================================

Used for market making and other strategies.
You can set IS_HUMMINGBOT_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"

source "$(dirname "$0")/config.env"

# Sử dụng các biến đã được đọc từ config.env
if [ "$IS_KYT_ENABLED" = "True" ]; then
    export IS_KYT_ENABLED
    export SCORECHAIN_BITCOIN_TOKEN
    export SCORECHAIN_ETHEREUM_TOKEN
    export SCORECHAIN_TRON_TOKEN
    export SCORECHAIN_BNB_TOKEN

    echo "IS_KYT_ENABLED: $IS_KYT_ENABLED"
    echo "SCORECHAIN_BITCOIN_TOKEN: $SCORECHAIN_BITCOIN_TOKEN"
    echo "SCORECHAIN_ETHEREUM_TOKEN: $SCORECHAIN_ETHEREUM_TOKEN"
    echo "SCORECHAIN_TRON_TOKEN: $SCORECHAIN_TRON_TOKEN"
    echo "SCORECHAIN_BNB_TOKEN: $SCORECHAIN_BNB_TOKEN"
else
    echo "KYT Service is disabled."
fi

#echo "Instance name"
INSTANCE_NAME='opencex'
export INSTANCE_NAME

#echo "Postgres credentials - user, database name, password, server address and port"
DB_NAME=opencex
DB_USER=opencex
DB_PASS=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
DB_HOST=postgresql
DB_PORT=5432
export DB_NAME
export DB_USER
export DB_PASS
export DB_HOST
export DB_PORT

#echo "RabbitMQ credentials - user, password, server address and port"
AMQP_USER=opencex
AMQP_PASS=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
AMQP_HOST=rabbitmq
AMQP_PORT=5672
export AMQP_USER
export AMQP_PASS
export AMQP_HOST
export AMQP_PORT

#echo "Bitcoin node credentials - user, password, server address and port"
BTC_NODE_USER=opencex
BTC_NODE_PASS=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
BTC_NODE_PORT=8332
BTC_NODE_HOST=bitcoind
export BTC_NODE_USER
export BTC_NODE_PASS
export BTC_NODE_PORT
export BTC_NODE_HOST

#echo "Redis credentials - server address and port"
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASS=
export REDIS_HOST
export REDIS_PORT
export REDIS_PASS

#echo "the address where bots can directly access the django instance"
BOTS_API_BASE_URL=http://opencex:8080
export BOTS_API_BASE_URL

# key for encrypting private keys in the database (generated automatically)
CRYPTO_KEY=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;)
export CRYPTO_KEY

# bot user password
BOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;)
export BOT_PASSWORD

envsubst < /app/opencex/backend/.env.template > /app/opencex/backend/.env

fi

source /app/opencex/backend/.env
set -a
cd /app/opencex/frontend || exit
FILE=/app/opencex/frontend/src/local_config

if test ! -f "$FILE"; then
envsubst < /app/opencex/frontend/src/example.local_config.js > /app/opencex/frontend/src/local_config
### save to env

cat << EOF >> /app/opencex/backend/.env


#opencex frontend values
RECAPTCHA=$RECAPTCHA
TELEGRAM=$TELEGRAM
TG_NEWS=$TG_NEWS
SUPPORT_EMAIL=$SUPPORT_EMAIL
FACEBOOK=$FACEBOOK
TWITTER=$TWITTER
LINKEDIN=$LINKEDIN
EOF

fi

##################
# START BUILDING!
##################


# build front
mkdir -p /app/opencex/frontend/deploy/
cp /app/deploy/frontend/Dockerfile /app/opencex/frontend/deploy/Dockerfile
cp /app/deploy/frontend/default.conf /app/opencex/frontend/deploy/default.conf
cp /app/deploy/frontend/nginx.conf /app/opencex/frontend/deploy/nginx.conf
sed -i "s/ADMIN_BASE_URL/$ADMIN_BASE_URL/g" /app/opencex/frontend/deploy/default.conf
sed -i "s/DOMAIN/$DOMAIN/g" /app/opencex/frontend/deploy/default.conf
docker build -t frontend -f deploy/Dockerfile .

# build nuxt
mkdir -p /app/opencex/nuxt/deploy/
cd /app/opencex/nuxt || exit
cp /app/deploy/nuxt/.env.template /app/opencex/nuxt/
cp /app/deploy/nuxt/Dockerfile /app/opencex/nuxt/deploy/Dockerfile
envsubst < /app/opencex/nuxt/.env.template > /app/opencex/nuxt/.env
docker build -t nuxt -f deploy/Dockerfile .

# build admin
mkdir -p /app/opencex/admin/deploy/
cd /app/opencex/admin || exit
cp /app/deploy/admin/Dockerfile /app/opencex/admin/deploy/Dockerfile
cp /app/deploy/admin/default.conf /app/opencex/admin/deploy/default.conf
cp /app/deploy/admin/.env.template /app/opencex/admin/
sed -i "s/ADMIN_BASE_URL/$ADMIN_BASE_URL/g" /app/opencex/admin/deploy/default.conf
envsubst < /app/opencex/admin/.env.template > /app/opencex/admin/src/local_config.js
docker build -t admin -f deploy/Dockerfile .


# build backend
cd /app/opencex/backend/ || exit
chmod +x /app/opencex/backend/manage.py
docker build -t opencex .


### install Caddy

mkdir /app/opencex -p
cd /app/opencex || exit
mkdir caddy_data postgresql_data redis_data rabbitmq_data rabbitmq_logs bitcoind_data -p
chmod 777 caddy_data postgresql_data redis_data rabbitmq_data rabbitmq_logs bitcoind_data
docker network create caddy

cat << EOF > docker-compose.yml
version: "3.9"
networks:
  caddy:
    external: true
services:
    opencex:
     container_name: opencex
     image: opencex:latest
     command: gunicorn  exchange.wsgi:application   -b 0.0.0.0:8080 -w 2 --access-logfile - --error-logfile -
#     entrypoint: tail -f /dev/null
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind

    opencex-wss:
     container_name: opencex-wss
     image: opencex:latest
     command: daphne -b 0.0.0.0 exchange.asgi:application  --ping-interval 600 --ping-timeout 600
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-cel:
     container_name: opencex-cel
     image: opencex:latest
     command: celery -A exchange worker -l info -n general -B -s /tmp/cebeat.db -X btc,eth_new_blocks,eth_deposits,eth_payouts,eth_check_balances,eth_accumulations,eth_tokens_accumulations,eth_send_gas,bnb_new_blocks,bnb_deposits,bnb_payouts,bnb_check_balances,bnb_accumulations,bnb_tokens_accumulations,bnb_send_gas,trx_new_blocks,trx_deposits,trx_payouts,trx_check_balances,trx_accumulations,trx_tokens_accumulations,matic_new_blocks,matic_deposits,matic_payouts,matic_check_balances,matic_accumulations,matic_tokens_accumulations,won_new_blocks,won_deposits,won_payouts,won_check_balances,won_accumulations,won_tokens_accumulations
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-stack:
     container_name: opencex-stack
     image: opencex:latest
     command: python bin/stack.py
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-btc:
     container_name: opencex-btc
     image: opencex:latest
     command: /app/manage.py btcworker
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-eth-blocks:
     container_name: opencex-eth-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_new_blocks -Q eth_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-bnb-blocks:
     container_name: opencex-bnb-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n bnb_new_blocks -Q bnb_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-trx-blocks:
     container_name: opencex-trx-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n trx_new_blocks -Q trx_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-matic-blocks:
     container_name: opencex-matic-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n matic_new_blocks -Q matic_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex


    opencex-won-blocks:
     container_name: opencex-won-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n won_new_blocks -Q won_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-celo-blocks:
     container_name: opencex-celo-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n celo_new_blocks -Q celo_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex.
    opencex-core-blocks:
     container_name: opencex-core-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n core_new_blocks -Q core_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex
    opencex-fuse-blocks:
     container_name: opencex-fuse-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n fuse_new_blocks -Q fuse_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex
    opencex-avax-blocks:
     container_name: opencex-avax-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n avax_new_blocks -Q avax_new_blocks -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-deposits:
     container_name: opencex-deposits
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n deposits -Q trx_deposits,bnb_deposits,eth_deposits,matic_deposits,won_deposits,celo_deposits,core_deposits,fuse_deposits,avax_deposits -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-payouts:
     container_name: opencex-payouts
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n payouts -Q trx_payouts,eth_payouts,bnb_payouts,matic_payouts,won_payouts,celo_payouts,core_payouts,fuse_payouts,avax_payouts -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-balances:
     container_name: opencex-balances
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n check_balances -Q trx_check_balances,bnb_check_balances,eth_check_balances,matic_check_balances,won_check_balances,celo_check_balances,core_check_balances,fuse_check_balances,avax_check_balances -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-coin-accumulations:
     container_name: opencex-coin-accumulations
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n coin_accumulations -Q trx_accumulations,bnb_accumulations,eth_accumulations,matic_accumulations,won_accumulations,celo_accumulations,core_accumulations,fuse_accumulations,avax_accumulations -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-token-accumulations:
     container_name: opencex-token-accumulations
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n tokens_accumulations -Q trx_tokens_accumulations,bnb_tokens_accumulations,eth_tokens_accumulations,matic_tokens_accumulations,won_tokens_accumulations,celo_tokens_accumulations,core_tokens_accumulations,fuse_tokens_accumulations,avax_tokens_accumulations -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    opencex-gas:
     container_name: opencex-gas
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n send_gas -Q trx_send_gas,bnb_send_gas,eth_send_gas,matic_send_gas,won_send_gas,celo_send_gas,core_send_gas,fuse_send_gas,avax_send_gas -c 1 "
     restart: always
     volumes:
      - /app/opencex/backend:/app
     networks:
      - caddy
     depends_on:
      - postgresql
      - redis
      - rabbitmq
      - frontend
      - nuxt
      - caddy
      - bitcoind
      - opencex

    frontend:
     image: frontend:latest
     container_name: frontend
     restart: always
     volumes:
     - /app/opencex/backend:/app
     networks:
     - caddy
     labels:
      caddy: $DOMAIN
      caddy.reverse_proxy: "{{upstreams 80}}"
    nuxt:
     image: nuxt:latest
     container_name: nuxt
     restart: always
     networks:
     - caddy
    admin:
     image: admin:latest
     container_name: admin
     restart: always
     networks:
     - caddy
    caddy:
      image: lucaslorentz/caddy-docker-proxy:latest
      restart: always
      ports:
        - 80:80
        - 443:443
      environment:
        - CADDY_INGRESS_NETWORKS=caddy
      networks:
        - caddy
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        - ./caddy_data:/data

    postgresql:
     container_name: postgresql
     hostname: postgresql
     restart: always
     image: postgres:latest
     shm_size: 1g
     volumes:
        - ./postgresql_data:/var/lib/postgresql/data
     environment:
       POSTGRES_USER: "$DB_USER"
       POSTGRES_PASSWORD: "$DB_PASS"
       POSTGRES_DB: "$DB_NAME"
     networks:
      - caddy

    redis:
     container_name: redis
     restart: always
     image: redis:latest
     volumes:
         - ./redis_data:/data
     entrypoint: redis-server
     networks:
       - caddy
    rabbitmq:
     hostname: rabbitmq
     container_name: rabbitmq
     restart: always
     image: rabbitmq:3.9.22-management
     volumes:
         - ./rabbitmq_data/:/var/lib/rabbitmq/
         - ./rabbitmq_logs/:/var/log/rabbitmq/
     environment:
         RABBITMQ_DEFAULT_USER: $AMQP_USER
         RABBITMQ_DEFAULT_PASS: $AMQP_PASS
         RABBITMQ_DEFAULT_VHOST: /
     networks:
       - caddy
     labels:
       caddy: $RMQDOMAIN
       caddy.reverse_proxy: "{{upstreams http 15672}}"
    bitcoind:
      container_name: bitcoind
      restart: always
      image: lncm/bitcoind:v24.0.1
      volumes:
      - ./bitcoind_data/:/data/.bitcoin/
      networks:
      - caddy
EOF

# build hummingbot
if [ "$IS_HUMMINGBOT_ENABLED" = "True" ]; then
cd /app/opencex || exit
git clone  https://github.com/Polygant/hummingbot.git ./hmbot
cd ./hmbot
docker build -t hummingbot:latest -f Dockerfile --target=release .
cat << EOF >> /app/opencex/docker-compose.yml
    hummingbot:
     container_name: hummingbot
     hostname: hummingbot
     restart: always
     image: hummingbot:latest
     volumes:
       - /app/opencex/hmbot/conf:/home/hummingbot/conf
       - /app/opencex/hmbot/conf/connectors:/home/hummingbot/conf/connectors
       - /app/opencex/hmbot/conf/strategies:/home/hummingbot/conf/strategies
       - /app/opencex/hmbot/logs:/home/hummingbot/logs
       - /app/opencex/hmbot/data:/home/hummingbot/data
       - /app/opencex/hmbot/scripts:/home/hummingbot/scripts
     networks:
       - caddy
     tty: true
     stdin_open: true
EOF
fi
cd /app/opencex
docker compose up -d

docker stop opencex-cel opencex-wss
sleep 5;
docker exec -it opencex python ./manage.py migrate
docker exec -it opencex python ./manage.py collectstatic
docker compose up -d



cd /app/opencex || exit
docker compose stop
cat << EOF > /app/opencex/bitcoind_data/bitcoin.conf
rpcuser=$BTC_NODE_USER
rpcpassword=$BTC_NODE_PASS
rpcallowip=0.0.0.0/0
rpcbind=0.0.0.0
rpcport=$BTC_NODE_PORT
prune=20000
wallet=/data/.bitcoin/opencex

EOF
docker compose up -d
sleep 30;
docker exec -it bitcoind bitcoin-cli -named createwallet wallet_name="opencex" descriptors=false
docker restart bitcoind
sleep 30;
docker exec -it opencex python wizard.py
cd /app/opencex || exit
docker compose stop
docker compose up -d

### Registration of the installation OpenCEX
curl --location 'http://alertbot.plgdev.com/registration' \
--header 'Content-Type: application/json' \
--data "{\"domain\": \"${DOMAIN}\"}"


# cleanup
# cd /app/opencex && docker compose down
# rm -rf /app
# docker system prune -a
