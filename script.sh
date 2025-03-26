#!/bin/bash

# Função para verificar e instalar pacotes
install_package() {
    local package=$1
 
    if rpm -q $package &>/dev/null; then
        echo "$package já está instalado. Removendo..."
        sudo yum remove -y $package
    fi

    # Instala o pacote mais atualizado
    echo "Instalando o pacote $package..."
    sudo yum install -y $package
}

# Atualiza os repositórios do YUM
echo "Atualizando pacotes..."
sudo yum update -y


install_package httpd


install_package php


echo "Iniciando e habilitando o serviço httpd..."
sudo systemctl start httpd
sudo systemctl enable httpd

# Obtém o hostname 
hostname=$(cat /etc/hostname)

# Define o caminho do diretório web
dir="/var/www/html/www.${hostname}.com"

echo "Criando diretório: $dir"
sudo mkdir -p "$dir"
 

echo "Ajustando permissões..."
sudo chown -R apache:apache "$dir"
sudo chmod -R 755 "$dir"

# Verifica se o diretório /etc/content existe e tem arquivos antes de copiar
if [ -d "/etc/content" ] && [ "$(ls -A /etc/content 2>/dev/null)" ]; then
    echo "Copiando arquivos de /etc/content para $dir..."
    sudo cp -r /etc/content/* "$dir/"
    sudo chown -R apache:apache "$dir"
    echo "Arquivos copiados com sucesso!"
else
    echo "O diretório /etc/content não existe ou está vazio. Nenhum arquivo será copiado."
fi

# Criando o arquivo do Virtual Host no Apache
vhost_config="/etc/httpd/conf.d/${hostname}.com.conf"

echo "Criando configuração do Virtual Host: $vhost_config"

sudo bash -c "cat > $vhost_config" <<EOF
<VirtualHost *:80>
    ServerName www.${hostname}.com
    DocumentRoot $dir

    <Directory $dir>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/${hostname}_error.log
    CustomLog /var/log/httpd/${hostname}_access.log combined
</VirtualHost>
EOF


sudo chmod 644 $vhost_config


echo "Reiniciando o serviço httpd..."
sudo systemctl restart httpd

echo "Liberando a porta TCP/80 no firewalld..."
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-port=80/tcp

echo "Recarregando as regras do firewalld..."
sudo firewall-cmd --reload

echo "Verificando as regras aplicadas no firewall..."
sudo firewall-cmd --list-all

echo "Reiniciando o firewalld..."
sudo systemctl start firewalld

echo "Configuração concluída!"
echo "Virtual Host criado: $vhost_config"
echo "Verifique o status do Apache com: sudo systemctl status httpd"
echo "Verifique o status do firewalld com: sudo firewall-cmd --list-all"


echo "Parando o Apache (httpd)..."
sudo systemctl stop httpd

echo "Iniciando o Apache (httpd) novamente..."
sudo systemctl start httpd

echo "Habilitando o Apache para iniciar no boot..."
sudo systemctl enable httpd

echo "Apache reiniciado com sucesso!"
echo "Verifique o status do Apache com: sudo systemctl status httpd"
