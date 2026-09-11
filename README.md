# Marido de Aluguel

Plataforma web que conecta prestadores autônomos de pequenos reparos residenciais (elétrica, hidráulica, montagem de móveis, entre outros) a clientes que precisam desses serviços em Maringá e região, permitindo cadastro, busca, comparação, contratação e avaliação de prestadores.

Projeto acadêmico desenvolvido para a disciplina de Engenharia de Software (Unicesumar), como parte da Atividade Extensionista de Prática (AEP).

**Objetivo de Desenvolvimento Sustentável:** ODS 8, Trabalho Decente e Crescimento Econômico.

## Integrantes

| Integrante | RA |
|---|---|
| Eduardo Gomes Michelon | 25068570-2 |
| Pedro Henrique de Souza Castilho | 25000689-2 |
| Pietro Borim Berbert | 25177983-2 |

## Estrutura do repositório

```
marido-de-aluguel/
├── src/
│   ├── backend/    # API em Java com Spring Boot (2º Bimestre)
│   └── frontend/   # Aplicação de página única em HTML, CSS e JavaScript (2º Bimestre)
├── docs/           # Documento completo da AEP e diagramas (UML e DER)
└── database/       # Script de criação do banco de dados (PostgreSQL)
```

O código funcional do backend e do frontend será desenvolvido a partir do 2º Bimestre. Nesta primeira entrega, o repositório contém apenas a estruturação do projeto: documentação, diagramas e o script de banco de dados.

## Documentação completa

O documento de arquitetura e requisitos (AEP 1º Bimestre), com a descoberta do problema, os stakeholders, a matriz de rastreabilidade, a justificativa técnica e os diagramas de classes e de banco de dados, está disponível em [`docs/1-AEP_1Bimestre_Marido_de_Aluguel-NOVO.pdf](docs/1-AEP_1Bimestre_Marido_de_Aluguel-NOVO.pdf).

## Lista de requisitos funcionais

- **RF01.** O sistema deve permitir o cadastro e a autenticação de usuários, informando nome completo, e-mail, telefone, senha, endereço (rua, bairro e cidade) e o tipo de perfil, que pode ser cliente ou prestador. O e-mail e o telefone informados são validados, e cada perfil recebe permissões de acesso próprias.

- **RF02.** O sistema deve permitir que o prestador cadastre suas ofertas de serviço, informando o nome do serviço, a categoria, uma descrição, o raio de atendimento em quilômetros, o modelo de cobrança (por hora ou por empreitada) e o valor base correspondente.

- **RF03.** O sistema deve permitir que o cliente busque ofertas de serviço por categoria, aplicando filtros de faixa de preço mínima e máxima, nota mínima do prestador e distância máxima em quilômetros a partir do endereço informado. Os resultados podem ser ordenados por preço, por nota ou por distância.

- **RF04.** O sistema deve permitir a comparação simultânea de até três ofertas de serviço escolhidas pelo cliente, mostrando em uma única tela o nome do prestador, o valor estimado, a nota média, a quantidade de serviços concluídos e a distância de cada uma.

- **RF05.** O sistema deve permitir a abertura e o acompanhamento de ordens de serviço, registrando o cliente, o prestador, a oferta contratada, a data de abertura e o status atual. A ordem percorre os estados `Aberta`, `Aceita`, `Em execução`, `Concluída` e `Cancelada`, e cada mudança de status fica registrada com data e hora.

- **RF06.** O sistema deve permitir que o cliente avalie o prestador atribuindo uma nota de 1 a 5, um comentário textual e a data do registro. Essa avaliação só pode ser feita depois que a ordem de serviço correspondente for concluída, e a nota média exibida no perfil público do prestador é recalculada automaticamente a cada nova avaliação.

- **RF07.** O sistema deve permitir a geração de relatórios consolidados por prestador, reunindo a quantidade de serviços concluídos, o faturamento total do período e a evolução da nota média ao longo do tempo.

### Requisitos não funcionais

- **RNF01 (Desempenho).** A listagem de resultados de busca com filtros aplicados deve ser devolvida em até 2 segundos, considerando uma base de até 5.000 prestadores cadastrados.

- **RNF02 (Segurança).** As senhas devem ser armazenadas em formato de hash com salt (BCrypt), a comunicação entre cliente e servidor deve ocorrer sobre HTTPS, e cada endpoint deve validar o perfil do usuário autenticado antes de executar a operação.

- **RNF03 (Usabilidade).** A interface deve ser responsiva a partir de 320 px de largura e funcionar como uma aplicação de página única (SPA), sem recarregamento completo entre as etapas de busca, comparação e contratação.

- **RNF04 (Integridade).** Cada avaliação deve estar vinculada a exatamente uma ordem de serviço concluída e permanecer imutável após o envio, o que garante a rastreabilidade da reputação exibida.

## Cronograma (2º Bimestre)

| Sprint / Data | Épico | User Story | Responsável |
|---|---|---|---|
| Sprint 1<br>05/09 a 19/09 | Identidade e Acesso | **COMO UM** prestador autônomo **EU QUERO** criar minha conta e manter meu perfil profissional **PARA QUE** eu tenha uma vitrine própria e deixe de depender apenas de indicação. | Eduardo Michelon |
| Sprint 2<br>20/09 a 04/10 | Catálogo e Busca | **COMO UM** cliente **EU QUERO** buscar profissionais por categoria e filtrar por preço, nota e distância **PARA QUE** eu encontre rapidamente quem atende o meu bairro. | Pedro Castilho |
| Sprint 3<br>05/10 a 19/10 | Comparação e Ordem de Serviço | **COMO UM** cliente **EU QUERO** comparar até três profissionais lado a lado e abrir a ordem de serviço pelo próprio sistema **PARA QUE** eu contrate com segurança e sem negociar no escuro. | Pietro Berbert |
| Sprint 4<br>20/10 a 03/11 | Reputação e Relatórios | **COMO UM** cliente **EU QUERO** avaliar o serviço após a conclusão e, **COMO UM** prestador, acompanhar meus indicadores **PARA QUE** a reputação exibida reflita apenas trabalhos realmente executados. | Eduardo, Pedro e Pietro |

## Arquitetura e tecnologias

- **Backend:** Java com Spring Boot, organizado em camadas (`Controller`, `Service`, `Repository`).
- **Banco de dados:** PostgreSQL, acessado por meio de uma API REST.
- **Frontend:** aplicação de página única (SPA) em HTML, CSS e JavaScript puro.

A justificativa completa dessas escolhas está na seção 5 do documento em [`docs/1-AEP_1Bimestre_Marido_de_Aluguel-NOVO.pdf`](docs/1-AEP_1Bimestre_Marido_de_Aluguel-NOVO.pdf).

## Diagramas

Os diagramas de classes (UML) e de banco de dados (DER), incluindo a explicação de herança, composição 1:N e polimorfismo utilizados no modelo, estão em [`docs/`](docs/):

- [`docs/1-Diagrama-classes-UML-NOVO.png`](docs/1-Diagrama-classes-UML-NOVO.png)
- [`docs/diagrama-banco-der.png`](docs/1-Diagrama_banco-Der.png)

## Banco de dados

O script de criação das tabelas (`usuarios`, `servicos`, `ordens_servico` e `avaliacoes`), coerente com o DER do documento, está em [`database/schema.sql`](database/schema.sql).
