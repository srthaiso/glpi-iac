#!/bin/bash

echo "Atualizando o sistema operacional"

apt-get update -y
apt-get upgrade -y

echo "Criando backup do diretório GLPI"

cp -R /var/www/html/glpi/ /tmp/glpi_backup_$(date +%F_%T)

echo "Deletando diretório do GLPI"

cd /var/www/html

rm -rf glpi

echo "Realizando download da nova versão"

cd /tmp

wget https://github.com/glpi-project/glpi/releases/download/10.0.18/glpi-10.0.18.tgz

echo "Descompactando a nova versão e enviando diretório para html"

tar -zxvf glpi-10.0.18.tgz -C /var/www/html

echo "Parando serviço httpd e restaurando diretórios de configuração do GLPI"

systemctl stop apache2

cd /var/www/html/glpi

mv config config_bkp
mv plugins plugins_bkp
mv files files_bkp
mv marketplace marketplace_bkp

cp -R /tmp/glpi_backup/config/ /var/www/html/glpi
cp -R /tmp/glpi_backup/plugins/ /var/www/html/glpi
cp -R /tmp/glpi_backup/files/ /var/www/html/glpi
cp -R /tmp/glpi_backup/marketplace/ /var/www/html/glpi

echo "Aplicando permissão no diretório do GLPI"

chown -R www-data:www-data /var/www/html/glpi
chmod -R 775 /var/www/html/glpi

echo "Iniciando serviço httpd"

systemctl start apache2

echo "Atualizando banco de dados"

cd /var/www/html/glpi/bin

echo "Atualizando referência no banco de dados"

# Essa etapa executa a atualização da estrutura do banco de dados do GLPI.
# O comando abaixo verifica se há mudanças na estrutura da nova versão e aplica essas alterações automaticamente.
# A flag '-y' aceita todos os prompts automaticamente, tornando o processo 100% não-interativo.
# Importante: essa ação deve ser feita com o serviço Apache parado para evitar problemas durante a atualização.

cd /var/www/html/glpi/bin
./console database:update -y

echo "Atualização finalizada" 
echo At.te Ismael Nascimento"
