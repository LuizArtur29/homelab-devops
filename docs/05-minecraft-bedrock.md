# Minecraft Bedrock Dedicated Server

## Objetivo

Hospedar um servidor Minecraft Bedrock no homelab para dois jogadores.

## Tecnologia

Foi utilizada a imagem:

```text
itzg/minecraft-bedrock-server
```

executada através de Docker Compose.

## Estrutura

```text
/srv/compose/minecraft/
└── compose.yaml
```

Dados:

```text
/srv/minecraft/data
```

Backups:

```text
/srv/minecraft/backups
```

## Porta

Minecraft Bedrock utiliza:

```text
19132/UDP
```

O container publica:

```text
0.0.0.0:19132 -> 19132/udp
```

## Configuração

A configuração foi dimensionada para apenas dois jogadores.

Entre os parâmetros utilizados estão:

```yaml
MAX_PLAYERS: "2"
VIEW_DISTANCE: "10"
TICK_DISTANCE: "4"
ONLINE_MODE: "true"
```

O container recebeu limite de memória compatível com o hardware disponível.

## Persistência

O diretório `/data` do container é persistido no host:

```text
/srv/minecraft/data
```

Assim, o mundo não depende do ciclo de vida do container.

## Mundo

O mundo atual foi migrado de um Minecraft Realm existente.

O nome utilizado pelo servidor é:

```text
realm-luiz-lolo
```

## Iniciar

```bash
cd /srv/compose/minecraft
docker compose up -d
```

## Parar

```bash
docker compose stop
```

## Logs

```bash
docker compose logs -f
```

Durante uma inicialização normal deve aparecer:

```text
Server started.
```

## Healthcheck

O container possui healthcheck.

Estado:

```bash
docker ps
```

O estado esperado depois da inicialização é:

```text
healthy
```

Detalhes:

```bash
docker inspect minecraft-bedrock \
  --format '{{json .State.Health}}'
```

## Acesso local

Dentro da LAN:

```text
Servidor: 192.168.10.9
Porta: 19132
```

## Acesso externo

O acesso externo é realizado através do playit.gg.

Isso evita a necessidade de port forwarding tradicional em uma conexão atrás de CGNAT.

## Online Mode

Foi mantido:

```yaml
ONLINE_MODE: "true"
```

Isso mantém a autenticação dos jogadores através dos serviços oficiais do Minecraft.

## Resultado

O Minecraft Bedrock Dedicated Server está executando em Docker, com persistência e acesso local e remoto.