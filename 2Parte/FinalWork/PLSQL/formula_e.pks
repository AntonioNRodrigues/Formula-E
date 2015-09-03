CREATE OR REPLACE PACKAGE formula_e
  IS
    PROCEDURE regista_equipa(
        sigla_in    IN Equipa.sigla%TYPE,
        nome_in     IN Equipa.nome%TYPE ,
        pais_in     IN Equipa.pais%TYPE,
        fundacao_in IN Equipa.fundacao%TYPE );
        
    FUNCTION regista_piloto(
        nome_in       IN Piloto.nome%TYPE,
        pais_in       IN Piloto.pais%TYPE,
        nascimento_in IN Piloto.nascimento%TYPE,
        genero_in     IN Piloto.genero%TYPE,
        equipa_in     IN Piloto.equipa%TYPE)
      RETURN NUMBER;
      
    PROCEDURE regista_corrida(
        ordem_in  IN Corrida.ordem%TYPE,
        cidade_in IN Corrida.cidade%TYPE,
        pais_in   IN Corrida.pais%TYPE,
        voltas_in IN Corrida.voltas%TYPE);
   
    PROCEDURE regista_participacao(
        piloto_in  IN Participa.piloto%TYPE,
        corrida_in IN Participa.corrida%TYPE,
        pontos_in  IN Participa.pontos%TYPE);
        
    PROCEDURE remove_equipa(
        nome_in IN Equipa.nome%TYPE);
  
    PROCEDURE remove_piloto(
        id_in IN Piloto.id%TYPE);
   
    PROCEDURE remove_corrida(
        ordem_in IN Corrida.ordem%TYPE);
        
    PROCEDURE remove_participacao(
        piloto_in  IN Participa.piloto%TYPE,
        corrida_in IN Participa.corrida%TYPE);
        
    FUNCTION posicao(
        pontos_in  IN Participa.pontos%TYPE)
      RETURN NUMBER;
      
END formula_e;
/