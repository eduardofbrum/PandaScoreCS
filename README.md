# PandaScoreCS
Este projeto utiliza a API PandaScore para exibir as partidas de CS que estão acontecendo no dia. 

Além disso, é possível ver os jogadores de cada time.

## Ferramentas
- XCode versão 15.3
- Target mínimo do iOS 16+ (utilizei o NavigationPath do SwiftUI para desenvolver o coordinator)
- Utilizei o Postman para teste de API

## Como rodar o projeto
- Baixar os arquivos, abrir o .xcodeproj e dar build

## Estrutura do projeto
- Coordinator: Contém a estrutura responsável pela navegação do app onde pode ser chamada qualquer view.
- CoreNetwork: Contém a estrutura que é utilizada nas camadas de service das outras features. Endpoints, Função para request, ...
- Model: Contém os modelos utilizados no aplicativo. Match, Player, ...
- DesignSystem: Contém os tokens utilizados para padronizar as views e componentes.
- Utils: Formatação de data para seguir o padrão.
- Feature-Splash-Screen: A view utilizada como Splash Screen.
- Feature-List-Matches: Estrutura para exibir a lista de partidas, contendo a View, ViewModel e Service.
- Feature-Detail-Match: Estrutura para exibir as informações da partida selecionada e os jogadores de cada time, contendo a View, ViewModel e Service.
- Também foram feitos alguns testes unitários para as ViewModels

## Requisitos entregues
- [x] Link do repositório
- [x] Readme
- [x] Pull-to-refresh
- [x] Testes unitários
- [x] Arquitetura MVVM
- [x] Combine
- [x] Paginação
- [x] Resposividade




