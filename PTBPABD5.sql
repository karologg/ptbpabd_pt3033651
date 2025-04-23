/*TRANSAÇÕES E INTEGRIDADE I, SEMANA 05*/

--QUESTÃO 01--
CREATE TABLE pessoa ( --criando tabela com informação dessas condições abaixo 
    ID INT, --adiciona id com numeros inteiros
    nome VARCHAR(50), --nome com espaço de 50 caracteres
    sobenome VARCHAR(50), --sobrenome com espaço de 50 caracteres
    idade INT CHECK (idade >= 0) --idade, com limitação de maior ou igual a 0
);

--QUESTÃO 02--
ALTER TABLE pessoa --editando tabela pessoa
ADD CONSTRAINT unqIDNomeSobrenome UNIQUE (ID, nome, sobrenome); --adicionando unique ao id, nome e sobrenome, impedindo dados duplicados ou iguais

--QUESTÃO 03--
ALTER TABLE pessoa --editando tabela pessoa
MODIFY idade INT NOT NULL; --faz com que a coluna da idade não possa ficar vazia

--QUESTÃO 04--
CREATE TABLE endereco ( --criando tabela endereço com:
    ID INT PRIMARY KEY, --id para cada endereço
    rua VARCHAR(100) --rua com espaço de 50 caracteres
);

ALTER TABLE pessoa --editando tabela pessoa
ADD endereco_id INT; --criando mais uma coluna para colocar o id do endereço da pessoa

ALTER TABLE pessoa ADD CONSTRAINT fk_pessoa_endereco --cria uma restrição com as regras de:
FOREIGN KEY (endereco_id) --a fk endereco_id faça uma referencia à coluna ID de endereço
REFERENCES endereco(ID);--criando a referencia
