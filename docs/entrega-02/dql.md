# Definição e Apresentação do DQL

## O que é DQL?

DQL ("Data Query Language") é uma linguagem usada para realizar consultas em um banco de dados. Com ela, podemos recuperar informações específicas de tabelas, realizar junções entre tabelas e aplicar filtros para obter dados relevantes.

No contexto deste projeto, o DQL foi usado para consultar informações sobre jogadores, habilidades, ambientes, itens e outras entidades do jogo. Abaixo, apresentamos as consultas SQL com descrições organizadas.

---

## Consultas Realizadas

=== "Módulo 2"

    ### Módulo 2

    #### 1. Listar os personagens criados no jogo

    ```sql
    SELECT id_jogador, nome 
    FROM Jogador;
    ```

    #### 2. Retornar os atributos de um jogador pelo id

    ```sql
    SELECT * 
    FROM Jogador 
    WHERE id_jogador = %s;
    ```

    #### 3. Retornar o ambiente que um jogador se encontra pelo id

    ```sql
    SELECT * 
    FROM Ambiente 
    WHERE fk_jogador_id = %s;
    ```

    #### 4. Retornar os atributos de um ambiente pelo id

    ```sql
    SELECT * 
    FROM Ambiente 
    WHERE id_ambiente = %s;
    ```

    #### 5. Listar as habilidades do jogador através do fk_habilidade_id

    ```sql
    SELECT * 
    FROM Habilidade 
    WHERE id_habilidade in (%s, %s, %s);
    ```

    #### 6. Retornar atributos da habilidade de mineração do jogador

    ```sql
    SELECT 
        fk_Habilidade_id, 
        nivel, 
        reducaoEnergiaMinera,
        minerioBonus,
        xpMin,
        xpMax 
    FROM habMineracao 
    WHERE fk_Habilidade_id = %s;
    ```

    #### 7. Retornar atributos da habilidade de combate do jogador

    ```sql
    SELECT 
        fk_Habilidade_id, 
        nivel, 
        vidaBonus,
        danoBonus,
        xpMin,
        xpMax 
    FROM habCombate 
    WHERE fk_Habilidade_id = %s;
    ```

    #### 8. Retornar atributos da habilidade de cultivo do jogador

    ```sql
    SELECT 
        fk_Habilidade_id, 
        nivel, 
        cultivoBonus,
        reducaoEnergiaCultiva,
        xpMin,
        xpMax 
    FROM habCultivo 
    WHERE fk_Habilidade_id = %s;
    ```

    #### 9. Retornar estoque de uma loja específica

    ```sql
    SELECT 
        l.nome,
        i.id_item,
        i.tipo_item
    FROM 
        loja l
    JOIN 
        estoque e ON l.fk_id_estoque = e.id_estoque
    JOIN 
        item i ON i.fk_estoque = e.id_estoque
    WHERE 
        l.nome = 'Armazém do Pierre' AND i.tipo_item = 'recurso';
    ```

    #### 10. Retornar os atributos de um inimigo pelo id

    ```sql
    SELECT *
    FROM inimigo
    WHERE nome = %s;
    ```

    #### 11. Retornar os atributos de um animal pelo id

    ```sql
    SELECT *
    FROM Animal
    WHERE id_animal = %s;
    ```

    #### 12. Listar os itens de um inventário específico

    ```sql
    SELECT i.id_item, i.tipo_item, i.fk_inventario_id
    FROM item i
    JOIN inventario inv ON i.fk_inventario_id = inv.id_inventario
    WHERE inv.fk_id_jogador = 0;
    ```

    #### 13. Selecionar o nome do jogador e os níveis de habilidades de mineração, combate e cultivo

    ```sql
    SELECT 
        j.nome AS jogador_nome,
        hm.nivel AS nivel_mineracao,
        hc.nivel AS nivel_combate,
        hcu.nivel AS nivel_cultivo
    FROM 
        Jogador j
    JOIN 
        habMineracao hm ON j.fk_habMineracao_fk_Habilidade_id = hm.fk_Habilidade_id
    JOIN 
        habCombate hc ON j.fk_habCombate_fk_Habilidade_id = hc.fk_Habilidade_id
    JOIN 
        habCultivo hcu ON j.fk_habCultivo_fk_Habilidade_id = hcu.fk_Habilidade_id;
    ```

=== "Módulo 3"
    ### Módulo 3

    #### 1. Retornar os atributos de um jogador pelo ID

    ```sql 
    SELECT * 
    FROM Jogador 
    WHERE id_jogador = %s;
    ``` 

    #### 2. Retornar as habilidades pelo ID
    
    ```sql 
    SELECT * 
    FROM Habilidade 
    WHERE id_habilidade in (%s,%s,%s);
    ``` 


    #### 3. Retornar atributos da habilidade de mineração
    
    ```sql 
    SELECT fk_Habilidade_id, nivel, reducaoEnergiaMinera,minerioBonus, xpMin, xpMax 
    FROM habMineracao 
    WHERE fk_Habilidade_id = %s;
    ``` 

    #### 4. Retornar atributos da habilidade de combate
    
    ```sql 
    SELECT fk_Habilidade_id,nivel, vidaBonus, danoBonus, xpMin, xpMax 
    FROM habCombate 
    WHERE fk_Habilidade_id = %s;
    ``` 

    #### 5. Retornar atributos da habilidade de cultivo
    
    ```sql 
    SELECT fk_Habilidade_id,nivel, cultivoBonus,reducaoEnergiaCultiva, xpMin, xpMax 
    FROM habCultivo 
    WHERE fk_Habilidade_id = %s;
    ``` 

    #### 6. Retornar itens do inventário de um jogador
    
    ```sql 
    SELECT nome_item, tipo_item, quantidade, preco_item 
    FROM vw_inventario_jogador 
    WHERE id_jogador = %s;
    ``` 

    #### 7. Retornar ambientes de um jogador
    
    ```sql 
    SELECT * 
    FROM Ambiente 
    WHERE fk_jogador_id = %s;
    ``` 

    #### 8. Retornar ambiente pelo ID
    
    ```sql 
    SELECT * 
    FROM Ambiente 
    WHERE id_ambiente = %s;
    ``` 

    #### 9. Contar instâncias de inimigos de um jogador
    
    ```sql 
    SELECT COUNT(*) 
    FROM instancia_de_inimigo 
    WHERE fk_jogador_id = %s;
    ``` 

    #### 10. Retornar a primeira instância de item de um jogador
    
    ```sql 
    SELECT id_instancia_de_item 
    FROM instancia_de_item 
    WHERE fk_id_jogador = %s AND fk_id_item = %s 
    ORDER BY id_instancia_de_item 
    ASC LIMIT 1;
    ``` 

    #### 11. Retornar consumíveis de um jogador com contagem
    
    ```sql 
    SELECT c.fk_id_item, c.nome, c.descricao, c.efeito_vida, c.preco, ii.fk_id_jogador, COUNT(*) 
    FROM Consumivel c 
    JOIN Instancia_de_item ii ON c.fk_id_item = ii.fk_id_item 
    WHERE ii.fk_id_jogador = %s 
    GROUP BY c.fk_id_item, c.nome, c.descricao, c.efeito_vida, c.preco, ii.fk_id_jogador;
    ``` 

    #### 12. Retornar instâncias de inimigos de um jogador
    
    ```sql 
    SELECT * 
    FROM Instancia_de_Inimigo 
    WHERE fk_inimigo_id = %s AND fk_jogador_id = %s 
    ORDER BY id_instancia_de_inimigo;
    ``` 

    #### 13. Retornar habilidade de combate de um jogador
    
    ```sql 
    SELECT * 
    FROM habCombate 
    WHERE fk_Habilidade_id = ( SELECT fk_habCombate_fk_Habilidade_id 
    FROM jogador 
    WHERE id_jogador = %s );
    ``` 

    #### 14. Retornar atributos da habilidade de combate pelo ID
    
    ```sql 
    SELECT * 
    FROM habCombate 
    WHERE fk_Habilidade_id = %s;
    ``` 

    #### 15. Retornar armas de um jogador com contagem
    
    ```sql 
    SELECT a.fk_id_item, a.nome, a.descricao, a.dano_arma, a.preco, ii.fk_id_jogador, COUNT(*) 
    FROM Arma a 
    JOIN Instancia_de_item ii ON a.fk_id_item = ii.fk_id_item 
    WHERE ii.fk_id_jogador = %s 
    GROUP BY a.fk_id_item, a.nome, a.descricao, a.dano_arma, a.preco, ii.fk_id_jogador;
    ``` 

    #### 16. Retornar inimigos em um ambiente com contagem
    
    ```sql 
    SELECT i.*, COUNT(*) AS quantidade 
    FROM Instancia_de_Inimigo ii 
    JOIN inimigo i ON ii.fk_inimigo_id = i.id_inimigo 
    WHERE ii.fk_id_ambiente = %s AND ii.fk_jogador_id = %s 
    GROUP BY i.id_inimigo, i.nome, i.vidamax, i.dano 
    ORDER BY quantidade 
    DESC;
    ``` 

    #### 17. Contar instâncias de inimigos em um ambiente
    
    ```sql 
    SELECT COUNT(*) 
    FROM instancia_de_inimigo 
    WHERE fk_id_ambiente = %s AND fk_jogador_id = %s;
    ``` 

    #### 18. Retornar consumíveis de uma caverna
    
    ```sql 
    SELECT Consumivel.* 
    FROM Caverna 
    Join Consumivel ON fk_id_item_recompensa = fk_id_item 
    WHERE Caverna.fk_id_ambiente = %s;
    ``` 

    #### 19. Retornar capacidade máxima de animais em um celeiro
    
    ```sql 
    SELECT qtd_max_animais 
    FROM Celeiro 
    WHERE fk_id_ambiente = %s;
    ``` 

    #### 20. Retornar instâncias de animais de um jogador
    
    ```sql 
    SELECT ia.id_instancia_de_animal, ia.nome_animal, a.diasTotalDropar, ia.prontoDropa 
    FROM Instancia_de_Animal ia 
    JOIN Animal a ON ia.fk_Animal_id = a.id_animal 
    WHERE ia.fk_Jogador_id = %s;
    ``` 

    #### 21. Retornar todos os animais
    
    ```sql 
    SELECT id_animal, tipo_animal, preco 
    FROM Animal;
    ``` 

    #### 22. Verificar se um ambiente é um celeiro
    
    ```sql 
    SELECT fk_id_ambiente 
    FROM Celeiro 
    WHERE fk_id_ambiente = %s;
    ``` 

    #### 23. Retornar instâncias de animais com preço
    
    ```sql 
    SELECT ins.id_instancia_de_animal, ins.nome_animal, hpp.preco 
    FROM Instancia_de_Animal ins 
    INNER JOIN Animal hpp ON ins.fk_animal_id = hpp.id_animal 
    WHERE fk_jogador_id = %s;
    ``` 

    #### 24. Retornar instâncias de animais prontos para drop
    
    ```sql 
    SELECT ia.id_instancia_de_animal, ia.nome_animal, ia.prontoDropa, a.diasTotalDropar, ia.fk_animal_id 
    FROM Instancia_de_Animal ia 
    JOIN Animal a ON ia.fk_animal_id = a.id_animal 
    WHERE ia.fk_Jogador_id = %s AND a.diasTotalDropar > 0;
    ``` 

    #### 25. Retornar item drop de um animal
    
    ```sql 
    SELECT itemDrop 
    FROM Animal 
    WHERE id_animal = %s;
    ``` 

    #### 26. Retornar capacidade máxima de animais em um celeiro
    
    ```sql 
    SELECT fk_id_ambiente, qtd_max_animais 
    FROM Celeiro 
    WHERE fk_id_ambiente = %s;
    ``` 

    #### 27. Contar instâncias de animais de um jogador
    
    ```sql 
    SELECT COUNT(*) 
    FROM Instancia_de_Animal 
    WHERE fk_Jogador_id = %s;
    ``` 

    #### 28. Retornar moedas de um jogador
    
    ```sql 
    SELECT moedas 
    FROM Jogador 
    WHERE id_jogador = %s;
    ``` 

    #### 29. Retornar ID do inventário de um jogador
    
    ```sql 
    SELECT id_inventario 
    FROM inventario 
    WHERE fk_id_jogador = %s;
    ``` 

    #### 30. Retornar nome de um mineral pelo ID do item
    
    ```sql 
    SELECT nome 
    FROM Mineral 
    WHERE fk_id_item = %s;
    ``` 

    #### 31. Retornar itens de uma loja
    
    ```sql 
    SELECT fk_id_item 
    FROM vw_catalogo_loja 
    WHERE fk_id_loja = %s;
    ``` 

    #### 32. Retornar itens distintos do inventário de um jogador
    
    ```sql 
    SELECT DISTINCT fk_id_item, nome_item, tipo_item,quantidade, preco_item 
    FROM vw_inventario_jogador 
    WHERE id_jogador = %s;
    ``` 

    #### 33. Retornar catálogo de uma loja
    
    ```sql 
    SELECT fk_id_item, nome_item, tipo_item, preco_item 
    FROM vw_catalogo_loja 
    WHERE fk_id_loja = %s;
    ``` 

    #### 34. Retornar preço de um item na loja
    
    ```sql 
    SELECT preco_item 
    FROM vw_catalogo_loja 
    WHERE fk_id_item = %s;
    ``` 

    #### 35. Contar instâncias de plantas de um jogador
    
    ```sql 
    SELECT COUNT(*) 
    FROM Instancia_de_Planta 
    WHERE fk_id_jogador = %s;
    ``` 

    #### 36. Retornar capacidade máxima de plantas em uma plantação
    
    ```sql 
    SELECT qtd_plantas_max 
    FROM Plantacao 
    WHERE fk_id_ambiente = %s;
    ``` 

    #### 37. Retornar todas as plantas
    
    ```sql 
    SELECT id_planta, nome, preco 
    FROM Planta;
    ``` 

    #### 38. Retornar instâncias de plantas de um jogador
    
    ```sql 
    SELECT id_instancia_de_planta, nome, prontoColher, diaAtual 
    FROM Instancia_de_Planta 
    WHERE fk_id_jogador = %s;
    ``` 

    #### 39. Retornar instâncias de plantas com preço
    
    ```sql 
    SELECT ins.id_instancia_de_planta, ins.nome, pp.preco 
    FROM Instancia_de_Planta ins 
    INNER JOIN Planta pp ON ins.fk_id_planta = pp.id_planta 
    WHERE ins.fk_id_jogador = %s;
    ``` 

    #### 40. Retornar instâncias de plantas prontas para colher
    
    ```sql 
    SELECT ins.id_instancia_de_planta, ins.nome, ins.prontoColher, pp.id_planta, pp.itemDrop 
    FROM Instancia_de_Planta ins 
    INNER JOIN Planta pp ON ins.fk_id_planta = pp.id_planta 
    WHERE ins.fk_id_jogador = %s;
    ``` 

    #### 41. Retornar dias de instâncias de animais de um jogador
    
    ```sql 
    SELECT i.id_instancia_de_animal, i.diaAtual, a.diasTotalDropar 
    FROM Instancia_de_Animal i 
    JOIN Animal a ON i.fk_Animal_id = a.id_animal 
    WHERE i.fk_Jogador_id = NEW.id_jogador;
    ```  

| Data | Versão | Autor | Alterações |
| :--: | :----: | ----- | ---------- |
| 13/01/2024 | `1.0` | [Marcos Vieira Marinho](https://github.com/devMarcosVM) | Versão inicial do documento |
| 08/02/2024 | `1.1` | [Gabriel Fernando de Jesus Silva](https://github.com/MMcLovin) | Adiciona *queries* usadas no módulo 3 |
