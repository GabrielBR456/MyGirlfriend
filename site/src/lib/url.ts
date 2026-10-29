// Monta caminhos internos com o prefixo do GitHub Pages (`base` do astro.config.mjs).
// Ex.: url('mozinha') -> '/MyGirlfriend/mozinha'
const base = import.meta.env.BASE_URL.replace(/\/$/, '');

export function url(caminho = ''): string {
  return `${base}/${caminho.replace(/^\//, '')}`;
}
