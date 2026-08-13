# Arquitetura do Homelab

## Visão geral

O homelab utiliza um notebook HP 1000 executando Debian 13 como servidor headless.

A máquina funciona como laboratório para infraestrutura, containers, networking, automação e DevOps.

## Hardware

```text
HP 1000
├── Intel Core i3 2ª geração
├── 6 GB RAM
├── SSD
└── Wi-Fi
```

## Sistema

```text
Debian 13
├── OpenSSH
├── systemd
├── UFW
├── Docker
├── Docker Compose
└── playit agent
```

## Arquitetura de rede

```text
                         INTERNET
                             │
                             │
                       ┌─────▼─────┐
                       │ playit.gg │
                       └─────┬─────┘
                             │
                         túnel UDP
                             │
                       CGNAT │
                             ▼
                    ┌────────────────┐
                    │     HP 1000    │
                    │   Debian 13    │
                    │ 192.168.10.9   │
                    └───────┬────────┘
                            │
                         Docker
                            │
                            ▼
                  ┌───────────────────┐
                  │ Minecraft Bedrock │
                  │     UDP 19132     │
                  └─────────┬─────────┘
                            │
                            ▼
                     Persistent Data
                  /srv/minecraft/data
```

## Administração

Dentro da LAN:

```text
CachyOS
192.168.10.33
     │
     │ SSH / TCP 22
     ▼
HP 1000
192.168.10.9
```

O servidor não necessita de monitor, teclado ou interface gráfica durante sua operação normal.

## Minecraft

```text
Minecraft Bedrock
       │
       ▼
Docker container
       │
       ▼
/data
       │
       ▼
/srv/minecraft/data
       │
       ▼
worlds/realm-luiz-lolo
```

## Acesso externo

```text
Minecraft Client
       │
       ▼
hostname público
       │
       ▼
playit.gg
       │
       │ UDP
       ▼
127.0.0.1:19132
       │
       ▼
Minecraft Bedrock
```

## Backup

```text
systemd
   │
   ▼
minecraft-backup.timer
   │
   ▼
minecraft-backup.service
   │
   ▼
backup-minecraft.sh
   │
   ├── stop container
   │
   ├── tar.gz
   │
   ├── start container
   │
   └── retention
   │
   ▼
/srv/minecraft/backups
```

## Estrutura de armazenamento

```text
/srv/
├── compose/
│   └── minecraft/
│       └── compose.yaml
│
└── minecraft/
    ├── data/
    │   ├── server.properties
    │   ├── allowlist.json
    │   ├── permissions.json
    │   └── worlds/
    │       └── realm-luiz-lolo/
    │
    └── backups/
        ├── minecraft-YYYY-MM-DD_HH-MM-SS.tar.gz
        └── ...
```

## Inicialização

Durante o boot:

```text
Debian
   │
   ├── networking
   │
   ├── ssh
   │
   ├── docker
   │      │
   │      └── minecraft-bedrock
   │
   ├── playit
   │
   └── minecraft-backup.timer
```

Nenhuma sessão interativa precisa ser iniciada no console.

## Fluxo completo

```text
                  ┌─────────────────────┐
                  │   Jogador remoto    │
                  └──────────┬──────────┘
                             │
                             ▼
                         Internet
                             │
                             ▼
                        playit.gg
                             │
                             ▼
┌──────────────────────────────────────────────────┐
│                    HP 1000                       │
│                   Debian 13                      │
│                                                  │
│  SSH                                             │
│   │                                              │
│   ├──────── Administração                        │
│   │                                              │
│   └─────────────────────────────────────────┐    │
│                                             │    │
│  Docker                                     │    │
│    │                                        │    │
│    ▼                                        │    │
│  Minecraft Bedrock :19132                   │    │
│    │                                        │    │
│    ▼                                        │    │
│  /srv/minecraft/data                        │    │
│                                             │    │
│  systemd timer                              │    │
│    │                                        │    │
│    ▼                                        │    │
│  backup script                              │    │
│    │                                        │    │
│    ▼                                        │    │
│  /srv/minecraft/backups                     │    │
│                                             │    │
└─────────────────────────────────────────────┘    │
```

## Evoluções futuras

A arquitetura foi mantida propositalmente simples.

Possíveis expansões:

```text
Homelab
├── Minecraft
├── Reverse Proxy
├── aplicações pessoais
├── APIs
├── bancos de dados
├── Prometheus
├── Grafana
├── Loki
├── CI/CD
├── GitHub Actions
└── backup off-site
```

O objetivo é evoluir a infraestrutura conforme novos conceitos forem estudados, evitando adicionar complexidade sem necessidade.