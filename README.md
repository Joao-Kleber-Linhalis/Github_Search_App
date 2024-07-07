# GitHub User Search

## Visão Geral
GitHub User Search é um aplicativo móvel desenvolvido em Flutter para simplificar a busca e visualização de informações de usuários do GitHub de maneira intuitiva e eficiente.

## Funcionalidades Principais
1. **Busca de Usuários:** Permite que os usuários pesquisem perfis do GitHub pelo nome de usuário, exibindo informações básicas como foto de perfil, nome, login e localização diretamente na tela principal.

2. **Detalhes do Perfil:** Ao clicar em um usuário listado, exibe um perfil detalhado incluindo:
   - Foto de perfil do usuário.
   - Nome completo e nome de usuário (login).
   - Localização do usuário.
   - ID do usuário.
   - Número de seguidores.
   - Número de repositórios públicos.
   - Lista de todos os repositórios do usuário, cada um contendo nome, linguagem de programação utilizada, descrição, data de criação e última data de envio.

3. **Navegação para Repositórios:** Permite acesso direto a qualquer repositório listado para visualização detalhada no site do GitHub.

4. **Menu de Histórico:** Mantém um histórico dos usuários pesquisados recentemente, proporcionando acesso rápido aos perfis consultados anteriormente.

## Tecnologias Utilizadas
- **Flutter:** Framework de desenvolvimento de UI multiplataforma para aplicativos móveis nativos.
- **GitHub API:** Utilizada para buscar dados detalhados de usuários e repositórios diretamente do GitHub.

## Implementação
O aplicativo é estruturado utilizando widgets nativos do Flutter para uma experiência de usuário fluida e responsiva. A integração com a API do GitHub é assíncrona para garantir desempenho e atualizações em tempo real.
