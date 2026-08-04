# 🚀 Homelab DevOps

Projeto criado para transformar um notebook antigo em um servidor doméstico, simulando um ambiente real de infraestrutura e DevOps.

O objetivo é hospedar aplicações, automatizar deploys, aplicar boas práticas de segurança e implementar observabilidade.

## Hardware

- Notebook: HP 1000
- Processador: Intel Core i3 de 2ª geração
- Memória RAM: 6 GB
- Armazenamento: SSD de 256 GB
- Rede: Wi-Fi e Ethernet

## Sistema operacional

- Debian 13
- Instalação mínima
- Sem interface gráfica
- Acesso remoto via SSH

## Status atual

- [x] Instalação do Debian Server
- [x] Configuração do hostname
- [x] Criação de usuário administrativo
- [x] Instalação do servidor SSH
- [x] Acesso remoto pela rede local
- [ ] Atualização e configuração inicial
- [ ] Segurança do servidor
- [ ] Docker
- [ ] Docker Compose
- [ ] Deploy de aplicações
- [ ] CI/CD
- [ ] Observabilidade
- [ ] Cloudflare Tunnel
- [ ] Kubernetes com K3s
- [ ] GitOps com ArgoCD

## Arquitetura planejada

```text
Internet
   |
Cloudflare Tunnel
   |
Reverse Proxy
   |
Docker
├── Aplicações
├── PostgreSQL
├── MinIO
├── Portainer
└── Observabilidade