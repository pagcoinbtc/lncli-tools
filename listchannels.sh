#!/bin/bash

# Define o caminho completo para o comando lncli
readonly lncli='@seu/caminho/lncli@ lncli'

# Executa o comando para listar os canais e captura o stdout
result="$(${lncli} 'listchannels')"

# Extrai e imprime as informações necessárias (alias, remote_pubkey e channel_point)
echo "$result" | jq -r '.channels[] | "\(.peer_alias) \(.remote_pubkey) \(.channel_point)"' | while read -r alias pubkey channel_point; do
    echo "Alias: $alias"
    echo "Remote Pubkey: $pubkey"
    echo "Channel Point: $channel_point"
    echo ""
done
