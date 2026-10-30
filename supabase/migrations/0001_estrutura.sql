-- Estrutura inicial: textos dos livros, lembranças (com as fases do jogo) e bucket de fotos.
-- Leitura liberada só para a conta da mozinha. Não há políticas de escrita:
-- só o script de sync (chave de serviço) grava dados.

-- Único lugar com o UUID dela.
create or replace function public.eh_mozinha()
returns boolean
language sql
stable
as $$
  select (select auth.uid()) = 'a616d2c2-5776-40ca-8895-3695996a32d3'::uuid
$$;

-- Textos dos 5 livros
create table public.textos (
  id uuid primary key default gen_random_uuid(),
  livro text not null check (livro in
    ('elogios', 'agradecimentos', 'declaracoes', 'textos', 'poesias')),
  ordem int not null,
  titulo text,
  corpo text not null,
  unique (livro, ordem)
);
alter table public.textos enable row level security;

create policy "somente ela le os textos"
  on public.textos for select to authenticated
  using (public.eh_mozinha());

-- Lembranças: timeline completa; as que têm `fase` (1 a 5) aparecem no jogo
create table public.lembrancas (
  id uuid primary key default gen_random_uuid(),
  data date not null,
  titulo text not null,
  texto text,
  foto text,              -- caminho do arquivo no bucket `fotos`
  fase smallint unique check (fase between 1 and 5)
);
alter table public.lembrancas enable row level security;

create policy "somente ela le as lembrancas"
  on public.lembrancas for select to authenticated
  using (public.eh_mozinha());

-- Fotos (bucket privado, acesso por URL assinada)
insert into storage.buckets (id, name, public) values ('fotos', 'fotos', false);

create policy "somente ela le as fotos"
  on storage.objects for select to authenticated
  using (bucket_id = 'fotos' and public.eh_mozinha());
