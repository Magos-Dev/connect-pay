# CONNECT PAY — CHANGELOG

## 2026-11-21 — Pacote de referência para hospedagem

- Preservado o `index.html` da versão de teste recuperada.
- Adicionado `BRIEFING.md` com objetivos, regras, segurança, publicação e checklist de homologação.
- Criado `CHANGELOG.md` para registrar futuras atualizações.
- Nenhuma funcionalidade do aplicativo foi modificada nesta entrega.

**Validação pendente:** subdomínio Hostinger, HTTPS, autenticação, políticas Supabase RLS, dados e testes funcionais em produção.

## Modelo para próximas versões

### [versão] — [data]
- Solicitação:
- Arquivos alterados:
- O que foi preservado:
- Testes realizados e resultados:
- Testes pendentes:
- Backup/rollback:
- Aprovação para publicação:

## 21/11/2026 — revisão técnica 2.1 (teste)
- Auditoria dos cinco arquivos de requisitos; limpeza de código legado duplicado, validações de valores, prevenção de gravações duplicadas, limites de consultas e ajustes responsivos/acessibilidade.
- Criado AUDITORIA.md com riscos e testes pendentes; nenhuma migração no Supabase foi executada.

## 2026-11-21 — análise de risco e aba Documentos
- Solicitação: análise de risco do cliente e, após aprovação, nova aba para envio de documentos.
- Arquivos alterados: `index.html`; novo `supabase-documentos.sql` (não executado).
- Análise de risco indicativa (Baixo/Médio/Alto) por regras internas visíveis, sem pontuação automática.
- Botão "Aprovar e enviar documentos": registra aprovação humana (campo dentro de `observacoes`, sem mudar schema) e libera a aba Documentos.
- Documentos enviados ao Storage privado `cp-documentos`, pasta `usuario/cliente`. Exige rodar `supabase-documentos.sql` antes.
- Testes realizados: sintaxe JS e cálculo/risco com os valores do cliente de teste (mensalidade R$ 396,36, risco Médio).
- Testes pendentes: envio real de arquivos e RLS do Storage com duas contas.
- Rollback: reverter o commit; no Supabase, usar o bloco de reversão do `.sql`.
