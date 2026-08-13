# Docker

## Objetivo

Utilizar containers para executar aplicações no homelab.

Docker foi escolhido para facilitar:

- isolamento;
- deploy;
- atualização;
- reprodutibilidade;
- persistência;
- gerenciamento dos serviços.

## Validação

Versão do Docker:

```bash
docker --version
```

Docker Compose:

```bash
docker compose version
```

Status do daemon:

```bash
systemctl status docker
```

## Containers

Listar containers em execução:

```bash
docker ps
```

Todos os containers:

```bash
docker ps -a
```

## Docker Compose

Os serviços do homelab são organizados utilizando Docker Compose.

Estrutura:

```text
/srv/compose/
```

O Minecraft utiliza:

```text
/srv/compose/minecraft/
```

com:

```text
compose.yaml
```

## Dados persistentes

Os dados importantes não ficam somente dentro do container.

Para o Minecraft:

```text
/srv/minecraft/data
```

Isso permite recriar ou atualizar o container sem perder o mundo.

## Logs

Com Docker Compose:

```bash
cd /srv/compose/minecraft
docker compose logs
```

Acompanhar:

```bash
docker compose logs -f
```

Últimas linhas:

```bash
docker compose logs --tail=50
```

Diretamente pelo container:

```bash
docker logs minecraft-bedrock
```

## Controle do serviço

Subir:

```bash
docker compose up -d
```

Parar:

```bash
docker compose stop
```

Reiniciar:

```bash
docker compose restart
```

Remover container:

```bash
docker compose down
```

Os dados persistentes continuam disponíveis no host.

## Monitoramento

```bash
docker stats
```

Esse comando permite acompanhar:

- CPU;
- memória;
- rede;
- I/O.

## Política de reinicialização

O Minecraft utiliza:

```yaml
restart: unless-stopped
```

Isso permite que o container volte automaticamente depois que o Docker e o servidor forem reiniciados.

## Resultado

Docker passou a ser a camada utilizada para executar workloads no homelab.