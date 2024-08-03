# lncli-tools 🔧

Estas são minhas ferramentas pessoais que utilizo a fim de administrar meu node Lightning. São ferramentas pensadas na simplicidade, pois quanto mais UI, mais chance de incompatibilidade. Keep it simple! 🛠️

Elas estão adaptadas para apontar onde você deve mudar suas informações. Sempre que houver `@algo-entre-arrobas@`, deve ser substituído por suas informações pessoais. ✍️

# autobackup.sh

Necessita da intalação do sshpass, `apt-get update` e `sudo apt-get install sshpass`.
Depois será necessário logar via ssh para coletar o fingerprint `ssh user@ipdestino`.

Após logar como usuário digitando a senha é necessário `sudo chown user:user /media/backup` no diretório de destino e em seguida `sudo chmod 775 /media/backup
`.

Teste manualmente o script com `./autobackup.sh` e chequee o diretório de destino.
