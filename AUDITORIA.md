# Auditoria técnica — Connect Pay (21/11/2026)

## Escopo
Revisados os cinco documentos fornecidos (corrigir, melhorar, otimizar, responsivo e segurança) e o código estático do `index.html`. A auditoria é **estática**: não houve acesso ao projeto Supabase, ao ambiente Hostinger, aos dados reais, nem execução dos fluxos autenticados em produção.

## Correções aplicadas
- Removidas funções legadas duplicadas de CRUD em `localStorage` que podiam confundir manutenção; os dados legados não foram apagados do navegador de nenhum usuário.
- Mantida a lógica de cálculos e impressão, com proteção contra prazo zero, números inválidos e valores negativos nos cálculos.
- Adicionada validação antes de gravar: valores não negativos, caução até o preço, taxa até 100%, prazo entre 1 e 120 meses.
- Evitado salvamento duplicado por cliques repetidos; a trava é liberada após sucesso ou erro.
- Reinicialização do cliente Supabase quando a configuração muda.
- Consultas históricas com limites explícitos (500 clientes, 1000 análises e 1000 simulações) e aviso técnico no console quando atingidos. **A paginação real permanece pendente**; limites não substituem paginação e podem omitir registros antigos.
- Melhorados overflow horizontal de tabela, inputs e botões no mobile, foco de teclado, status acessível e preferência por movimento reduzido.

## Riscos pendentes / validação obrigatória antes de produção
1. **Crítico:** conferir no Supabase RLS ativo e políticas por `auth.uid()` nas três tabelas, com testes entre duas contas. Não é possível comprovar isso pelo HTML.
2. **Alto:** gravações de cliente, análise e simulação são separadas; para atomicidade real, criar uma transação no backend (RPC PostgreSQL com autorização rigorosa), após revisar schema e políticas. O frontend alerta sobre salvamento parcial.
3. **Alto:** não há teste de login, logout, sessão, CRUD, exclusão, backup ou autenticação no ambiente real.
4. **Alto:** validar tratamento de dados pessoais e financeiros conforme LGPD, com acesso restrito, retenção e procedimento de incidentes.
5. **Médio:** implementar paginação real e consulta eficiente com índices após medir a base e revisar o schema.
6. **Médio:** backup JSON exporta dados sensíveis; armazenar em local protegido, nunca em pasta pública da Hostinger.
7. **Médio:** a importação de backup online segue indisponível. Não ativar sem regras claras de integridade e autorização.
8. **Médio:** biblioteca Supabase vem de CDN; validar disponibilidade e considerar hospedagem de versão controlada e política CSP após testes.
9. **Médio:** revisar eventual dado legado de versões anteriores salvo no navegador e criar migração segura antes de remover.

## Critérios de homologação
- Testar em HTTPS, mobile 320/375/390/768px e desktop 1280px; verificar layout e impressão.
- Testar com duas contas distintas: acesso, consulta, criação, edição e exclusão entre usuários.
- Testar conexão offline, credenciais erradas, sessão expirada, limites de consulta e falhas parciais.
- Fazer backup do banco antes de mudanças de schema e manter rollback documentado.

**Status:** pacote corrigido para testes; **não homologado para produção com dados reais**.
