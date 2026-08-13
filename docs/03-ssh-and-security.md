# SSH e Segurança

## Objetivo

Permitir administração remota segura do homelab utilizando SSH.

## Serviço SSH

O OpenSSH Server foi instalado durante a instalação do Debian.

Status:

```bash
sudo systemctl status ssh
```

Porta utilizada:

```text
TCP 22
```

## Primeiro acesso

Inicialmente:

```bash
ssh luiz@192.168.10.9
```

## Autenticação por chave

O computador utilizado para administração já possuía um par de chaves SSH.

A chave pública foi adicionada ao servidor.

O arquivo utilizado pelo OpenSSH é:

```text
~/.ssh/authorized_keys
```

## Problema encontrado

Durante a configuração ocorreu:

```text
Permission denied (publickey)
```

Foi descoberto que o diretório:

```text
~/.ssh
```

e o arquivo:

```text
~/.ssh/authorized_keys
```

ainda não existiam no servidor.

Depois da criação e instalação correta da chave pública, o login passou a funcionar normalmente.

## Permissões

As permissões do SSH devem ser restritivas:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Teste

A conexão passou a funcionar utilizando:

```bash
ssh luiz@192.168.10.9
```

A chave privada permanece somente no computador cliente.

## Firewall

O servidor utiliza firewall para limitar os serviços expostos.

O status pode ser verificado com:

```bash
sudo ufw status verbose
```

A porta SSH precisa permanecer permitida para administração.

Exemplo:

```bash
sudo ufw allow 22/tcp
```

## Verificando se o SSH está ouvindo

```bash
sudo ss -tlnp | grep ':22'
```

## Segurança física

O servidor continua apresentando login e senha no console físico.

Isso foi mantido intencionalmente.

Não é necessário configurar autologin porque os serviços iniciam sem uma sessão interativa.

## Boas práticas

- não publicar chaves privadas;
- utilizar autenticação por chave;
- manter permissões corretas em `~/.ssh`;
- manter o sistema atualizado;
- evitar login direto como root;
- limitar portas expostas;
- utilizar `sudo` para administração.

## Resultado

O servidor pode ser administrado remotamente através de SSH utilizando autenticação baseada em chave.