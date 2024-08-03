#!/bin/bash

# Define o caminho completo para o comando lncli
readonly lncli='@seu/caminho/lncli@ lncli'

# Solicita a entrada do usuário para o channel_point
read -p "Digite o channel_point do canal que deseja ajustar: " channel_point

# Solicita a entrada do usuário para os valores de base fee, fee rate e time lock delta
read -p "Digite o valor de base fee (em msat): " base_fee_msat
read -p "Digite o valor de fee rate (em ppm): " fee_rate
read -p "Digite o valor de time lock delta: " time_lock_delta

# Monta o comando lncli updatechanpolicy com os valores fornecidos
command="${lncli} 'updatechanpolicy --base_fee_msat $base_fee_msat --fee_rate $fee_rate --time_lock_delta $time_lock_delta $channel_point'"

# Executa o comando e captura o resultado
result=$(eval $command)

# Verifica se houve erro na execução do comando
if [ $? -ne 0 ]; then
    echo "Erro ao ajustar a política de fees para o canal com channel point $channel_point"
    echo "Mensagem de erro: $result"
else
    echo "Política de fees ajustada para o canal com channel point $channel_point"
    echo "Resultado: $result"
fi
