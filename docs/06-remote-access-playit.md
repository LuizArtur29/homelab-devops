# Acesso Externo com playit.gg

## Problema

O servidor está em uma conexão residencial onde port forwarding convencional não era uma solução adequada devido ao cenário de CGNAT.

O objetivo era permitir que outro jogador acessasse o Minecraft sem instalar:

- VPN;
- Tailscale;
- cliente adicional.

## Solução

Foi utilizado o playit.gg.

O agente é executado diretamente no servidor Debian.

## Arquitetura

```text
Jogador
   │
   ▼
Internet
   │
   ▼
playit.gg
   │
   │ túnel UDP
   ▼
HP 1000
   │
   ▼
127.0.0.1:19132
   │
   ▼
Minecraft Bedrock
```

## Serviço

O agente é gerenciado pelo `systemd`.

Status:

```bash
sudo systemctl status playit
```

Logs:

```bash
sudo journalctl -u playit -n 50 --no-pager
```

## Permissões

Durante a configuração, o socket:

```text
/run/playit/playitd.sock
```

era restrito ao grupo:

```text
playit
```

O usuário foi adicionado ao grupo:

```bash
sudo usermod -aG playit $USER
```

A nova associação foi carregada com:

```bash
newgrp playit
```

## Configuração do túnel

Foi criado um túnel:

```text
Type: Minecraft Bedrock
Protocol: UDP
Local IP: 127.0.0.1
Local Port: 19132
Proxy Protocol: None
```

O playit fornece um hostname e uma porta pública.

Essas informações podem mudar conforme a configuração da conta e, por isso, não são armazenadas neste repositório.

## Jogadores

O jogador remoto precisa apenas adicionar o servidor ao Minecraft Bedrock utilizando:

```text
hostname público fornecido pelo playit
porta pública fornecida pelo playit
```

Nenhum cliente playit precisa ser instalado no dispositivo do jogador.

## Inicialização automática

O agente é executado como serviço do sistema.

Para verificar:

```bash
systemctl is-active playit
```

## Segurança

Não devem ser publicados:

- tokens;
- secrets;
- credenciais;
- URLs de claim;
- informações privadas da conta.

## Resultado

O Minecraft passou a aceitar jogadores externos mesmo sem exposição convencional da porta através do roteador.