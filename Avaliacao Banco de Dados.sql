CREATE DATABASE laura_muglia_avaliacao

;

GRANT ALL PRIVILEGES ON laura_muglia_avaliacao.* TO 'laura_muglia'@'%'

; 

FLUSH PRIVILEGES

;

USE laura_muglia_avaliacao

;

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
)

;

CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
)

;

CREATE TABLE produtos_categorias (
    produto_id INTEGER REFERENCES produtos(id),
    categoria_id INTEGER REFERENCES categorias(id),
    PRIMARY KEY (produto_id, categoria_id)
)

;


/* Exercício 3 */

SELECT 
    p.nome as Produto,
	p.preco as Valor
FROM produtos AS p
WHERE p.preco > 100
ORDER BY p.preco, p.nome

;

/* Exercício 4 */

SELECT 
	p.id,
    p.preco as Valor
FROM produtos p 
WHERE p.preco > (SELECT AVG(p.preco) FROM produtos)

;

/* Exercício 5 */

CREATE OR REPLACE VIEW media AS
SELECT 
    c.nome as Categoria,
    ROUND(AVG(p.preco), 0) AS media
FROM categorias AS c 
LEFT JOIN produtos_categorias AS pc ON pc.categoria_id = c.id
LEFT JOIN produtos AS p ON pc.produto_id = p.id

;

SELECT 
    c.nome as Categoria,
	m.media as Preco_medio
FROM categorias AS c
LEFT JOIN media AS m ON m.Categoria = c.nome 
WHERE m.media IS NOT NULL
ORDER BY c.nome

;

/* Exercício 6 */

CREATE TABLE turma (
    id_turma INT PRIMARY KEY,
    codigo_turma VARCHAR(100) NOT NULL,
    nome_turma VARCHAR(100) NOT NULL)

;

CREATE TABLE aluno (
    id_aluno INT PRIMARY KEY,
    nome_aluno VARCHAR(100) NOT NULL,
    aluno_alocado BOOLEAN,
    id_turma INT)

;

ALTER TABLE aluno ADD FOREIGN KEY(id_turma) REFERENCES turma (id_turma) 

;

/* Exercício 7 */

-- a)

INSERT INTO turma VALUES (1, 648, 'Data Science'), (2, 854, 'Front End')
 
;

-- b)

INSERT INTO aluno VALUES (53, 'Ricardo José', null, 1), (54, 'Kleber Leandro', null, 2)

;

-- c)

INSERT INTO aluno VALUES (55, 'Larissa Miguela', null, null), (56, 'Helen Thiaga', null, null)

;

-- d)

UPDATE aluno SET aluno_alocado = CASE id_aluno 
				WHEN 53 THEN TRUE
                WHEN 54 THEN TRUE
				WHEN 55 THEN FALSE
				WHEN 56 THEN FALSE 
                END
WHERE id_aluno IN (53,54,55,56)

;