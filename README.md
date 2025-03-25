# 🔄 Balanceador de Carga com Automação via Shell Script

Este projeto demonstra como configurar um **balanceador de carga** com duas máquinas virtuais, hospedadas em **uma nuvem privada**, utilizando **Apache, PHP e Virtual Hosts** com **automação via Shell Script**.

Você pode testar o balanceamento diretamente na sua máquina! Para isso, basta apontar o nome do domínio `www.juliabalancer.com` para o IP do balanceador de carga, editando o arquivo de hosts do seu sistema operacional.

---

## 🌐 Acesso Local ao Balanceador

Adicione a seguinte linha ao seu arquivo de hosts:

```
200.152.47.3   www.juliabalancer.com
```

Isso cria um mapeamento local do domínio para o IP público do balanceador.

---

## 💻 Como adicionar no seu sistema:

### 🪟 Windows
1. Abra o **Bloco de Notas como administrador**.
2. Acesse o caminho:
   ```
   C:\Windows\System32\drivers\etc\hosts
   ```
3. Adicione a linha ao final do arquivo:
   ```
   200.152.47.3   www.juliabalancer.com
   ```
4. Salve e feche.

---

### 🐧 Linux
```bash
sudo nano /etc/hosts
```
Adicione ao final:
```
200.152.47.3   www.juliabalancer.com
```
Salve (Ctrl + O) e saia (Ctrl + X).

---

### 🍎 macOS
```bash
sudo nano /etc/hosts
```
Adicione:
```
200.152.47.3   www.juliabalancer.com
```
Salve e saia (Ctrl + O, depois Ctrl + X).

---

## ✅ Acessando a Aplicação

Abra o navegador e acesse:

```
http://www.juliabalancer.com
```

Você verá o conteúdo da aplicação servida pelas VMs por meio do balanceador de carga.

---
```