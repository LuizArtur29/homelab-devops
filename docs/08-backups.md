# Backups do Minecraft

## Objetivo

Criar backups automáticos do mundo e das configurações importantes do Minecraft.

## Diretório

```text
/srv/minecraft/backups
```

## Estratégia

O processo utilizado é:

```text
systemd timer
      │
      ▼
backup-minecraft.sh
      │
      ├── para Minecraft
      ├── compacta os dados
      ├── inicia Minecraft
      └── remove backups antigos
```

O servidor é parado brevemente durante a cópia para evitar inconsistência nos arquivos do mundo.

## Script

Local:

```text
/usr/local/sbin/backup-minecraft.sh
```

O script:

1. para o container;
2. cria um arquivo `.tar.gz`;
3. inicia novamente o container;
4. mantém política de retenção;
5. remove backups antigos.

## Nomenclatura

Os arquivos seguem aproximadamente:

```text
minecraft-YYYY-MM-DD_HH-MM-SS.tar.gz
```

## Retenção

A política configurada mantém backups dos últimos:

```text
14 dias
```

## Execução manual

```bash
sudo /usr/local/sbin/backup-minecraft.sh
```

## Listar backups

```bash
ls -lh /srv/minecraft/backups
```

## Integridade

Selecionar o mais recente:

```bash
BACKUP=$(find /srv/minecraft/backups \
  -maxdepth 1 \
  -type f \
  -name 'minecraft-*.tar.gz' \
  | sort | tail -1)
```

Ver:

```bash
echo "$BACKUP"
```

Testar:

```bash
gzip -t "$BACKUP" && echo "Backup íntegro"
```

## Verificar conteúdo

```bash
tar -tzf "$BACKUP" | head
```

Para verificar especificamente o mundo:

```bash
tar -tzf "$BACKUP" \
  | grep 'worlds/realm-luiz-lolo' \
  | head
```

## Teste de extração

```bash
mkdir -p /tmp/minecraft-restore-test
tar -xzf "$BACKUP" -C /tmp/minecraft-restore-test
```

Verificação:

```bash
test -f \
  /tmp/minecraft-restore-test/worlds/realm-luiz-lolo/level.dat \
  && echo "level.dat OK"
```

```bash
test -d \
  /tmp/minecraft-restore-test/worlds/realm-luiz-lolo/db \
  && echo "Banco do mundo OK"
```

Depois:

```bash
rm -rf /tmp/minecraft-restore-test
```

## systemd service

Arquivo:

```text
/etc/systemd/system/minecraft-backup.service
```

O serviço executa o script de backup como uma tarefa `oneshot`.

## systemd timer

Arquivo:

```text
/etc/systemd/system/minecraft-backup.timer
```

O timer executa o backup diariamente.

Foi utilizado:

```ini
Persistent=true
```

Assim, caso o servidor esteja desligado no horário programado, o systemd pode executar a tarefa pendente quando a máquina voltar.

## Verificação

```bash
systemctl status minecraft-backup.timer
```

ou:

```bash
systemctl list-timers --all | grep minecraft
```

## Logs

```bash
sudo journalctl \
  -u minecraft-backup.service \
  -n 50 \
  --no-pager
```

## Disaster Recovery

Em uma restauração real:

```text
Selecionar backup
      ↓
Parar Minecraft
      ↓
Preservar estado atual
      ↓
Extrair backup
      ↓
Verificar arquivos
      ↓
Verificar permissões
      ↓
Iniciar Minecraft
      ↓
Validar mundo
```

## Limitação atual

Os backups permanecem no mesmo SSD do servidor.

Isso protege contra:

- corrupção do mundo;
- alterações acidentais;
- problemas de atualização;
- erros de configuração.

Mas não protege contra falha física completa do SSD.

Uma evolução futura será adicionar backup off-site.