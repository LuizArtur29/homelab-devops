# Migração do Minecraft Realms

## Objetivo

Migrar um mundo existente do Minecraft Realms para o Minecraft Bedrock Dedicated Server executado no homelab.

## Origem

O Minecraft Bedrock estava sendo executado no CachyOS através do Trinity Launcher.

Depois do download do mundo do Realm, os mundos locais foram encontrados em:

```text
~/.var/app/com.trench.trinity.launcher/data/mcpelauncher/games/com.mojang/minecraftWorlds/
```

## Localização dos mundos

Foi utilizado:

```bash
find ~/.var/app \
  -type d \
  -path "*/minecraftWorlds/*" \
  2>/dev/null
```

Foram encontradas diversas pastas.

## Identificação

Cada mundo contém:

```text
levelname.txt
```

No fish shell foi possível identificar os mundos utilizando:

```fish
for d in */
    echo "=== $d ==="
    cat "$d/levelname.txt" 2>/dev/null
    echo
end
```

O mundo correspondente ao Realm foi identificado.

## Estrutura do mundo

Um mundo Bedrock possui arquivos como:

```text
level.dat
levelname.txt
db/
```

Também pode conter:

```text
resource_packs/
behavior_packs/
```

## Preparação do servidor

Antes da migração, o Minecraft foi parado:

```bash
cd /srv/compose/minecraft
docker compose stop
```

## Backup

O mundo existente no servidor foi preservado antes da substituição.

```bash
mkdir -p /srv/minecraft/backups

cp -a /srv/minecraft/data/worlds \
  /srv/minecraft/backups/worlds-before-realms-import
```

## Transferência

A pasta do mundo foi enviada do CachyOS para o Debian utilizando SCP.

Exemplo:

```bash
scp -r 'PASTA_DO_MUNDO' \
  luiz@192.168.10.9:/srv/minecraft/data/worlds/
```

## Nome do mundo

No servidor, a pasta foi renomeada para:

```text
realm-luiz-lolo
```

## Docker Compose

O `LEVEL_NAME` foi configurado para utilizar o mundo migrado:

```yaml
LEVEL_NAME: "realm-luiz-lolo"
```

## Inicialização

```bash
cd /srv/compose/minecraft
docker compose up -d
```

Logs:

```bash
docker compose logs -f
```

## Validação

Depois da inicialização:

- o servidor iniciou;
- o mundo antigo foi carregado;
- o jogador conseguiu entrar;
- construções e progresso anteriores estavam presentes.

## Resultado

O mundo anteriormente hospedado no Minecraft Realms passou a ser executado no servidor próprio.