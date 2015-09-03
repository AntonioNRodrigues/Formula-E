DROP TABLE participa;
DROP TABLE corrida;
DROP TABLE piloto;
DROP TABLE equipa;
-- ---
CREATE TABLE equipa (
 sigla CHAR(4), -- Identificador mais curto de equipa.
 nome VARCHAR2(80) CONSTRAINT nn_equipa_nome NOT NULL,
 pais VARCHAR2(50) CONSTRAINT nn_equipa_pais NOT NULL,
 fundacao NUMBER(4) CONSTRAINT nn_equipa_fundacao NOT NULL, -- Só ano.
--
 CONSTRAINT pk_equipa
 PRIMARY KEY (sigla),
--
 CONSTRAINT un_equipa_nome
 UNIQUE (nome),
--
 CONSTRAINT ck_equipa_fundacao
 CHECK (fundacao > 1800)
);
CREATE TABLE piloto (
 id NUMBER(4),
 nome VARCHAR2(80) CONSTRAINT nn_piloto_nome NOT NULL,
 pais VARCHAR2(50) CONSTRAINT nn_piloto_pais NOT NULL,
 nascimento NUMBER(4) CONSTRAINT nn_piloto_nascimento NOT NULL, -- Só ano.
 genero CHAR(1) CONSTRAINT nn_piloto_genero NOT NULL,
 equipa CONSTRAINT nn_piloto_equipa NOT NULL,
--
 CONSTRAINT pk_piloto
 PRIMARY KEY (id),
--
 CONSTRAINT fk_piloto_equipa
 FOREIGN KEY (equipa)
 REFERENCES equipa(sigla),
--
 CONSTRAINT ck_piloto_id
 CHECK (id > 0),
 CONSTRAINT ck_piloto_nascimento
 CHECK (nascimento > 1900),
 CONSTRAINT ck_piloto_genero
 CHECK (genero IN ('F', 'M'))
);
CREATE TABLE corrida (
 ordem NUMBER(2), -- Número de ordem da corrida na temporada.
 cidade VARCHAR2(50) CONSTRAINT nn_corrida_cidade NOT NULL,
 pais VARCHAR2(50) CONSTRAINT nn_corrida_pais NOT NULL,
 voltas NUMBER(2) CONSTRAINT nn_corrida_voltas NOT NULL,
--
 CONSTRAINT pk_corrida
 PRIMARY KEY (ordem),
--
 CONSTRAINT un_corrida_cidade_pais
 UNIQUE (cidade, pais),
--
 CONSTRAINT ck_corrida_ordem
 CHECK (ordem BETWEEN 1 AND 10),
 CONSTRAINT ck_corrida_voltas
 CHECK (voltas > 0)
);
CREATE TABLE participa (
 piloto,
 corrida,
 pontos NUMBER(2) CONSTRAINT nn_participa_pontos NOT NULL,
--
 CONSTRAINT pk_participa
 PRIMARY KEY (piloto, corrida),
--
 CONSTRAINT fk_participa_piloto
 FOREIGN KEY (piloto)
 REFERENCES piloto(id),
 CONSTRAINT fk_participa_corrida
 FOREIGN KEY (corrida)
 REFERENCES corrida(ordem),
--
 CONSTRAINT ck_participa_pontos
 CHECK (pontos IN (0, 1, 2, 4, 6, 8, 10, 12, 15, 18, 25))
);