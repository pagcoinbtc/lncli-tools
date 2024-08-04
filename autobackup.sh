#!/bin/bash
# Script para copiar a pasta do node para o backup com compressão e logs

# Variáveis
SOURCE_DIR="@origin/backup@"
TEMP_DIR="/tmp/lnd_backup_temp"
DEST_DIR="@/mnt/backup@"
DEST_USER="@umbrel@"
DEST_HOST="@192.168.0.100@"
PASSWORD="@youpassword@"
LOG_FILE="$HOME/backup.log"
DATE=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="@yourfolder@_backup_$DATE.tar.gz"

# Função para registrar logs
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $LOG_FILE
}

# Início do backup
log "Iniciando o processo de backup."

# Criando uma cópia temporária do diretório usando rsync
log "Criando uma cópia temporária do diretório $SOURCE_DIR."
rsync -a --delete $SOURCE_DIR/ $TEMP_DIR/
if [ $? -eq 0 ]; then
    log "Cópia temporária criada com sucesso."
else
    log "Erro ao criar a cópia temporária."
    exit 1
fi

# Criando o arquivo tar.gz a partir da cópia temporária
log "Compactando o diretório temporário $TEMP_DIR."
tar -czf /tmp/$ARCHIVE_NAME -C $TEMP_DIR .
if [ $? -eq 0 ]; then
    log "Arquivo $ARCHIVE_NAME criado com sucesso."
else
    log "Erro ao criar o arquivo $ARCHIVE_NAME."
    exit 1
fi

# Enviando o arquivo para o destino
log "Enviando o arquivo para $DEST_USER@$DEST_HOST:$DEST_DIR."
sshpass -p $PASSWORD scp -o StrictHostKeyChecking=no /tmp/$ARCHIVE_NAME $DEST_USER@$DEST_HOST:$DEST_DIR
if [ $? -eq 0 ]; then
    log "Arquivo $ARCHIVE_NAME enviado com sucesso."
else
    log "Erro ao enviar o arquivo $ARCHIVE_NAME."
    exit 1
fi

# Removendo o arquivo temporário local
log "Removendo o arquivo temporário /tmp/$ARCHIVE_NAME."
rm /tmp/$ARCHIVE_NAME
if [ $? -eq 0 ]; then
    log "Arquivo temporário removido com sucesso."
else
    log "Erro ao remover o arquivo temporário."
    exit 1
fi

# Removendo a cópia temporária
log "Removendo a cópia temporária $TEMP_DIR."
rm -rf $TEMP_DIR
if [ $? -eq 0 ]; then
    log "Cópia temporária removida com sucesso."
else
    log "Erro ao remover a cópia temporária."
    exit 1
fi

# Fim do backup
log "Backup concluído com sucesso."
