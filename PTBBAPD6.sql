/*TRANSAÇÕES E INTEGRIDADE II, SEMANA 05B*/
--QUESTÃO 01--
CREATE SCHEMA avaliacaocontinua; --criando esquema

--QUESTAO 02--
CREATE TABLE avaliacaocontinua.company ( --cria tabela company no esquema avaliacaocontinua com colunas de:--
    company_name VARCHAR(50) NOT NULL PRIMARY KEY, --nome da companhia como chave primária --
    city VARCHAR(50) --nome da cidade em que a companhia fica--
); --todos com espaço de 50 caracteres--

--QUESTÃO 03--
    person_name VARCHAR(50) NOT NULL PRIMARY KEY, --nome da pessoa (funcionario) como chave primária--
    street VARCHAR (50), --rua da pessoa--
    city VARCHAR(50) --cidade da pessoa--
); --todos com espaço de 50 caracteres--

--QUESTÃO 04--
CREATE TABLE avaliacaocontinua.manages ( --cria tabela manages no esquema avaliacaocontinua com colunas de:--
    person_name VARCHAR(50) NOT NULL PRIMARY KEY, --nome da pessoa a ser gerenciada--
    manager_name VARCHAR(50) --nome do gerente--
);

--QUESTÃO 05--
CREATE TABLE avaliacaocontinua.works ( --cria tabela works no esquema avaliacaocontinua com colunas de:--
    person_name VARCHAR(50) NOT NULL PRIMARY KEY, --nome do funcionario--
    company_name VARCHAR(50) NOT NULL, --companhia onde o funcionario trabalha--
    salary INT--salario desse trabalho--
);

--QUESTÃO 06--
ALTER TABLE works --edita tabela works--
ADD CONSTRAINT FK_works_employee --adicionia restrição--
FOREIGN KEY (person_name) --pede que a fk person_name referencie:--
REFERENCES employee(person_name) --person_name em employee--
ON UPDATE CASCADE --garante edição na tabela works se a informaçao for editada em employee
ON DELETE CASCADE; --garante edição em caso de deleção na tabela employee--

--QUESTAO 07--
ALTER TABLE works --edita tabela works--
ADD CONSTRAINT FK_works_company --adiciona restrição--
FOREIGN KEY (company_name) --pede que a fk company_name referencie: --
REFERENCES company(company_name) --company_name em company--
ON UPDATE CASCADE --garante edição na tabela works se a informação for editada em company
ON DELETE CASCADE; --garante edição em caso de deleção na tabela company--

--QUESTAO 08--
ALTER TABLE manages--edita tabela manages--
ADD CONSTRAINT FK_manages_employee--adiciona restrição--
FOREIGN KEY (person_name)--pede que a fk person_name referencie:--
REFERENCES employee(person_name)--person_name em employee--
ON UPDATE CASCADE --garante edição na tabela manages se a informação for editada em employee
ON DELETE CASCADE; --garante edição em caso de deleção na tabela employee--
