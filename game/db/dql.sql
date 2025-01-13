--Listar os personagens criados no jogo
SELECT id_jogador, nome 
FROM Jogador

--Retornar os atributos de um jogador pelo id(%s)
SELECT * 
FROM Jogador 
WHERE id_jogador = %s

--Retornar o ambiente que um jogador se encontra pelo id(%s)
SELECT * 
FROM Ambiente 
WHERE fk_jogador_id = %s 

--Retornar os atributos de um ambiente pelo id(%s)
SELECT * 
FROM Ambiente 
WHERE id_ambiente = %s