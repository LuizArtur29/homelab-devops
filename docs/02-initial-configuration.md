# Configuração Inicial do Servidor

## Objetivo

Realizar as configurações básicas necessárias depois da instalação do Debian.

## Atualização do sistema

O primeiro passo após a instalação foi atualizar os pacotes:

```bash
sudo apt update
sudo apt upgrade -y
```

## Informações do sistema

Alguns comandos úteis para verificar o servidor:

```bash
hostname
hostnamectl
uname -a
```

Memória:

```bash
free -h
```

Armazenamento:

```bash
df -h
```

Interfaces de rede:

```bash
ip -br a
```

Rotas:

```bash
ip route
```

## Endereço na rede local

Durante a implantação, o servidor utilizou:

```text
192.168.10.9
```

na interface Wi-Fi:

```text
wlo1
```

O endereço é utilizado para administração do servidor dentro da LAN.

> Em uma implantação permanente, é recomendável criar uma reserva DHCP no roteador para evitar alterações no endereço do servidor.

## Servidor headless

Nenhuma interface gráfica foi instalada.

A administração é realizada principalmente através de:

```bash
ssh luiz@192.168.10.9
```

## Funcionamento com a tampa fechada

O notebook foi configurado para continuar funcionando com a tampa fechada.

Isso permite utilizá-lo fisicamente como um pequeno servidor doméstico.

## Login local

Ao iniciar o Debian, o console apresenta uma tela de login.

Não é necessário realizar login local para que os serviços sejam iniciados.

Serviços gerenciados pelo `systemd` e containers configurados com política de restart podem iniciar automaticamente durante o boot.

## Gerenciamento de serviços

Alguns comandos importantes:

```bash
systemctl status NOME_DO_SERVICO
```

Iniciar:

```bash
sudo systemctl start NOME_DO_SERVICO
```

Parar:

```bash
sudo systemctl stop NOME_DO_SERVICO
```

Reiniciar:

```bash
sudo systemctl restart NOME_DO_SERVICO
```

Habilitar no boot:

```bash
sudo systemctl enable NOME_DO_SERVICO
```

## Logs

Os logs dos serviços podem ser consultados através do journal:

```bash
journalctl
```

Para um serviço específico:

```bash
sudo journalctl -u NOME_DO_SERVICO
```

Últimas 50 linhas:

```bash
sudo journalctl -u NOME_DO_SERVICO -n 50 --no-pager
```

## Resultado

O HP 1000 passou a operar como um servidor headless acessível pela rede local e preparado para receber serviços adicionais.