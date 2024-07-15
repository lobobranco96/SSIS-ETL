# CASE DO PROJETO: 
  - Utilizar o SQL INTEGRATION SERVICE PARA INGERIR OS DADOS BAIXADOS (CSV) NO SQL SERVER EM UMA PIPELINE DE ETL
  - Extrair os dados do INEP do enem de 2020 "https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem" e carregar os dados em um banco de dados em uma tabela desnormalizada.
  - Modelar em formato star schema com tabela fato e dimensão:
    - Foi utilizada uma tabelas de fato sem fato para armazenar apenas chaves estrangeiras para tabelas dimensionais
  - Responder 8 perguntas criadas para tirar insights.


# ENEM SQL SERVER INTEGRATION SERVICE
![fluxo_dados_OK](https://github.com/user-attachments/assets/30e3113b-53de-488b-bc72-18cf8837d166)
![fluxo_controle_OK](https://github.com/user-attachments/assets/7167a2bc-72d3-4db6-a70c-a0d86b743d28)

# Modelo Star Schema
![STAR_SCHEMA](https://github.com/user-attachments/assets/580ccf5a-412a-4d4e-b230-f04f3e2e60ad)

# Projeto de ETL
  - PERGUNTAS RESPONDIDAS:
    - 1 ) Qual a escola com a maior média de notas?
      - ![pergunta_1](https://github.com/user-attachments/assets/9a65ed6b-28b9-4679-b9bb-bf8a6091e627)
    - 2 ) Os 10 alunos com a maior média de notas e o valor dessa média?
      - ![pergunta_2](https://github.com/user-attachments/assets/52962629-3b81-4e5a-9e23-d97814346110)
    - 3 ) Qual a média geral?
      - ![pergunta_3](https://github.com/user-attachments/assets/7486dc19-7527-47c5-b1fc-4d23ea0b7800)
    - 4 ) Qual o % de Ausentes?
       - ![pergunta_4](https://github.com/user-attachments/assets/ef8068bf-bac7-41c5-b853-0b1afec677a6)
    - 5 ) Qual o número total de Inscritos?
      - ![pergunta_5](https://github.com/user-attachments/assets/40e521b0-ba7d-412b-bdda-d33dcf9a65f5)
    - 6 ) Qual a média por disciplina?
     - ![pergunta_6](https://github.com/user-attachments/assets/80fe0df2-5b43-4d0f-a77e-a8e180884ce3)
    - 7 ) Qual a média por Sexo?
     - ![pergunta_7](https://github.com/user-attachments/assets/f30a7814-6f0c-4a8f-9a1f-b87e45bc4449)
    - 8 ) Qual a média por Etnia?
      - ![pergunta_8](https://github.com/user-attachments/assets/afc01bbf-2653-4a61-b5bf-45ecf53ffe8b)
   

