# lncli-tools 🔧

Estas são minhas ferramentas pessoais que utilizo a fim de administrar meu node Lightning. São ferramentas pensadas na simplicidade, pois quanto mais UI, mais chance de incompatibilidade. Keep it simple! 🛠️

Elas estão adaptadas para apontar onde você deve mudar suas informações. Sempre que houver `@algo-entre-arrobas@`, deve ser substituído por suas informações pessoais. ✍️

# autobackup.sh

Necessita da intalação do sshpass, `apt-get update` e `sudo apt-get install sshpass`.
Em seguida deve-se ajustar os parametros que estiverem em "variáveis" para o script saber onde deve copiar e para onde, além das credenciais de loguin para o destino, já que este script se destina a fazer um backup para outro computador na rede local.

Depois será necessário logar via ssh para coletar o fingerprint `ssh user@ipdestino`.

Após logar como usuário digitando a senha é necessário `sudo chown user:user /media/backup` no diretório de destino e em seguida `sudo chmod 775 /media/backup
`.

Teste manualmente o script com `./autobackup.sh` e chequee o diretório de destino.

Em seguida `crontab -e` e adicione a ultima linha `0 */12 * * * /caminho/do/script/autobackup.sh` para um backup a cada 12h.

# update_channel_policy.sh

Para mudar as fees do canal você deve primeiro configurar o seu `nano listchannels.sh` mudando o caminho para o seu lncli.

Em seguida configurando o mesmo caminho para o `nano update_channel_policy.sh` adicionando o cmainho para o sei lncli.

Por fim você deve rodar `./listchannels.sh`, copiar channel point do canal que vai ter suas fees mudadas e depois `update_channel_policy.sh`, colar o channel point e escolher as fees, o delta fica a sua escolha, lembrando do mínimo de 18.
