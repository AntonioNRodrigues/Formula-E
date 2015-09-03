--
INSERT INTO Temporada(Ano) 
    VALUES ('2014/2015');

INSERT INTO CarroTipo 
    (marca, comprimento, largura, altura, alturaSolo, potencia, pesoBaterias)
	VALUES ('Spark-Renault SRT_01E', 5000, 1800, 1250, 75, 200, 320);

INSERT INTO Equipa (nome, nacionalidade, dataFundacao, site, chefe, carro)
  	VALUES ('AMLIN AGURI', 'Japao', TO_DATE('2014/01/01', 'YYYY/MM/DD'), 
    'www.amlin-aguri.com', NULL, 'Spark-Renault SRT_01E');

INSERT INTO MembrosEquipa (passaporte, nomeMembro, dataNascimento, 
    nacionalidade, genero, funcao, equipa) 
	VALUES (111111114,'Mark Preston',TO_DATE('1900/01/01', 'YYYY/MM/DD'),
    'Australiana','masculino', 'Team Principal', 'AMLIN AGURI'); 

UPDATE Equipa
SET Chefe = 111111114;

INSERT INTO MembrosEquipa (passaporte, nomeMembro, dataNascimento, 
    nacionalidade, genero, funcao, equipa) 
  VALUES (111111113,'Katherine Legge',TO_DATE('1980/07/12', 'YYYY/MM/DD'),
  'Americana','feminino', 'Piloto Principal' , 'AMLIN AGURI'); 

INSERT INTO MembrosEquipa (passaporte, nomeMembro, dataNascimento, 
  nacionalidade, genero, funcao, equipa) 
	VALUES (111111111,'Antonio Felix da Costa',TO_DATE('1991/08/31', 'YYYY/MM/DD'),
    'Portuguesa','masculino', 'Piloto Principal', 'AMLIN AGURI'); 

INSERT INTO MembrosEquipa (passaporte, nomeMembro, dataNascimento, 
  nacionalidade, genero, funcao, equipa) 
  VALUES (111111112,'Fabio Leimer',TO_DATE('1989-04-17', 'YYYY/MM/DD'),
    'Suica','masculino','Piloto Reserva', 'AMLIN AGURI');

INSERT INTO NaoPiloto (passaporte) 
  	VALUES (111111114); 

INSERT INTO Piloto (passaporte, dorsal)
	VALUES (111111113, 77);

INSERT INTO Piloto (passaporte, dorsal)
	VALUES (111111111, 55);

INSERT INTO Piloto (passaporte, dorsal)
	VALUES (111111112, 99);

INSERT INTO Patrocinador(nome)
	VALUES ('Amlin');

INSERT INTO TemporadaEquipaMembros (ano, equipa, passaporte)
	VALUES ('2014/2015', 'AMLIN AGURI', 111111114);

INSERT INTO TemporadaEquipaMembros (ano, equipa, passaporte)
	VALUES ('2014/2015', 'AMLIN AGURI', 111111113);

INSERT INTO TemporadaEquipaMembros (ano, equipa, passaporte)
	VALUES ('2014/2015', 'AMLIN AGURI', 111111112);

INSERT INTO TemporadaEquipaMembros (ano, equipa, passaporte)
	VALUES ('2014/2015', 'AMLIN AGURI', 111111111);

INSERT INTO Equipa_tem_Patrocinador (nomeEquipa, nomePatrocinador)
	VALUES ('AMLIN AGURI', 'Amlin');

INSERT INTO Circuito (pais, numeroCurvas, cidade, numeroKm)
	VALUES ('China', 20 , 'Beijing', 3.44);

INSERT INTO Corrida (ronda, dataProva, circuito)
	VALUES (1,TO_DATE('2014/09/13', 'YYYY/MM/DD'),'Beijing');

INSERT INTO Temporada_tem_Corrida (dataProva, temporada)
	VALUES (TO_DATE('2014/09/13', 'YYYY/MM/DD'), '2014/2015');

INSERT INTO Treina (piloto, corrida, numVoltas, melhorTempoVolta)
	VALUES (111111113, TO_DATE('2014/09/13', 'YYYY/MM/DD'), 7, 106171);

INSERT INTO Qualifica (piloto, corrida, numVoltas, melhorTempoVolta)
	VALUES (111111113, TO_DATE('2014/09/13', 'YYYY/MM/DD'), 5, 105369);

INSERT INTO Treina (piloto, corrida, numVoltas, melhorTempoVolta)
	VALUES (111111111, TO_DATE('2014/09/13', 'YYYY/MM/DD'), 4, 148499);


INSERT INTO Qualifica (piloto, corrida, numVoltas, melhorTempoVolta)
	VALUES (111111111, TO_DATE('2014/09/13', 'YYYY/MM/DD'), 5, 104129);


INSERT INTO Corre (piloto, corrida, numVoltas, melhorTempoVolta, posicao, 
    voltaMelhorTempo) 
  VALUES (111111113, TO_DATE('2014/09/13', 'YYYY/MM/DD'), 24, 108753, 15, 21);


INSERT INTO Corre (piloto, corrida, numVoltas, melhorTempoVolta, posicao, 
    voltaMelhorTempo) 
  VALUES (111111111, TO_DATE('2014/09/13', 'YYYY/MM/DD'), 21, 105101, 21, 21);

--