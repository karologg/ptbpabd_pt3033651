// Comando: use <nome_do_banco>
// Explicação: Define o banco de dados em uso no momento.
// Caso ele ainda não exista, será criado automaticamente assim que um dado for inserido.
use IFSP;

// Comando: show dbs
// Explicação: Mostra a lista de todos os bancos de dados presentes na instância do MongoDB atual.
show dbs;

// Comando: db
// Explicação: Representa o banco de dados selecionado atualmente. 
// Ao digitá-lo, o shell exibe o nome do banco que está ativo.
db;

// Agora vamos mudar para outro banco de dados chamado 'AulaDB'
// A coleção que usaremos dentro dele vai se chamar 'contatos' — conforme padrão sugerido na aula
use AulaDB;

// Comando: show collections
// Explicação: Lista todas as coleções (semelhantes a tabelas em bancos relacionais) do banco atual.
show collections;

// Inserindo registros na coleção
// Comando: db.<colecao>.insertOne(objeto) ou db.<colecao>.insertMany([objeto1, objeto2])
// Explicação: Adiciona um ou mais documentos (semelhantes a registros) à coleção desejada.
db.IFSP.insertMany([
    {
        "nome": "Karolina Gotto",
        "email": "g.karolina@aluno.ifsp.edu.br"
    },
    {
        "nome": "karolina gotto",
        "email": "karoloarchive@gmail.com"
    }
]);

// Comando: db.<colecao>.find()
// Explicação: Busca e retorna todos os documentos armazenados na coleção.
db.IFSP.find();

// Comando: db.<colecao>.countDocuments()
// Explicação: Informa a quantidade total de documentos dentro da coleção especificada.
db.IFSP.countDocuments();

// Exemplo de busca com filtro
// Comando: db.<colecao>.find({ campo: valor })
// Explicação: Mostra apenas os documentos que possuem o campo com o valor indicado.
db.IFSP.find({ "nome": "Caio Petiz" });

// Exemplo de modificação de dados
// Comando: db.<colecao>.update(filtro, { $set: { campo: novo_valor } })
// Explicação: Altera o valor de um ou mais campos nos documentos que atendem ao filtro fornecido.
// db.IFSP.update({ "nome": "Caio Petiz" }, { $set: { "email": "novo.email.caio@ifsp.edu.br" } });

// Exemplo de exclusão de documentos
// Comando: db.<colecao>.remove(filtro)
// Explicação: Remove documentos da coleção que correspondem ao critério dado.
// db.IFSP.remove({ "nome": "Livia Teixeira" });

// Para verificar como ficou a coleção após alterações (caso as linhas acima sejam ativadas):
// db.IFSP.find();
