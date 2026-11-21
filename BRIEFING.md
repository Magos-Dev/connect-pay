# CONNECT PAY — BRIEFING MESTRE DO PROJETO

**Projeto:** Connect Pay — plataforma interna de análise e gestão de crédito da Mega Connect  
**Documento:** briefing permanente para manutenção, correções e novas versões  
**Data-base:** 21/11/2026  
**Status:** versão de teste; publicação, autenticação e banco de dados precisam de validação antes do uso real.

> **REGRA CENTRAL:** Em qualquer atualização, preservar integralmente tudo que já funciona e tudo que foi aprovado. Alterar somente o escopo solicitado. Não tratar hipóteses ou recursos planejados como se já estivessem implementados.

## 1. Objetivo e contexto

A Connect Pay é a plataforma de uso interno da Mega Connect para organizar informações de clientes, apoiar análise de capacidade de pagamento, registrar análises e simulações de crédito e consultar histórico. É distinta do site público da loja. Deve ser simples de operar, responsiva, profissional e adequada a informações financeiras sensíveis.

**Domínio principal existente:** `megaconnectofc.com.br`  
**Subdomínio pretendido:** `connectpay.megaconnectofc.com.br`  
**Hospedagem/domínio:** Hostinger.  
**Observação:** o subdomínio é um endereço pretendido, não confirmação de que já esteja ativo.

## 2. Estado conhecido do projeto

O pacote recuperado contém um `index.html` único, com HTML, CSS e JavaScript e imagem da avatar Fran incorporada. A interface apresenta a marca CONNECT PAY, tela de login com e-mail/senha, acesso ao painel após autenticação, nova análise, histórico, cálculos/simulações e funções de salvar, consultar, excluir, imprimir e exportar backup em JSON. Há integração de código com Supabase, incluindo autenticação e tabelas `cp_clientes`, `cp_analises` e `cp_simulacoes`.

**Limitações conhecidas:**
- A configuração de conexão do Supabase é solicitada pela interface (Project URL e chave publicável). Isso não significa que a conexão já esteja pronta.
- Não foi comprovado que as tabelas, políticas RLS, contas, permissões ou autenticação estão configuradas corretamente no ambiente de produção.
- A importação de backups aparece como não habilitada na versão atual; não prometer restauração até implementá-la e testá-la.
- O pacote é uma base de teste e NÃO deve ser considerado homologado para dados reais de clientes.
- Nenhuma análise automática deve ser anunciada como decisão de crédito definitiva.

## 3. Identidade visual obrigatória

- Nome exibido: **CONNECT PAY**.
- Identidade ligada à Mega Connect: preto/grafite, verde-limão e branco, com aparência limpa e profissional.
- Preservar a avatar **Fran** na tela de login, sem trocar por outra imagem ou alterar sua aparência sem pedido explícito.
- Preservar layout, textos aprovados, legibilidade, hierarquia visual, botões e comportamento responsivo.
- Na página inicial, priorizar a tela de login. Não exibir informações técnicas, listagens de arquivos ou telas de administração do servidor para visitantes.
- Evitar excesso de efeitos, elementos decorativos, pop-ups ou telas desnecessárias.

## 4. O que FAZER em toda atualização

1. **Ler este BRIEFING.md antes de editar qualquer arquivo.**
2. Registrar qual é a solicitação, qual problema resolve e quais arquivos serão alterados.
3. Criar cópia de segurança do pacote e, quando aplicável, do banco de dados antes de mudar.
4. Preservar recursos, dados, textos e design não relacionados à mudança.
5. Aplicar alterações pequenas, verificáveis e reversíveis.
6. Verificar erros de sintaxe e de execução do JavaScript.
7. Testar em desktop e celular, inclusive estados de erro e conexão indisponível.
8. Testar login, logout, manutenção de sessão, cadastro, cálculo, gravação, histórico, exclusão, impressão e exportação quando afetados.
9. Confirmar que um usuário não pode acessar dados de outro sem autorização.
10. Documentar alterações e riscos no `CHANGELOG.md`, com versão, data e instruções de reversão.
11. Entregar arquivos completos e instruções objetivas de publicação na Hostinger.
12. Pedir autorização antes de alterar fluxos de crédito, campos financeiros, regras de aprovação ou estrutura de dados.

## 5. O que NÃO FAZER

- NÃO recriar o sistema do zero quando o pedido for uma alteração pontual.
- NÃO remover, substituir ou redesenhar a avatar Fran ou a marca sem autorização.
- NÃO alterar a fisionomia, cores ou visual aprovado por iniciativa própria.
- NÃO apagar registros, substituir o banco, zerar tabelas ou executar migrações destrutivas.
- NÃO publicar chaves secretas, senhas, tokens administrativos ou credenciais em HTML/JavaScript público, Git ou capturas de tela.
- NÃO confundir chave publicável do Supabase com chave de serviço/administrador; esta última jamais pode ficar no navegador.
- NÃO confiar apenas em ocultar botões para restringir acesso: aplicar autenticação e autorização no banco.
- NÃO usar dados de clientes reais em testes sem necessidade e proteção apropriada.
- NÃO expor CPF, renda, telefone, extratos, documentos ou histórico financeiro em logs públicos ou mensagens de erro.
- NÃO inventar dados, rendas, scores, aprovações, taxas ou resultados de análises.
- NÃO alterar condições de crédito, taxas, prazos ou critérios automaticamente sem aprovação humana.
- NÃO colocar o sistema em produção alegando que está seguro apenas porque a tela de login abre.
- NÃO modificar o site principal `megaconnectofc.com.br` ao publicar o subdomínio.
- NÃO sobrescrever a única versão funcional antes de garantir uma forma de rollback.
- NÃO declarar testes como concluídos sem realmente executá-los.

## 6. Regras de segurança e privacidade

A Connect Pay poderá lidar com dados pessoais e financeiros. Portanto:

- Exigir HTTPS válido, autenticação robusta e controle de acesso por usuário/perfil.
- Configurar e verificar políticas **Row Level Security (RLS)** em todas as tabelas Supabase expostas ao navegador.
- Definir explicitamente quem pode consultar, criar, alterar e excluir registros; não presumir que todo usuário autenticado seja administrador.
- Evitar armazenamento de credenciais em texto puro e nunca embutir segredos no código cliente.
- Aplicar minimização de dados, finalidade, acesso restrito e retenção/exclusão conforme a LGPD e a política da empresa.
- Exigir confirmação para exclusões e avaliar exclusão lógica e trilha de auditoria quando necessário.
- Manter backups protegidos e testar restauração antes de depender deles.
- Proteger contra injeção, XSS, exposição indevida de erros e manipulação de parâmetros.
- Manter decisões de concessão de crédito sob responsabilidade de pessoa autorizada, com justificativa e revisão quando aplicável.

## 7. Regras para análise e simulação de crédito

- Diferenciar **informações declaradas**, **dados comprovados**, **cálculos estimados** e **decisão humana**.
- Exibir com clareza valores, prazo, taxas, periodicidade, custo total e condições relevantes quando implementados.
- Não transformar estimativa de capacidade de pagamento em promessa de aprovação.
- Não inferir renda comprovada apenas pelo volume bruto de entradas em extrato; identificar transferências entre contas próprias e movimentos não recorrentes quando possível.
- Não criar regras discriminatórias ou decisões automáticas opacas.
- Mudanças de fórmula, limites, critérios de risco ou produto financeiro exigem solicitação explícita, revisão e testes com casos conhecidos.
- Valores e regras discutidos em fases anteriores são **referências de planejamento**, não parâmetros obrigatoriamente implantados.

## 8. Hospedagem e publicação na Hostinger

Objetivo: publicar a plataforma em `connectpay.megaconnectofc.com.br`, mantendo o site principal separado.

**Procedimento recomendado:**
1. Criar e verificar o subdomínio no painel Hostinger.
2. Identificar a pasta raiz/document root específica do subdomínio.
3. Fazer backup do conteúdo existente dessa pasta.
4. Enviar os arquivos da versão validada; garantir que `index.html` esteja na raiz correta.
5. Ativar/verificar certificado SSL e HTTPS.
6. Configurar a conexão com Supabase de modo seguro e confirmar URLs permitidas de autenticação quando aplicável.
7. Testar abertura do subdomínio, login/logout, permissões e funcionalidades em navegador normal e anônimo.
8. Validar que o domínio principal continua funcionando sem alterações.

**Não presumir:** que DNS, SSL, subdomínio, banco ou autenticação estejam prontos antes da verificação.

## 9. Estrutura de arquivos

**Base atual:**

```text
connectpay_hostinger/
├── index.html       # Interface e lógica da versão de teste
├── BRIEFING.md      # Este documento; regras de evolução
└── CHANGELOG.md     # Histórico das versões e alterações
```

Se futuramente o projeto for separado em CSS, JS, imagens e backend, registrar a nova arquitetura antes de migrar e manter a compatibilidade com os recursos existentes.

## 10. Checklist de homologação antes de publicar

- [ ] Backup anterior criado e rollback definido
- [ ] Alteração solicitada implementada sem mudanças fora do escopo
- [ ] Avatar Fran, marca e visual preservados
- [ ] Tela de login e logout testados
- [ ] Acesso sem login bloqueado
- [ ] Permissões e RLS validadas com usuários diferentes
- [ ] Cadastro, análise, cálculo, gravação e histórico testados
- [ ] Exclusão e exportação testadas (quando aplicável)
- [ ] Testes com dados fictícios realizados
- [ ] Sem chaves secretas no frontend
- [ ] Interface testada em celular e desktop
- [ ] HTTPS e subdomínio verificados
- [ ] Site principal preservado
- [ ] CHANGELOG.md atualizado
- [ ] Responsável aprovou a publicação

## 11. Padrão obrigatório para pedidos futuros

Ao receber uma solicitação de atualização, seguir esta sequência:

**A. Entendimento:** descrever o que será modificado e o que permanecerá intacto.  
**B. Impacto:** indicar arquivos, funções, dados e possíveis riscos afetados.  
**C. Execução:** criar backup e implementar apenas a mudança autorizada.  
**D. Testes:** registrar o que foi testado, o resultado e o que não pôde ser testado.  
**E. Entrega:** fornecer pacote completo, número da versão, changelog e procedimento de instalação/rollback.

**Exemplo de instrução para outro desenvolvedor ou assistente:**

> Leia primeiro o BRIEFING.md da Connect Pay. Trabalhe sobre a última versão funcional. Preserve a avatar Fran, identidade visual, login, funcionalidades e dados existentes. Altere somente o que estou solicitando. Não apague informações nem mude regras de crédito sem minha autorização. Faça backup, teste o impacto, atualize o CHANGELOG.md e entregue a nova versão completa com instruções de publicação e rollback.

## 12. Prioridades de evolução (não confundir com funcionalidades concluídas)

1. Validar hospedagem, HTTPS, autenticação e Supabase.
2. Validar RLS, permissões e isolamento dos dados.
3. Garantir backup e procedimento real de restauração.
4. Homologar análises, cálculos e histórico com dados fictícios.
5. Melhorar usabilidade e recursos administrativos conforme solicitações aprovadas.

---

**Este briefing é a referência permanente de cada atualização.** Caso uma nova solicitação entre em conflito com ele, explicar o conflito e solicitar autorização explícita antes de executar uma mudança irreversível ou sensível.

## Anexo — cinco critérios permanentes de atualização (21/11/2026)
- **Corrigir:** analisar fluxos, registrar causas, corrigir regressões e testar CRUD, autenticação, cálculos e tratamento de erros.
- **Melhorar:** elevar legibilidade, contraste, estados e UX sem descaracterizar a marca, o layout aprovado ou a Fran.
- **Otimizar:** priorizar gargalos medidos, consultas eficientes, imagens leves e manutenção simples; não introduzir frameworks sem necessidade.
- **Responsivo:** testar celular, tablet e desktop; garantir toque, tabelas com rolagem controlada, campos legíveis e ausência de overflow da página.
- **Segurança:** verificar RLS no Supabase, autenticação, isolamento por usuário, dados sensíveis, chaves publicáveis e regras de backend. Nunca prometer segurança apenas com alterações no HTML.
- Consultar **AUDITORIA.md** antes de colocar em produção e atualizar **CHANGELOG.md** em toda versão.
