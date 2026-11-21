-- Connect Pay: perfil de administrador no servidor (RLS).
-- Execute UMA vez no Supabase (SQL Editor), DEPOIS de criar os dois usuários em
-- Authentication > Users. Não altera nem apaga dados e não mexe nas políticas atuais:
-- soma uma política extra que libera tudo apenas para o e-mail do administrador.
-- Os demais usuários continuam vendo somente os próprios registros.
--
-- Administrador: megairati2020@gmail.com
-- Usuário comum (sem Dashboard): Lojamegairati@gmail.com

create policy "cp_admin_clientes" on public.cp_clientes for all to authenticated
  using (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

create policy "cp_admin_analises" on public.cp_analises for all to authenticated
  using (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

create policy "cp_admin_simulacoes" on public.cp_simulacoes for all to authenticated
  using (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

-- Documentos dos clientes (só se você já executou supabase-documentos.sql)
create policy "cp_docs_admin" on storage.objects for all to authenticated
  using (bucket_id = 'cp-documentos' and lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (bucket_id = 'cp-documentos' and lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

-- Reversão (se necessário):
-- drop policy "cp_admin_clientes" on public.cp_clientes;
-- drop policy "cp_admin_analises" on public.cp_analises;
-- drop policy "cp_admin_simulacoes" on public.cp_simulacoes;
-- drop policy "cp_docs_admin" on storage.objects;
