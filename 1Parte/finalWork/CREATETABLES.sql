CREATE TABLE Temporada( 
  	ano VARCHAR (10),
    CONSTRAINT PK_TEMPORADA PRIMARY KEY (ano)
);


CREATE TABLE CarroTipo(
	marca VARCHAR(100),
	comprimento NUMBER,
	largura NUMBER,
	altura NUMBER,
	alturaSolo NUMBER,
	potencia NUMBER,
	pesoBaterias NUMBER,
	CONSTRAINT PK_CarroTipo PRIMARY KEY (marca)
);

CREATE TABLE MembrosEquipa(
    	passaporte NUMBER,
    	nomeMembro VARCHAR (200) NOT NULL,
    	dataNascimento DATE,
    	nacionalidade VARCHAR (100),
    	genero VARCHAR(10),
    	funcao VARCHAR(100) NOT NULL,
   		CONSTRAINT PK_MembrosEquipa PRIMARY KEY (passaporte)
);

CREATE TABLE Equipa( 
	nome VARCHAR (200), 
	nacionalidade VARCHAR (100), 
	dataFundacao DATE, 
	site VARCHAR (200),
	chefe NUMBER,
  	carro VARCHAR (100) NOT NULL,
	PRIMARY KEY (nome),
  	FOREIGN KEY (chefe) REFERENCES MembrosEquipa(passaporte) ON DELETE CASCADE,
  	FOREIGN KEY (carro) REFERENCES CarroTipo(marca),
  	UNIQUE(chefe)
);

ALTER TABLE MembrosEquipa ADD (
  equipa VARCHAR (200) NOT NULL, 
  FOREIGN KEY (equipa) REFERENCES Equipa(nome), 
  UNIQUE (equipa, passaporte) 
);

CREATE TABLE NaoPiloto(
	passaporte NUMBER,
	PRIMARY KEY (passaporte),
	FOREIGN KEY (passaporte) REFERENCES MembrosEquipa(passaporte) ON DELETE CASCADE
);

CREATE TABLE Piloto(
	passaporte NUMBER,
	dorsal NUMBER NOT NULL,
	PRIMARY KEY (passaporte),
	FOREIGN KEY (passaporte) REFERENCES MembrosEquipa(passaporte)ON DELETE CASCADE,
  UNIQUE (dorsal)
);

CREATE TABLE Patrocinador(
	nome VARCHAR (200),
	PRIMARY KEY (nome)
);

CREATE TABLE TemporadaEquipaMembros(
	ano VARCHAR (10),
	equipa VARCHAR (200),
  passaporte NUMBER,
	PRIMARY KEY (ano, equipa, passaporte),
	FOREIGN KEY (ano) REFERENCES Temporada(ano),
  FOREIGN KEY (equipa, passaporte) REFERENCES MembrosEquipa(equipa, passaporte)
);

CREATE TABLE Equipa_tem_Patrocinador (
	nomeEquipa VARCHAR (200),
	nomePatrocinador VARCHAR (200),
	PRIMARY KEY (nomeEquipa, nomePatrocinador),
	FOREIGN KEY (nomeEquipa) REFERENCES Equipa (nome),
	FOREIGN KEY (nomePatrocinador) REFERENCES Patrocinador (nome)
);


CREATE TABLE Circuito(
	pais VARCHAR (200) NOT NULL,
	numeroCurvas NUMBER,
	cidade VARCHAR (200),
	numeroKm NUMBER,
	PRIMARY KEY (cidade)
);

CREATE TABLE Corrida(
	ronda NUMBER NOT NULL,
	dataProva DATE,
	circuito VARCHAR(200) NOT NULL,
	PRIMARY KEY (dataProva),
	FOREIGN KEY (circuito) REFERENCES Circuito (cidade)
);

CREATE TABLE Temporada_tem_Corrida(
	dataProva DATE ,
	temporada VARCHAR(10),
	PRIMARY KEY (dataProva, temporada),
	FOREIGN KEY (temporada) REFERENCES Temporada (ano),
	FOREIGN KEY (dataProva) REFERENCES Corrida (dataProva)
);

CREATE TABLE Treina (
	piloto NUMBER,
	corrida DATE,
	numVoltas NUMBER NOT NULL,
	melhorTempoVolta NUMBER NOT NULL,
	PRIMARY KEY (piloto, corrida),
	FOREIGN KEY (piloto) REFERENCES Piloto(passaporte),
	FOREIGN KEY (corrida) REFERENCES Corrida(dataProva)
);

CREATE TABLE Qualifica (
	piloto NUMBER,
	corrida DATE,
	numVoltas NUMBER NOT NULL,
	melhorTempoVolta NUMBER NOT NULL,
	PRIMARY KEY (piloto, corrida),
	FOREIGN KEY (piloto) REFERENCES Piloto(passaporte),
	FOREIGN KEY (corrida) REFERENCES Corrida(dataProva)
);

CREATE TABLE Corre (
	piloto NUMBER,
	corrida DATE,
	numVoltas NUMBER NOT NULL,
	melhorTempoVolta NUMBER NOT NULL,
	posicao NUMBER NOT NULL, 
	voltaMelhorTempo NUMBER NOT NULL,
	PRIMARY KEY (piloto, corrida),
	FOREIGN KEY (piloto) REFERENCES Piloto(passaporte),
	FOREIGN KEY (corrida) REFERENCES Corrida(dataProva)
);
