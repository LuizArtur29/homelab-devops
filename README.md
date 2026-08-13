# Homelab DevOps

Projeto de homelab criado a partir de um notebook antigo, com o objetivo de estudar administração de servidores Linux, redes, containers, automação e práticas de DevOps em um ambiente real.

O primeiro workload implantado no servidor é um **Minecraft Bedrock Dedicated Server**, executado em Docker e acessível externamente mesmo em uma conexão residencial atrás de CGNAT.

## Hardware

| Componente | Especificação |
|---|---|
| Modelo | HP 1000 |
| Processador | Intel Core i3 de 2ª geração |
| Memória RAM | 6 GB |
| Armazenamento | SSD |
| Rede | Wi-Fi |
| Arquitetura | amd64 |

## Sistema operacional

- Debian 13
- Instalação mínima
- Sem interface gráfica
- SSH Server
- Standard system utilities

O servidor é administrado remotamente via SSH.

## Objetivos

Este projeto foi criado como laboratório para estudar e praticar:

- Linux Server
- SSH
- gerenciamento de serviços com systemd
- segurança básica de servidores
- redes
- Docker
- Docker Compose
- persistência de dados
- exposição de serviços através de CGNAT
- DNS
- troubleshooting
- automação de backups
- disaster recovery
- documentação de infraestrutura

## Arquitetura

```text
                         Internet
                            │
                            ▼
                       playit.gg
                            │
                       túnel UDP
                            │
                            ▼
                  ┌──────────────────┐
                  │     HP 1000      │
                  │    Debian 13     │
                  │                  │
                  │   Docker Engine  │
                  └────────┬─────────┘
                           │
                           ▼
                Minecraft Bedrock
                    UDP :19132
                           │
                           ▼
                   Mundo persistente
                 /srv/minecraft/data

                           │
                           ▼
                  Backup automático
               /srv/minecraft/backups