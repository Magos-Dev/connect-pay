-- Connect Pay: pasta privada de documentos dos clientes.
-- Execute UMA vez no Supabase (SQL Editor). Não apaga nem altera nenhuma tabela existente.
-- Cada usuário só acessa a própria pasta: <id-do-usuario>/<id-do-cliente>/arquivo

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('cp-documentos', 'cp-documentos', false, 10485760,
        array['image/jpeg','image/png','image/webp','application/pdf'])
on conflict (id) do nothing;

create policy "cp_docs_select_proprio" on storage.objects for select to authenticated
  using (bucket_id = 'cp-documentos' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "cp_docs_insert_proprio" on storage.objects for insert to authenticated
  with check (bucket_id = 'cp-documentos' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "cp_docs_delete_proprio" on storage.objects for delete to authenticated
  using (bucket_id = 'cp-documentos' and (storage.foldername(name))[1] = auth.uid()::text);

-- Reversão (se necessário):
-- drop policy "cp_docs_select_proprio" on storage.objects;
-- drop policy "cp_docs_insert_proprio" on storage.objects;
-- drop policy "cp_docs_delete_proprio" on storage.objects;
-- (esvazie o bucket pelo painel Storage antes de removê-lo)
