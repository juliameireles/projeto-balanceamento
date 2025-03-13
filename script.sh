#!/bin/bash

# Obtém o nome do hostname do sistema
hostname=$(hostname)

# Define o caminho do diretório do site
site_dir="/var/www/html/${hostname}.com"


# Verifica se o httpd está instalado 
if rpm -q httpd &>/dev/null; then
   echo "O apache HTTPD já está instalado, realizando remoção..."
   sudo yum remove -y httpd

else
  echo "O apache não está instalado, instalando versão mais recente"

fi

# atualiza repositorio de pacotes
sudo yum update -y


# instala a versão mais recente do httpd
sudo yum install -y httpd


# Verifica se a instalação foi bem-sucedida

if rpm -q httpd &>/dev/null; then
   echo "Apache HTTPD instalado com sucesso!"


  # Inicia serviço e habilita no boot
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo " Serviço HTTPD foi iniciado e configurado para iniciar automaticamente no boot"

else 
 echo "Houve erro ao instalar o apache HTTPD"
 exit 1


 fi


# Verifica se o PHP está instalado
if rpm -q php &>/dev/null; then
    echo "O PHP já está instalado. Removendo a versão antiga..."
    sudo yum remove -y php php-cli php-common php-mysql php-pdo php-gd php-xml php-mbstring
else
    echo "O PHP não está instalado. Instalando a versão mais recente..."

fi


# Instalar o repositório EPEL e Remi (necessário para PHP mais atualizado no CentOS 7)
sudo yum install -y epel-release yum-utils
sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php74  # Habilita o repositório do PHP 7.4


# Instala o PHP mais recente disponível para o CentOS 7 (alterável para outras versões)
sudo yum install -y php php-cli php-common php-mysql php-pdo php-gd php-xml php-mbstring

# Verifica se a instalação do PHP foi bem-sucedida
if rpm -q php &>/dev/null; then
    echo "PHP instalado com sucesso!"
else
    echo "Houve um erro na instalação do PHP."
    exit 1
fi

# Criação do diretório baseado no hostname
if [ ! -d "$site_dir" ]; then
    echo "Criando diretório para o site em: $site_dir"
    sudo mkdir -p "$site_dir"
else
    echo "Diretório $site_dir já existe."
fi






# Reinicia o serviço Apache para aplicar as mudanças
sudo systemctl restart httpd
echo "O Apache HTTPD foi reiniciado para carregar o PHP corretamente."

echo "Instalação concluída! Apache e PHP estão rodando na máquina."
echo "Diretório do site criado em: $site_dir"
