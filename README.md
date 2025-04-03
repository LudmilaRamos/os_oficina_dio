# Sistema de Controle e Gerenciamento de Ordem de Serviço em Oficina Mecânica

## Descrição do Projeto

Este sistema foi desenvolvido para gerenciar a execução de ordens de serviço em uma oficina mecânica. O objetivo do sistema é controlar os serviços realizados em veículos de clientes, como manutenções e consertos, além de calcular os valores dos serviços com base no tempo de mão de obra e peças utilizadas.

## Entidades

- **Cliente**: Representa os clientes que levam os veículos à oficina.
- **Veículo**: Representa os veículos que são consertados ou passam por revisão.
- **Orçamento**: Orçamento prévio dos serviços que serão necessários com valores, peças e validade 
- **Ordem de Serviço (OS)**: Controla as ordens de serviço, com todos os detalhes sobre os serviços a serem executados, valores, status e datas.
- **Equipe**: Representa as equipes de mecânicos responsáveis pelos serviços.
- **Mecânico**: Representa os mecânicos que compõem as equipes.
- **Peça**: Representa as peças usadas durante os serviços.

## Relacionamentos

- Um cliente pode ter vários veículos.
- Um veículo pode ter várias ordens de serviço.
- Cada ordem de serviço é associada a uma equipe de mecânicos.
- A ordem de serviço pode envolver várias peças.

## Diagrama



[![Ordem serviço oficina](Ordem%20servico%20oficina.png)](https://github.com/LudmilaRamos/os_oficina_dio/blob/main/Ordem%20servi%C3%A7o%20oficina.png)
