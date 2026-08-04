# Roadmap — Homelab DevOps

## Objetivo

Construir um ambiente DevOps utilizando um notebook antigo como servidor doméstico.

O projeto será utilizado para estudar Linux, redes, containers, automação, segurança, observabilidade, CI/CD e GitOps.

## Fase 1 — Infraestrutura base

- [x] Instalar Debian Server
- [x] Configurar hostname
- [x] Criar usuário administrativo
- [x] Instalar SSH Server
- [x] Validar conexão com a internet
- [x] Realizar primeiro acesso remoto via SSH
- [ ] Atualizar pacotes
- [ ] Configurar timezone
- [ ] Configurar NTP
- [ ] Configurar comportamento da tampa
- [ ] Reservar endereço IP no roteador

## Fase 2 — Segurança

- [ ] Configurar autenticação SSH por chave
- [ ] Desativar autenticação SSH por senha
- [ ] Confirmar que o login direto como root está desabilitado
- [ ] Configurar firewall
- [ ] Instalar Fail2Ban
- [ ] Configurar atualizações automáticas de segurança

## Fase 3 — Containers

- [ ] Instalar Docker Engine
- [ ] Instalar Docker Compose
- [ ] Criar primeiro container
- [ ] Estudar imagens
- [ ] Estudar volumes
- [ ] Estudar redes
- [ ] Definir limites de recursos

## Fase 4 — Gerenciamento

- [ ] Criar estrutura de diretórios do servidor
- [ ] Instalar Portainer
- [ ] Organizar arquivos Compose
- [ ] Definir política de logs
- [ ] Definir estratégia de backup

## Fase 5 — Hospedagem

- [ ] Subir aplicação de teste
- [ ] Subir PostgreSQL
- [ ] Configurar persistência
- [ ] Configurar reverse proxy
- [ ] Configurar domínio e subdomínios
- [ ] Publicar aplicação com Cloudflare Tunnel

## Fase 6 — CI/CD

- [ ] Criar pipeline de testes
- [ ] Criar imagem Docker
- [ ] Publicar imagem em registry
- [ ] Automatizar deploy
- [ ] Definir estratégia de rollback

## Fase 7 — Observabilidade

- [ ] Instalar Node Exporter
- [ ] Instalar Prometheus
- [ ] Instalar Grafana
- [ ] Instalar Loki
- [ ] Monitorar containers
- [ ] Criar alertas

## Fase 8 — Kubernetes e GitOps

- [ ] Instalar K3s
- [ ] Estudar Pods
- [ ] Estudar Deployments
- [ ] Estudar Services
- [ ] Estudar Ingress
- [ ] Instalar Helm
- [ ] Instalar ArgoCD
- [ ] Implementar fluxo GitOps