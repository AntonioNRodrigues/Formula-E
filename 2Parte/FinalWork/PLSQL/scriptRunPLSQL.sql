
-- Criação de m sequencia de ids de Pilotos
CREATE SEQUENCE seq_id INCREMENT BY 1 MAXVALUE 9999;

-- Insercao da equipa recorrendo a funcao regista_equipa
BEGIN
  formula_e.regista_equipa('AG', 'Amlin Aguri', 'Japao', 2014);
  formula_e.regista_equipa('AF', 'Andretti Formula E', 'USA', 2014);
  formula_e.regista_equipa('AS', 'Audi Sport ABT', 'Alemanha', 2014);
  formula_e.regista_equipa('CR', 'China Racing', 'China',	2014);
  formula_e.regista_equipa('DR', 'Dragon Racing',	'USA',	2014);
END;
  
-- Tentativa de insercao de uma equipa com sigla ja registada 
-- Lancamento do exception -20002
BEGIN
  formula_e.regista_equipa('AG', 'Amlin Aguri', 'Japao', 2014);
END;

-- Insercao da equipa recorrendo a função regista_equipa
BEGIN
  formula_e.regista_equipa('ER', 'e.dams-Renault', 'Franca', 2014);
  formula_e.regista_equipa('Tr', 'Trulli', 'Suica', 2014);
  formula_e.regista_equipa('Ve', 'Venturi', 'Monaco',2014);
  formula_e.regista_equipa('VR', 'Virgin Racing', 'UK', 2014);
  formula_e.regista_equipa('BMW', 'BMW', 'Alemanha', 2014);
END;

-- Tentativa de insercao de uma 11.º equipa na tabela 
-- Lancamento de uma exception -20001
BEGIN
  formula_e.regista_equipa('FR', 'Ferrari', 'Italia', 1900);
END;

-- Visualizacao do registo de equipas
SELECT * FROM EQUIPA;

-- Insercao da um piloto recorrendo á funcao regista_piloto
VARIABLE idNumber NUMBER;
BEGIN
  :idNumber:=formula_e.regista_piloto('Katherine Legge', 'UK', 1980, 'F', 'AG');
  DBMS_OUTPUT.PUT_LINE(:idNumber);
  :idNumber:=formula_e.regista_piloto('Felix Costa', 'Portugal', 1991, 'M', 'AG');
  DBMS_OUTPUT.PUT_LINE(:idNumber);
End;

-- Tentativa de inserção de um terceiro piloto num equipa 
-- Lancamento de um exception -20003.
BEGIN
   :idNumber:=formula_e.regista_piloto('Costa Felix', 'Portugal', 1991, 'M', 'AG');
END;

-- Insercao de pilotos recorrendo á função regista_piloto
BEGIN
  :idNumber:=formula_e.regista_piloto('Franck Montagny', 'Franca',	1978,	'M', 'AF');
  :idNumber:=formula_e.regista_piloto('Charles Pic', 'França', 1990, 'M', 'AF');
  :idNumber:=formula_e.regista_piloto('Lucas di Grassi', 'Brasil',	1984, 'M', 'AS');
  :idNumber:=formula_e.regista_piloto('Daniel Abt', 'Alemanha', 1992, 'M', 'AS');
  :idNumber:=formula_e.regista_piloto('Nelson Piquet', 'Brasil', 1985, 'M', 'CR');
  :idNumber:=formula_e.regista_piloto('Ho-Pin Tung', 'China', 1982, 'M', 'CR');
  :idNumber:=formula_e.regista_piloto('Oriol Servia', 'Espanha',	1974, 'M', 'DR');
  :idNumber:=formula_e.regista_piloto('Jerome DAmbrosio',	'Belgica', 1985, 'M', 'DR');
END;

-- Visualizacao do registo de pilotos
SELECT * FROM PILOTO;

-- Insercao de pilotos recorrendo á função regista_corrida
BEGIN
  formula_e.regista_corrida(1, 'Pequim',	'China', 20);
  formula_e.regista_corrida(2, 'Putrajaya', 'Malasia', 12);
  formula_e.regista_corrida(3, 'Montevideo', 'Uruguai', 20);
  formula_e.regista_corrida(4, 'Buenos Aires', 'Argentina', 12);
  formula_e.regista_corrida(5, 'Xangai', 'China', 30);
END;

-- Visualizacao do registo de corridas
SELECT * FROM CORRIDA;

-- Tentativa de inserção de uma corrida num local ja existente 
-- Lancamento de um exception -20005.
BEGIN
     formula_e.regista_corrida(6, 'Xangai', 'China', 26);
END;

-- Insercao de pilotos recorrendo á função regista_corrida
BEGIN
  formula_e.regista_corrida(6, 'Londres', 'UK', 30);
  formula_e.regista_corrida(7, 'Nova Iorque', 'USA', 30);
  formula_e.regista_corrida(8, 'Dublin', 'Irlanda', 30);
  formula_e.regista_corrida(9, 'Roma', 'Italia', 30);
  formula_e.regista_corrida(10, 'Madrid', 'Espanha', 30);
END;

-- Visualizacao do registo de corridas
SELECT * FROM Corrida;

--Tentativa de inserção de uma 11.º corrida  
-- Lançamento de exception -20004.
BEGIN
  formula_e.regista_corrida(11, 'Lisboa', 'Portugal', 30);
END;

--Inserção de participações em corridas dos pilotos
BEGIN
  formula_e.regista_participacao(1,1,0);
  formula_e.regista_participacao(1,2,0);
  formula_e.regista_participacao(1,3,1);
  formula_e.regista_participacao(1,4,1);  
  formula_e.regista_participacao(1,5,2);
END;

--Inserção de participações em corridas dos pilotos
BEGIN
  formula_e.regista_participacao(2,1,15);
  formula_e.regista_participacao(2,2,4);
  formula_e.regista_participacao(2,3,6);
  formula_e.regista_participacao(2,4,6);
  formula_e.regista_participacao(2,5,4);
END;

--Inserção de participações em corridas dos pilotos
BEGIN
  formula_e.regista_participacao(3,1,18);
  formula_e.regista_participacao(3,2,10);
  formula_e.regista_participacao(3,3,12);
  formula_e.regista_participacao(3,4,8);
  formula_e.regista_participacao(3,5,6);
END;

--Inserção de participações em corridas dos pilotos
BEGIN
  formula_e.regista_participacao(4,1,0);
  formula_e.regista_participacao(4,2,0);
  formula_e.regista_participacao(4,3,0);
  formula_e.regista_participacao(4,4,0);
  formula_e.regista_participacao(4,5,0);
END;

--Inserção de participações em corridas dos pilotos
BEGIN
  formula_e.regista_participacao(5,1,0);
  formula_e.regista_participacao(5,2,0);
  formula_e.regista_participacao(5,3,0);
  formula_e.regista_participacao(5,4,0);
  formula_e.regista_participacao(5,5,0);
END;

--Verificacao das alteracoes da tabela Participa
SELECT P.nome, Part.pontos, Cor.cidade, Part.corrida, Part.piloto
    FROM Piloto P, Participa Part, Corrida Cor
  WHERE Cor.ordem = Part.corrida
  AND P.id = Part.piloto;

--Tentativa de atribuicao de pontos já existentes  
-- Lançamento de uma exception -20007
BEGIN
  formula_e.regista_participacao(5,1,15);
END;

--tentativa de atribuicao de pontos a um piloto nao existente
--Lançamento de uma exception -20008
BEGIN  
  formula_e.regista_participacao(13,5,25);
END;

--Tentativa de atribuicao de pontos a um piloto numa corrida que nao existe
--Lançamento de uma exception -20006
BEGIN
  formula_e.regista_participacao(3,11,25);
END;

--Tentativa de atribuir um novo registo a um piloto que ja foi previamente registado 
--Lançamento de uma exception 20009
BEGIN
  formula_e.regista_participacao(2,1,0);
END;

--Visualizaçao do registo das Equipas antes da tentativa de remoção de uma delas
SELECT * FROM Equipa;

--Remoção de uma equipa sem pilotos e sem participacoes
BEGIN
  formula_e.remove_equipa('Venturi');
END;

--Remoção de uma equipa com pilotos e sem participacoes
BEGIN
  formula_e.remove_equipa('Dragon Racing');
END;

--Remoção de uma equipa com pilotos com participacoes
BEGIN
  formula_e.remove_equipa('Amlin Aguri');
END;

--Visualizaçao das alterações realizadas nas tabelas equipa, Piloto e Participa
SELECT * FROM Equipa;
SELECT * FROM Piloto;
SELECT * FROM Participa;

--Remoçao de um piloto que nao tem participacoes
BEGIN
  formula_e.remove_piloto(8);
END;

--Tentativa de remoção de um piloto que já foi removido
--Lançamento da exption -20008
BEGIN
  formula_e.remove_piloto(8);
END;

--Remoçao de um piloto que nao tem participacoes
BEGIN
  formula_e.remove_piloto(3);
END;

--Remoçao de uma participacoes
BEGIN
  formula_e.remove_participacao(4,5);
END;

--Remoçao de uma participacao que nao existe
--Lançamento da exception 20011
BEGIN
  formula_e.remove_participacao(4,5);
END;

--Remocao de uma corrida bem como das participacoes de pilotos nessa corrida
BEGIN
  formula_e.remove_corrida(1);
END;

--Remocao de uma corrida que nao tem registada nehuma participacao
BEGIN
  formula_e.remove_corrida(10);
END;

--Tentativa de remocao de uma corrida que nao existe 
--Lançamento da exception 20006
BEGIN
  formula_e.remove_corrida(10);
END;

--Retorna a posiçao de um piloto, consoante os pontos
--Resultado esperado: 1
VARIABLE classf NUMBER;
BEGIN
  :classf:=formula_e.posicao(25);
   dbms_output.put_line(:classf);
END;

--Retorna a posiçao de um piloto, consoante os ponto
--Resultado esperado: NULL com impressao de uma mensagem
BEGIN
  :classf:=formula_e.posicao(0);
     DBMS_OUTPUT.PUT_LINE(:classf);
END;

--Obtencao de uma classificacao para uma pontuacao inexistente
--Lancamento da exception -20013 
BEGIN
  :classf:=formula_e.posicao(50);
     DBMS_OUTPUT.PUT_LINE(:classf);
END;
