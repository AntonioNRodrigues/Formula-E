--- NUMERO 4
SELECT P.nome, E.nome
FROM Piloto P, Equipa E
WHERE P.equipa  = E.sigla
AND E.PAIS NOT IN (SELECT E.PAIS
  FROM Participa Part, Corrida C
  WHERE P.id       = Part.piloto
  AND Part.corrida = C.ordem
  AND C.pais       = E.pais) ;
  
  --- NUMERO 4 OUTRA FORMA
SELECT P.nome, E.nome
FROM Piloto P, Equipa E
WHERE P.equipa = E.sigla 
          AND P.id NOT IN (SELECT P.id
                    FROM Participa Part, Corrida C
                    WHERE P.id       = Part.piloto
                    AND Part.corrida = C.ordem
                  AND C.pais       = E.pais
  );

--6
SELECT E.nome, SUM(Part.pontos) AS Pontos
    FROM Equipa E, Piloto P, Participa PART
  WHERE E.sigla = P.equipa  
    AND PART.piloto = P.ID
    GROUP BY E.nome, PART.corrida
    ORDER BY E.nome ASC, PART.corrida ASC;
    
 
 --PILOTO QUE NAO TEM PARTICIPAÇÕES    
SELECT DISTINCT P.NOME
FROM PILOTO P
WHERE NOT EXISTS
  (SELECT PART2.PILOTO FROM PARTICIPA PART2 WHERE PART2.PILOTO = P.ID
  );
  
--EQUIPAS QQUE NAO TEM PARTICIPACOES
SELECT  DISTINCT E.NOME
FROM PILOTO P, EQUIPA E
WHERE P.EQUIPA = E.SIGLA AND 
NOT EXISTS (SELECT PAR.PILOTO FROM PARTICIPA PAR WHERE PAR.PILOTO = P.ID);

--EQUIPAS QQUE TEM PARTICIPACOES
SELECT  DISTINCT E.NOME
FROM PILOTO P, EQUIPA E
WHERE P.EQUIPA = E.SIGLA AND 
EXISTS (SELECT PAR.PILOTO FROM PARTICIPA PAR WHERE PAR.PILOTO = P.ID);

--PONTUACAO POR CORRIDA DE CADA PILOTO
SELECT DISTINCT P.NOME, PART.PONTOS, PART.CORRIDA
FROM PILOTO P, PARTICIPA PART
WHERE P.ID = PART.PILOTO
ORDER BY PART.CORRIDA ASC; 

--PILOTOS QUE TEM PELO MENOS UM PARTICIPACAO POR CORRIDA
SELECT P.NOME 
FROM PILOTO P
WHERE EXISTS (SELECT PART.PILOTO FROM PARTICIPA PART WHERE PART.PILOTO = P.ID); 

--PILOTOS QUE TEM PARTICIPACOES
SELECT P.NOME 
FROM PILOTO P
WHERE EXISTS (SELECT PART.PILOTO FROM PARTICIPA PART WHERE PART.PILOTO = P.ID); 



--PILOTOS QUE TEM UMA PARTICIPACAO EM TODAS AS CORRIDAS
SELECT P.NOME
FROM PILOTO P
WHERE (SELECT COUNT(*) FROM PARTICIPA PART WHERE PART.PILOTO = P.ID)=10; 

--EQUIPA QUE TEM UM PILOTO QUE PARTICIPOU EM TODAS AS CORRIDAS
SELECT E.NOME
FROM PILOTO P, EQUIPA E
WHERE E.SIGLA=P.EQUIPA AND (SELECT COUNT(*) FROM PARTICIPA PART WHERE PART.PILOTO = P.ID)=10; 


