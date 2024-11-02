CREATE TABLE alunos (
    id_aluno NUMBER PRIMARY KEY,
    nome VARCHAR2(100),
    data_nascimento DATE
);

CREATE TABLE cursos (
    id_curso NUMBER PRIMARY KEY,
    nome_curso VARCHAR2(100)
);

CREATE TABLE professores (
    id_professor NUMBER PRIMARY KEY,
    nome_professor VARCHAR2(100),
    especialidade VARCHAR2(100)
);

CREATE TABLE disciplinas (
    id_disciplina NUMBER PRIMARY KEY,
    nome_disciplina VARCHAR2(100),
    carga_horaria NUMBER,
    id_curso NUMBER,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE matriculas (
    id_matricula NUMBER PRIMARY KEY,
    id_aluno NUMBER,
    id_disciplina NUMBER,
    data_matricula DATE,
    status_matricula VARCHAR2(50),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

CREATE TABLE turmas (
    id_turma NUMBER PRIMARY KEY,
    id_professor NUMBER,
    id_disciplina NUMBER,
    horario VARCHAR2(50),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

SELECT nome, data_nascimento 
FROM alunos 
ORDER BY nome ASC, data_nascimento ASC;

SELECT nome_professor, especialidade
FROM professores
ORDER BY nome_professor DESC;

SELECT nome_disciplina, carga_horaria
FROM disciplinas
ORDER BY carga_horaria DESC;

SELECT status_matricula, COUNT(*) AS numero_de_alunos
FROM matriculas
GROUP BY status_matricula;

SELECT c.nome_curso, SUM(d.carga_horaria) AS total_carga_horaria
FROM cursos c
JOIN disciplinas d ON c.id_curso = d.id_curso
GROUP BY c.nome_curso;

SELECT p.nome_professor
FROM professores p
JOIN turmas t ON p.id_professor = t.id_professor
GROUP BY p.nome_professor
HAVING COUNT(t.id_turma) > 3;

SELECT a.nome, COUNT(m.id_disciplina) AS numero_disciplinas
FROM alunos a
JOIN matriculas m ON a.id_aluno = m.id_aluno
GROUP BY a.nome
HAVING COUNT(m.id_disciplina) > 1
ORDER BY numero_disciplinas DESC;

SELECT c.nome_curso, SUM(d.carga_horaria) AS total_carga_horaria
FROM cursos c
JOIN disciplinas d ON c.id_curso = d.id_curso
GROUP BY c.nome_curso
HAVING SUM(d.carga_horaria) > 2000;

SELECT p.nome_professor, COUNT(t.id_turma) AS total_turmas
FROM professores p
JOIN turmas t ON p.id_professor = t.id_professor
GROUP BY p.nome_professor
ORDER BY total_turmas DESC;

SELECT c.nome_curso, AVG(d.carga_horaria) AS media_carga_horaria
FROM cursos c
JOIN disciplinas d ON c.id_curso = d.id_curso
GROUP BY c.nome_curso;

SELECT a.nome, m.status_matricula, m.data_matricula
FROM alunos a
JOIN matriculas m ON a.id_aluno = m.id_aluno
ORDER BY m.status_matricula, m.data_matricula DESC;

SELECT nome, 
       TRUNC((SYSDATE - data_nascimento) / 365.25) AS idade
FROM alunos
ORDER BY idade DESC;

SELECT d.nome_disciplina, COUNT(m.id_aluno) AS numero_de_alunos
FROM disciplinas d
JOIN matriculas m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome_disciplina
ORDER BY numero_de_alunos DESC;

SELECT t.horario, p.nome_professor, d.nome_disciplina
FROM turmas t
JOIN professores p ON t.id_professor = p.id_professor
JOIN disciplinas d ON t.id_disciplina = d.id_disciplina
ORDER BY t.horario;

SELECT COUNT(*) AS numero_de_disciplinas
FROM disciplinas
WHERE carga_horaria > 80;

SELECT c.nome_curso, COUNT(d.id_disciplina) AS quantidade_disciplinas
FROM cursos c
JOIN disciplinas d ON c.id_curso = d.id_curso
GROUP BY c.nome_curso;

SELECT p.nome_professor, COUNT(d.id_disciplina) AS numero_disciplinas
FROM professores p
JOIN turmas t ON p.id_professor = t.id_professor
JOIN disciplinas d ON t.id_disciplina = d.id_disciplina
WHERE d.carga_horaria > 100
GROUP BY p.nome_professor
HAVING COUNT(d.id_disciplina) > 2;

SELECT d.nome_disciplina, COUNT(m.id_aluno) AS numero_de_alunos
FROM disciplinas d
JOIN matriculas m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome_disciplina
HAVING COUNT(m.id_aluno) >= 5
ORDER BY numero_de_alunos DESC;

SELECT status_matricula, COUNT(*) AS numero_de_alunos
FROM matriculas
GROUP BY status_matricula
ORDER BY numero_de_alunos DESC;

SELECT p.nome_professor, SUM(d.carga_horaria) AS total_carga_horaria
FROM professores p
JOIN turmas t ON p.id_professor = t.id_professor
JOIN disciplinas d ON t.id_disciplina = d.id_disciplina
GROUP BY p.nome_professor
ORDER BY total_carga_horaria DESC;
