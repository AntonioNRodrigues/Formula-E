1. Anos de fundaçao e nomes das equipas do Japao com pelo menos um piloto nascido após 1990.
Nota 1: pretende-se uma interrogacao com apenas um SELECT, isto é, sem sub-interrogaçoes.
Nota 2: o resultado deve vir ordenado pelo ano de fundaçao de forma descendente e pelo nome
da equipa de forma ascendente.

SELECT DISTINCT E.fundacao, E.nome
    FROM equipa E, piloto P
  WHERE E.sigla = P.equipa
    AND E.pais = 'Japao'
    AND P.nascimento > 1990
ORDER BY E.fundacao DESC, E.nome ASC;



2. IDs e nomes das mulheres piloto que nasceram após 1990, ou entao que participaram em pelo
menos uma corrida e nasceram antes de 1980. Nota: pode usar construtores de conjuntos.

SELECT DISTINCT P.id, P.nome
    FROM piloto P, Participa Part
  WHERE P.genero = 'F'
    AND ((P.nascimento > 1990) OR (P.nascimento < 1980 AND Part.piloto = P.id));


3. Nomes dos pilotos e suas equipas, nascidos depois de 1990, e que pontuaram nas duas primeiras
corridas da temporada. 
Nota 1: pretende-se uma interrogaçao sem sub-interrogacoes. 
Nota 2: o resultado deve vir ordenado pelo nome do piloto e pelo nome da equipa.

SELECT DISTINCT p.id ,P.nome, E.nome
    FROM Piloto P, Participa Part, Participa Part2, Equipa E
  WHERE P.nascimento > 1990
    AND P.id = Part.piloto
   -- AND P.id = Part2.piloto FALTAVA ISTO!!!!!!!!!!!!!!!!!!!!!
    AND P.equipa = E.sigla
    AND Part.corrida = 1
    AND Part2.corrida = 2
    AND Part.pontos > 0
    AND Part2.pontos > 0
    ORDER BY P.nome ASC, E.nome ASC;


4. Nomes dos pilotos e suas equipas que nunca participaram em corridas no país da equipa.

SELECT P.nome, E.nome
    FROM Piloto P, Equipa E
  WHERE P.id NOT IN (SELECT P.id
                        FROM Piloto P, Participa Part, Equipa E, Corrida C
                      WHERE P.equipa = E.sigla
                      AND P.id = Part.piloto
                      AND Part.corrida = C.ordem
                      AND C.pais = E.pais)
    AND P.equipa = E.sigla;


5. Nomes das equipas cujos pilotos (todos) participaram em pelo menos uma corrida com mais de 20 voltas ao circuito.

SELECT E.NOME
    FROM Participa PART, Piloto P, Equipa E, Corrida COR
  WHERE P.equipa = E.sigla
    AND COR.ordem = PART.corrida
    AND PART.piloto = P.id
    AND COR.voltas > 20
  GROUP BY E.nome
  HAVING (COUNT(PART.piloto)>=2);


6. Soma dos pontos obtidos por cada equipa em cada corrida. 
Nota: o resultado deve vir ordenado pelo nome da equipa e pelo número de ordem da corrida, ambos de forma ascendente.

SELECT E.nome, PART.corrida, SUM(Part.pontos) AS Pontos
    FROM Equipa E, Piloto P, Participa PART, Corrida COR
  WHERE E.sigla = P.equipa  
    AND PART.piloto = P.ID
    AND COR.ordem = PART.corrida
    GROUP BY E.nome, PART.corrida
    ORDER BY E.nome ASC, COR.ordem ASC;


7. Nomes das equipas com mais pontos por corrida.

SELECT B.EQUIPA, A.CORRIDA, A.Max_Pontos
FROM(SELECT CORRIDA, MAX(PONTOS) As Max_Pontos
    FROM (SELECT E.NOME AS EQUIPA, PART.CORRIDA, SUM(PART.PONTOS) AS PONTOS
          FROM EQUIPA E, PILOTO P, PARTICIPA PART, CORRIDA COR
          WHERE E.SIGLA    = P.EQUIPA
          AND PART.PILOTO = P.ID AND COR.ORDEM   =PART.CORRIDA
          GROUP BY E.NOME, PART.CORRIDA
          ORDER BY E.NOME ASC, COR.ORDEM ASC)
          GROUP BY CORRIDA
          ORDER BY CORRIDA) A, (SELECT E.NOME AS EQUIPA, PART.CORRIDA, SUM(PART.PONTOS) AS PONTOS
                                FROM EQUIPA E, PILOTO P, PARTICIPA PART, CORRIDA COR
                                WHERE E.SIGLA    = P.EQUIPA
                                AND PART.PILOTO = P.ID AND COR.ORDEM   =PART.CORRIDA
                                GROUP BY E.NOME, PART.CORRIDA
                                ORDER BY E.NOME ASC, COR.ORDEM ASC) B
WHERE B.corrida = A.corrida AND B.Pontos = A.Max_Pontos; 


8. Média dos pontos obtidos por pilotos que nasceram depois de 1990 e que participaram em todas as corridas do seu país.

SELECT P.NOME, AVG(Part.PONTOS) AS MEDIA_PONTOS
    FROM Piloto P, Participa Part
  WHERE P.nascimento > 1990 AND Part.piloto = P.id
  AND NOT EXISTS (SELECT C.ordem
                      FROM Corrida C, Participa Part2
                    WHERE Part2.corrida = C.ordem
                    AND C.pais = P.pais
                    AND Part2.corrida NOT IN (SELECT Part3.corrida
                                                  FROM Participa Part3
                                                WHERE Part3.piloto = P.id))
  GROUP BY P.NOME;


--VIEWS

--TABELA-CLASSIFICATIVA-PONTOS
CREATE OR REPLACE VIEW tabela_classificativa_pilotos AS
  SELECT P.nome, NVL(SUM(PART.PONTOS), 0) AS PONTOS
      FROM PILOTO P 
      LEFT OUTER JOIN PARTICIPA PART ON P.id = PART.piloto
  GROUP BY P.nome, P.id;

--TABELA-CLASSIFICATIVA-EQUIPAS
CREATE OR REPLACE VIEW tabela_classificativa_equipas AS
  SELECT E.nome, NVL(SUM(PART.PONTOS), 0) AS PONTOS
      FROM PILOTO P 
      LEFT OUTER JOIN PARTICIPA PART ON PART.piloto = P.id, EQUIPA E
    WHERE E.sigla = P.equipa
    GROUP BY E.nome;