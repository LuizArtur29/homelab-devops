# Instalação do Debian Server

> **Data:** 04/08/2026
>
> **Status:** ✅ Concluído
>
> **Versão do documento:** 1.0

## Objetivo

Instalar um sistema Linux mínimo no notebook HP 1000 para utilizá-lo como servidor doméstico e laboratório DevOps.

## Hardware utilizado

- **Modelo:** HP 1000
- **Processador:** Intel Core i3 de 2ª geração
- **Memória RAM:** 6 GB
- **Armazenamento:** SSD de 256 GB
- **Rede utilizada durante a instalação:** Wi-Fi
- **Mídia de instalação:** pendrive com Ventoy

## Sistema instalado

- Debian 13
- Arquitetura `amd64`
- Instalação sem interface gráfica
- SSH Server
- Standard system utilities

## Preparação

A imagem ISO do Debian foi copiada para um pendrive com Ventoy.

O notebook possui suporte aos seguintes modos de inicialização:

- UEFI
- Legacy

A instalação foi iniciada em modo UEFI.

## Problema encontrado

Durante o boot pelo Ventoy, foi exibido o seguinte erro:

```text
Verification failed: (0x1A)
```

## Solução

O Secure Boot foi desativado na BIOS do notebook.

Depois dessa alteração, o Ventoy iniciou normalmente e permitiu selecionar a imagem ISO do Debian.

## Configurações escolhidas

### Hostname

```text
homelab
```

### Domínio

O campo de domínio foi deixado em branco.

### Conta root

A senha da conta `root` foi deixada em branco.

Dessa forma, o login direto como `root` permanece desabilitado, e o usuário administrativo utiliza `sudo` para executar comandos com privilégios elevados.

### Particionamento

Foi escolhida a instalação guiada utilizando todo o SSD.

Opção selecionada:

```text
Guided - use entire disk
```

Os arquivos foram mantidos em uma única partição para simplificar a administração inicial do servidor.

### Seleção de software

Foram selecionados somente:

- SSH server
- Standard system utilities

A interface gráfica do Debian não foi instalada para reduzir o uso de memória e processamento.

## Validações realizadas

Após a instalação, foram executados os seguintes comandos:

```bash
hostname
ip -br a
ping -c 4 debian.org
sudo systemctl status ssh
```

## Resultado

O servidor iniciou corretamente e recebeu um endereço IP na rede local por meio da interface Wi-Fi.

O acesso remoto foi validado com:

```bash
ssh usuario@IP_DO_SERVIDOR
```

Após o login remoto, foram confirmados o hostname e o usuário conectado com:

```bash
hostname
whoami
```

## Aprendizados

Durante esta etapa, foram estudados os seguintes conceitos:

- diferença entre uma instalação desktop e uma instalação server;
- funcionamento de UEFI e Legacy Boot;
- relação entre Secure Boot e Ventoy;
- configuração de hostname;
- instalação mínima do Debian;
- uso básico de SSH;
- identificação de interfaces e endereços IP;
- administração remota de um servidor Linux.

## Próxima etapa

Realizar a configuração inicial do sistema:

- atualização de pacotes;
- configuração do timezone;
- sincronização de horário;
- instalação de ferramentas administrativas;
- configuração do comportamento da tampa do notebook;
- segurança do SSH;
- configuração do firewall.