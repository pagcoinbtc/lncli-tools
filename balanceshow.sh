#!/bin/bash

# Define o caminho completo para o comando lncli
readonly lncli='@/seu/caminho/lncli@ lncli'

# Executa o comando para listar os canais e captura o stdout
result="$(${lncli} 'listchannels')"

# Extrai as informações necessárias e calcula as porcentagens
echo "$result" | jq -r '.channels[] | [.peer_alias, .local_balance, .remote_balance] | @tsv' | while IFS=$'\t' read -r alias local_balance remote_balance; do
    # Certifique-se de que os valores não são nulos ou vazios
    if [[ -n "$local_balance" && -n "$remote_balance" && -n "$alias" ]]; then
        # Calcula o total, porcentagens e desenha os balanços
        total_balance=$((local_balance + remote_balance))
        local_percent=$((local_balance * 100 / total_balance))
        remote_percent=$((remote_balance * 100 / total_balance))

        # Desenha os emojis de acordo com as porcentagens
        local_emojis=$(printf "🟢%.0s" $(seq 1 $((local_percent / 10))))
        remote_emojis=$(printf "🔴%.0s" $(seq 1 $((remote_percent / 10))))

        echo "Alias: $alias"
        echo "🟢 Local Balance: $local_balance - $local_percent%"
        echo "🔴 Remote Balance: $remote_balance - $remote_percent%"
        echo "$local_emojis$remote_emojis"
        echo ""
    fi
done
