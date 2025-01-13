# Definição e Apresentação do DQL

## O que é DQL?

DQL ("Data Query Language") é uma linguagem usada para realizar consultas em um banco de dados. Com ela, podemos recuperar informações específicas de tabelas, realizar junções entre tabelas e aplicar filtros para obter dados relevantes.

No contexto deste projeto, o DQL foi usado para consultar informações sobre jogadores, habilidades, ambientes, itens e outras entidades do jogo. Abaixo, apresentamos as consultas SQL com descrições organizadas.

---

## Consultas Realizadas

### 1. Listar os personagens criados no jogo

```sql
SELECT id_jogador, nome 
FROM Jogador;
```

### 2. Retornar os atributos de um jogador pelo id

```sql
SELECT * 
FROM Jogador 
WHERE id_jogador = %s;
```

### 3. Retornar o ambiente que um jogador se encontra pelo id

```sql
SELECT * 
FROM Ambiente 
WHERE fk_jogador_id = %s;
```

### 4. Retornar os atributos de um ambiente pelo id

```sql
SELECT * 
FROM Ambiente 
WHERE id_ambiente = %s;
```

### 5. Listar as habilidades do jogador através do fk_habilidade_id

```sql
SELECT * 
FROM Habilidade 
WHERE id_habilidade in (%s, %s, %s);
```

### 6. Retornar atributos da habilidade de mineração do jogador

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

### 7. Retornar atributos da habilidade de combate do jogador

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

### 8. Retornar atributos da habilidade de cultivo do jogador

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

### 9. Retornar estoque de uma loja específica

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

### 10. Retornar os atributos de um inimigo pelo id

```sql
SELECT *
FROM inimigo
WHERE nome = %s;
```

### 11. Retornar os atributos de um animal pelo id

```sql
SELECT *
FROM Animal
WHERE id_animal = %s;
```

### 12. Listar os itens de um inventário específico

```sql
SELECT i.id_item, i.tipo_item, i.fk_inventario_id
FROM item i
JOIN inventario inv ON i.fk_inventario_id = inv.id_inventario
WHERE inv.fk_id_jogador = 0;
```

### 13. Selecionar o nome do jogador e os níveis de habilidades de mineração, combate e cultivo

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

| Data | Versão | Autor | Alterações |
| :--: | :----: | ----- | ---------- |
| 13/01/2024 | `1.0` | [Marcos Vieira Marinho](https://github.com/devMarcosVM) | Versão inicial do documento |
