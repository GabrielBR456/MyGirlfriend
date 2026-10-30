import { createClient } from '@supabase/supabase-js';

// Valores públicos por design: o que protege o conteúdo é a RLS no Supabase.
// A chave de serviço nunca entra aqui.
const SUPABASE_URL = 'https://lsvaijwbegomrnllrten.supabase.co';
const SUPABASE_CHAVE_PUBLICA = 'sb_publishable_zNOUyZaWtZrJAitD3DR8oA_8ZywNZ6d';

// Conta dela. Na tela ela digita só o código (a senha dessa conta).
export const EMAIL_MOZINHA = 'mozinha@mygirlfriend.local';

// A sessão fica no navegador e se renova sozinha: ela só sai clicando em "Sair".
export const supabase = createClient(SUPABASE_URL, SUPABASE_CHAVE_PUBLICA, {
  auth: { persistSession: true, autoRefreshToken: true }
});
