CREATE OR REPLACE PACKAGE BODY formula_e IS

---------------------EXCEPTIONS-------------------------------------------------
-- -20001 - O número maximo de equipas eh 10.
-- -20002 - Já existe uma equipa com essa sigla.
-- -20003 - O número maximo de pilotos por equipa eh 2.
-- -20004 - o máximo de corridas é 10.
-- -20005 - Já existe uma corrida nessa cidade desse pais.
-- -20006 - A corrida não existe.
-- -20007 - Estes pontos já foram atribuídos nessa corrida.
-- -20008 - O piloto não existe.
-- -20009 - Já foram atribuídos pontos a esse piloto.
-- -20011 - Não existe esse registo.
-- -20012 - A Equipa não existe.
-- -20013 - Não existe essa pontuação.

-----------------------------Regista_Equipa-------------------------------------
-- Cria um novo registo de equipa.
PROCEDURE regista_equipa (
    sigla_in    IN equipa.sigla%TYPE,
    nome_in     IN equipa.nome%TYPE,
    pais_in     IN equipa.pais%TYPE,
    fundacao_in IN equipa.fundacao%TYPE)

  IS
  numeroEquipas NUMBER :=0;
  BEGIN
  
    SELECT COUNT (*) INTO numeroEquipas FROM Equipa;
    
    IF (numeroEquipas = 10) THEN 
      RAISE_APPLICATION_ERROR(-20001, 'O número máximo de equipas é 10.');
    ELSE
      INSERT INTO equipa(sigla, nome, pais, fundacao)
           VALUES (sigla_in, nome_in, pais_in, fundacao_in );
    END IF;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20002, 'Já existe uma equipa com essa sigla.');
    WHEN OTHERS THEN RAISE;
  END regista_equipa;

--------------------------FIM Regista_Equipa------------------------------------

---------------------------Regista_Piloto---------------------------------------
-- Função que registam um piloto
FUNCTION regista_piloto(
    nome_in IN Piloto.nome%TYPE, 
		pais_in IN Piloto.pais%TYPE, 
		nascimento_in IN Piloto.nascimento%TYPE, 
		genero_in IN Piloto.genero%TYPE, 
		equipa_in IN Piloto.equipa%TYPE)
    RETURN NUMBER
    
  IS
	numero_Elementos_Equipa NUMBER;
  idPiloto NUMBER;
  
  BEGIN
    --verificaçao do numero de elementos da equipa a inserir
    SELECT count(*) INTO numero_Elementos_Equipa FROM Piloto P, Equipa E
      WHERE  P.equipa = E.sigla AND E.sigla = equipa_in;

    IF(numero_Elementos_Equipa = 2) THEN
      RAISE_APPLICATION_ERROR(-20003, 
          'O numero maximo de pilotos por equipa eh 2.');
    ELSE
      idPiloto:=seq_id.NEXTVAL;
      INSERT INTO piloto (id, nome, pais, nascimento, genero, equipa) 
      VALUES (idPiloto, nome_in, pais_in, nascimento_in, genero_in, equipa_in);
    END IF;
    RETURN idPiloto; 

  EXCEPTION
    WHEN OTHERS THEN RAISE;
    
 END regista_piloto;

-----------------------------FIM Regista_Piloto---------------------------------

-----------------------------Regista_Corrida------------------------------------
-- Cria uma novo registo
PROCEDURE regista_corrida(
    ordem_in IN Corrida.ordem%TYPE, 
		cidade_in IN Corrida.cidade%TYPE, 
		pais_in IN Corrida.pais%TYPE, 
		voltas_in IN Corrida.voltas%TYPE)

  IS
    total_corridas NUMBER;

  BEGIN
      SELECT Count(*) INTO total_corridas FROM Corrida;
    IF ( total_corridas = 10 ) THEN 
      RAISE_APPLICATION_ERROR (-20004, 'o maximo de corridas eh 10.');
    ELSE
      INSERT INTO Corrida ( ordem, cidade, pais, voltas)
        VALUES (ordem_in,cidade_in, pais_in,voltas_in);
    END IF;

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20005, 
        'Já existe uma corrida nessa cidade desse pais');
  WHEN OTHERS THEN RAISE;

END regista_corrida;

----------------------------FIM Regista_Corrida---------------------------------

----------------------------Regista_Participaçao--------------------------------
--Regista uma participacao de uma piloto numa corrida
PROCEDURE regista_participacao(
      piloto_in IN Participa.piloto%TYPE, 
			corrida_in IN Participa.corrida%TYPE, 
			pontos_in IN Participa.pontos%TYPE)

  IS
    verifica_piloto  Piloto.id%TYPE;
    verifica_corrida NUMBER;
    verifica_pontos NUMBER;
   
  BEGIN
    --Verifica se existe esse piloto (EXCEPÇAO NO_DATA_FOUND)
    SELECT Piloto.id INTO verifica_piloto
      FROM Piloto
    WHERE Piloto.id = piloto_in;
  
    --Verifica se existe esta corrida (EXCEPÇAO NO_DATA_FOUND)
    SELECT COUNT(*) INTO verifica_corrida
      FROM Corrida
    WHERE Corrida.ordem = corrida_in;
  
    --Verifica se ja foram atribuidos estes pontos (>0) 
    SELECT COUNT(*) INTO verifica_pontos
      FROM Participa
    WHERE Participa.corrida = corrida_in AND Participa.pontos = pontos_in; 
     
    IF (verifica_corrida = 0) THEN
      RAISE_APPLICATION_ERROR(-20006, 'A corrida nao existe.');
    END IF;
    
    IF (verifica_pontos = 0 OR pontos_in = 0 ) THEN
      INSERT INTO Participa (piloto, corrida, pontos)
        VALUES (piloto_in,corrida_in, pontos_in);
    ELSE 
      RAISE_APPLICATION_ERROR(-20007, 
        'Estes pontos ja foram atribuidos nessa corrida.');
    END IF;	

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --caso o select nao tenha devolvido nada 
      RAISE_APPLICATION_ERROR(-20008, 'O piloto não existe.');

    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20009, 
        'Ja foram atribuidos pontos a esse piloto');
      
    WHEN OTHERS THEN RAISE;

END regista_participacao;

-----------------------------FIM Regista_Participacao---------------------------

----------------------------Remove_Equipa---------------------------------------
--Selecionar a equipa para ver se existe
--Selecionar os 2 pilotos dessa equipa
--Para cada um deles
	--remove_Participaçao(id,corrida)
	--remove_piloto(id)
  --remove_equipa;

PROCEDURE remove_equipa(
      nome_in IN Equipa.nome%TYPE)

  IS
    verifica_equipa Equipa.sigla%TYPE; 
    CURSOR cursor_pilotos 
      IS SELECT P.id FROM Piloto P, Equipa E 
        WHERE P.equipa = E.sigla AND E.nome = nome_in;   
    TYPE tab_local_pilotos_da_Equipa_in IS TABLE OF cursor_pilotos%ROWTYPE;
        tabPilotos tab_local_pilotos_da_Equipa_in;
        
  BEGIN
    SELECT E.sigla INTO verifica_equipa 
      FROM Equipa E 
    WHERE E.nome = nome_in;
    
    OPEN cursor_pilotos;
      FETCH cursor_pilotos BULK COLLECT INTO tabPilotos;
    CLOSE cursor_pilotos; 	
  
    IF (tabPilotos IS NOT EMPTY )THEN
      FOR posicao_atual IN tabPilotos.FIRST .. tabPilotos.LAST LOOP
          formula_e.remove_piloto(tabPilotos(posicao_atual).id);
      END LOOP;
    END IF;
    
    DELETE FROM Equipa WHERE sigla = verifica_equipa;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --caso o select nao tenha devolvido nada 
      RAISE_APPLICATION_ERROR(-20012, 'A Equipa não existe.');
    WHEN OTHERS THEN
      BEGIN
      -- Libertação de recursos (se aplicável).
        IF (cursor_pilotos%ISOPEN) THEN
          CLOSE cursor_pilotos;
        END IF;
      RAISE;
     END; 
  END remove_equipa;

---------------------------Fim Remove_Equipa------------------------------------


---------------------------Remove_Piloto----------------------------------------
--Remove um piloto e a suas participações nas corridas
PROCEDURE remove_piloto(
    id_in Piloto.id%Type)
  IS
    verificaPiloto Piloto.id%TYPE;
    CURSOR cursor_participacoes IS 
      SELECT piloto, corrida FROM PARTICIPA WHERE (piloto=id_in);
    TYPE tabela_local_part_piloto IS TABLE OF cursor_participacoes%ROWTYPE;
      tabParPiloto tabela_local_part_piloto;
  
  BEGIN
    SELECT piloto.id INTO verificaPiloto FROM Piloto WHERE piloto.id=id_in;
    
    OPEN cursor_participacoes;
      FETCH cursor_participacoes BULK COLLECT INTO tabParPiloto;
    CLOSE cursor_participacoes;
    
   IF(tabParPiloto IS NOT EMPTY)THEN
      FOR i IN tabParPiloto.first .. tabParPiloto.last loop
        formula_e.remove_participacao(
          tabParPiloto(i).piloto, tabParPiloto(i).corrida);  
      END LOOP;
    END IF;
  
    DELETE FROM Piloto WHERE (id_in=Piloto.id);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --caso o select nao tenha devolvido nada 
      RAISE_APPLICATION_ERROR(-20008, 'O Piloto não existe.');
    WHEN OTHERS THEN
      BEGIN
      -- Libertação de recursos (se aplicável).
      IF (cursor_participacoes%ISOPEN) THEN
        CLOSE cursor_participacoes;
      END IF;
      RAISE;
  END;
END remove_piloto;

---------------------------Fim_Remove_Piloto------------------------------------
  
---------------------------Remove_Paticipacao-----------------------------------  
--Remove a participacao de uma pilolo numa corrida  
PROCEDURE remove_participacao(
  piloto_in  IN Participa.piloto%TYPE,
  corrida_in IN Participa.corrida%TYPE)

  IS
    verifica_piloto_corrida NUMBER;
  BEGIN
    SELECT COUNT(*) INTO verifica_piloto_corrida 
      FROM PARTICIPA 
    WHERE participa.piloto = piloto_in AND participa.corrida = corrida_in;
  
    IF(verifica_piloto_corrida = 0) THEN
      RAISE_APPLICATION_ERROR(-20011, 'nao existe esse registo');
    ELSE 
      DELETE FROM PARTICIPA 
        WHERE participa.piloto=piloto_in And participa.corrida = corrida_in;
    END IF;

  EXCEPTION
    WHEN OTHERS THEN RAISE;
    
END remove_participacao;  
  
--------------------------Fim Remove_Paticipaca---------------------------------  
  
--------------------------Remove_Corrida----------------------------------------  
--remove uma corrida e as repectivas participaoes dos pilotos nessa corrida
PROCEDURE remove_corrida(
  ordem_in IN Corrida.ordem%TYPE)
  
  IS
    verificaCorrida corrida.ordem%TYPE;
      --selecionar da tabela participacao todos os pilotos que tem participacao 
      --na corrida com ordem_in
    CURSOR cursor_part_na_Corrida IS 
      SELECT piloto FROM PARTICIPA WHERE (ordem_in=PARTICIPA.corrida);
    TYPE tabela_part_piloto_corrida IS TABLE OF cursor_part_na_Corrida%ROWTYPE;
      tabParPilotoCorrida tabela_part_piloto_corrida;
      
  BEGIN
    SELECT ordem INTO verificaCorrida 
      FROM Corrida 
    WHERE corrida.ordem=ordem_in;
  
    OPEN cursor_part_na_Corrida;
      FETCH cursor_part_na_Corrida BULK COLLECT INTO tabParPilotoCorrida;
    CLOSE cursor_part_na_Corrida;
    
    --Se corrida tiver participacoes registadas apaga-as 
    IF(tabParPilotoCorrida IS NOT EMPTY) THEN
      FOR i IN tabParPilotoCorrida.FIRST .. tabParPilotoCorrida.last LOOP
        formula_e.remove_participacao(tabParPilotoCorrida(i).piloto, ordem_in);
      END LOOP; 
    END IF;      
    
    DELETE FROM Corrida WHERE (ordem_in=Corrida.ordem);
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --caso o select nao tenha devolvido nada 
      RAISE_APPLICATION_ERROR(-20006, 'a corrida nao existe');
    WHEN OTHERS THEN
      BEGIN
      -- Libertação de recursos (se aplicável).
      IF (cursor_part_na_Corrida%ISOPEN) THEN
        CLOSE cursor_part_na_Corrida;
      END IF;
      RAISE;
      END;
END remove_corrida;  

---------------------------Fim-Remove_Corrida-----------------------------------  
  
---------------------------Calculca_Posicao-------------------------------------
-- Função que devolve a posicao na corrida consoante o numero de pontos obtidos
FUNCTION posicao(
    pontos_in IN Participa.pontos%TYPE)
  RETURN NUMBER
    
  IS
    classificacao NUMBER;
  BEGIN
  
    CASE pontos_in
      WHEN 25 THEN classificacao := 1;
      WHEN 18 THEN classificacao := 2;
      WHEN 15 THEN classificacao := 3;
      WHEN 12 THEN classificacao := 4;
      WHEN 10 THEN classificacao := 5;
      WHEN 8 THEN classificacao := 6;
      WHEN 6 THEN classificacao := 7;
      WHEN 4 THEN classificacao := 8;
      WHEN 2 THEn classificacao := 9;
      WHEN 1 THEN classificacao := 10;
      WHEN 0 THEN classificacao := NULL;
        DBMS_OUTPUT.PUT_LINE('classificação na corrida superior a 10');
      ELSE
          RAISE_APPLICATION_ERROR (-20013, 'Não existe essa pontuação');
    END CASE;
    
    RETURN classificacao;
    
  EXCEPTION 
    WHEN OTHERS THEN RAISE;
END posicao;
---------------------------Fim Calculca_Posicao---------------------------------
  
END formula_e;
/


