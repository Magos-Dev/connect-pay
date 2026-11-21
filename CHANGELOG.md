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

## 2026-11-21 — decisões Reprovar e Cancelar
- Solicitação: além de aprovar, permitir reprovar e cancelar a análise.
- Arquivos alterados: `index.html`.
- Botões "Reprovar" e "Cancelar" pedem motivo obrigatório e confirmação; a decisão fica em `observacoes` e no `parecer` (status do banco não foi alterado). Reprovar/cancelar oculta a aba Documentos; arquivos já enviados permanecem no Storage.
- A decisão pode ser mudada depois por uma pessoa (ex.: reprovada → aprovada). Coluna "Situação" em Clientes salvos e parecer no PDF.
- Testes realizados: fluxo aprovar, reprovar, cancelar e reaprovar no navegador com salvamento simulado.
- Testes pendentes: gravação real no Supabase.

## 2026-11-21 — selos coloridos em Clientes salvos
- Coluna "Situação" agora usa blocos coloridos: Aprovada (verde), Reprovada (vermelho), Cancelada (cinza), Em análise (amarelo).
- Arquivos alterados: `index.html`. Testado no navegador com registros simulados.

## 2026-11-21 — blocos separados em Clientes salvos
- A lista agora tem um bloco verde "Aprovados" e um bloco vermelho "Reprovados", cada um com contador. Clientes em análise ou cancelados ficam num terceiro bloco neutro, para não sumirem da lista.
- Arquivos alterados: `index.html`. Testado no navegador com registros simulados.

## 2026-11-21 — menu lateral e barra do usuário
- Solicitação: menu lateral parecido com o dashboard de referência, com o usuário no topo.
- Menu lateral fixo (Análises: Nova análise, Clientes salvos, Documentos; Sistema: Backup e segurança) com ícones, item ativo em destaque verde e selo vermelho com a quantidade de clientes em análise.
- Barra superior com título da página, nome/e-mail do usuário, avatar com inicial e botão Sair. A tela de login não mudou.
- No celular o menu vira uma barra horizontal no topo.
- Arquivos alterados: `index.html`. Nenhuma função de análise, banco ou documentos foi alterada.
- Testado no navegador com dados simulados; pendente: conferir no celular real e após republicar.

## 2026-11-21 — aba Dashboard
- Novo botão "Dashboard" (terceiro do menu, depois de Clientes salvos) com: gráfico rosca de aprovados/reprovados/em análise (mais canceladas), gráfico por cliente aprovado com entrada, parcela e total, tabela com totais e gráfico final do montante total dos aprovados.
- Definições: entrada = caução inicial; total/montante = entrada + parcela × nº de mensalidades (mesma conta da simulação).
- Gráficos feitos em HTML/CSS, sem biblioteca externa. Dados vindos dos mesmos registros de Clientes salvos.
- Arquivos alterados: `index.html`. Testado no navegador com dados simulados (totais conferidos); pendente: dados reais.

## 2026-11-21 — Dashboard com gráficos verticais
- Solicitação: trocar as barras horizontais por gráficos como o da referência.
- Faixa de indicadores no topo (clientes, aprovados com taxa, entradas aprovadas, montante total).
- Gráfico de colunas verticais por cliente aprovado (entrada, parcela e total), anel de situação com % de aprovados e gráfico de área curva com o montante acumulado dos aprovados. Tabela de detalhamento mantida.
- Gráficos em SVG, sem biblioteca externa; na tela estreita rolam na horizontal. Arquivos alterados: `index.html`. Testado com dados simulados (soma conferida).

## 2026-11-21 — Dashboard em tamanho médio
- Solicitação: gráficos grandes demais na página.
- Gráficos agora têm altura fixa menor (colunas 240 px, área 220 px, anel 150 px) e usam a largura real do espaço, sem esticar em telas grandes. Conteúdo limitado a 1120 px de largura, indicadores menores e redesenho ao redimensionar a janela.
- Arquivos alterados: `index.html`. Testado em janela de 1600 px com dados simulados.

## 2026-11-21 — Saúde do negócio no Dashboard
- Solicitação: verificação geral da saúde do sistema (inadimplência, lucro por venda, a receber), com base nas telas do MVloc enviadas.
- Novo bloco "Saúde do negócio" (Saudável / Atenção / Crítico) com alertas, recebido, a receber, inadimplência (% e nº de clientes), lucro previsto, lucro até agora, markup, ROI, MRR, ticket médio, investimento e faixas de atraso (1–15, 16–30, +30 dias).
- Novas tabelas: lucro por contrato, parcelas a receber (marcar como paga / desfazer) e previsto x recebido por mês.
- Novos dados, dentro de `observacoes` (sem mudar o schema): campo "Custo real do aparelho" no cadastro e lista de parcelas pagas. Sem custo informado, usa o valor de referência (sinalizado com "(ref.)").
- Regras assumidas: entrada (caução) conta como recebida na aprovação; vencimentos mensais a partir do "Primeiro vencimento"; custo = custo real ou valor de referência.
- Limite: só considera clientes cadastrados no Connect Pay. Nenhum dado do MVloc foi copiado para o código.
- Arquivos alterados: `index.html`. Testado com dados simulados (somas conferidas à mão); pagamento testado com Supabase simulado. Pendente: gravação real no Supabase.

## 2026-11-21 — Investimento e retorno
- Novo painel "Investimento e retorno" no Dashboard: investimento total (custo dos aparelhos), retorno recebido, falta recuperar, retorno previsto, lucro previsto, retorno sobre o investimento, barra "% do investimento já voltou" e gráfico por cliente (investimento x recebido x previsto).
- Custo do aparelho agora pode ser digitado direto na tabela "Lucro por contrato" (salva ao sair do campo). Vazio = usa o valor de referência.
- O card "Investimento" saiu de "Saúde do negócio" para não duplicar. Arquivos alterados: `index.html`. Testado com dados simulados (somas conferidas) e Supabase simulado.

## 2026-11-21 — blocos recolhíveis
- Solicitação: cada aba poder recolher e expandir.
- Todo bloco (painel) das abas Nova análise, Clientes salvos (incluindo os grupos Aprovados/Reprovados), Dashboard, Documentos e Backup recolhe/expande ao clicar no título (ou Enter/Espaço), com seta indicando o estado. O estado é lembrado no navegador e não se perde ao atualizar os dados; "Calcular análise" reabre o resultado.
- Menu lateral com botão "Recolher menu" (modo só ícones, lembrado no navegador); oculto no celular.
- Arquivos alterados: `index.html`. Testado no navegador com dados simulados.

## 2026-11-21 — perfis: administrador e usuário comum
- Solicitação: `megairati2020@gmail.com` administrador (acesso total); `Lojamegairati@gmail.com` usuário comum da loja Mega Irati, sem Dashboard.
- Administrador: vê o Dashboard, o campo "Custo real do aparelho" e os clientes de todos os usuários (nova coluna "Cadastrado por"); ao editar um cliente de outro usuário, o dono do registro é preservado. Selo "Administrador" na barra do topo.
- Usuário comum: sem o botão Dashboard, sem o campo de custo, vê só os próprios clientes. Qualquer e-mail fora da lista de administradores é tratado como usuário comum.
- A lista de administradores fica em `ADMINS` no `index.html`. O bloqueio no navegador é de interface; a permissão real vem do `supabase-perfis.sql` (não executado), que libera o administrador pelo e-mail do login.
- Também: gerador de ID com alternativa quando `crypto.randomUUID` não existe.
- Testado com Supabase simulado (menu, abas, consultas, dono preservado). Pendente: rodar o SQL e testar com as duas contas reais.
