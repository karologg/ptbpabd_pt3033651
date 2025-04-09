--questao 1--
SELECT * FROM student JOIN takes ON student.ID  = takes.ID; --cria e mostra uma relação com base no --

--questao 2--
SELECT student.ID, student.name, COUNT(takes.course_id) AS Quantidade_de_cursos --apresenta id, nome e contagem de cursos de cada estudante seguindo as regras abaixo--
FROM student JOIN takes ON student.ID = takes.ID --conta a quantidade de cursos de cada estudante e coleta o id e nome de cada um--
WHERE student.dept_name = 'Civil Eng' --especifica que a coleta será feita apenas com estudantes do curso de Civil Eng--
GROUP BY student.ID, student.name --agrupa as informações dos alunos por id e nome, possibilitando a contagem de cursos de cada aluno com o COUNT--
ORDER BY Quantidade_de_cursos DESC; --ordena a lista pela ordem decrescente de quantidade de cursos--

--questao 3--
CREATE view civil_eng_students as SELECT student.ID, student.name, COUNT(takes.course_id) as Quantidade_de_cursos --criando view com o contador de cursos--
FROM student JOIN takes ON student.ID = takes.ID --retira informações da relação de student com takes--
WHERE student.dept_name = 'Civil Eng' --filtra o uso de conteúdos apenas para estudantes de Civil Eng--
GROUP BY student.ID, student.name; --agrupa registros de cada estudante com base em id e nome, possibilitando a contagem de cursos de cada aluno com o COUNT--

