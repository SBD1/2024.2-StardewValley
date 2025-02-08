from ..mineracao_precisao import barra_de_precisao
from ..Barra_status import barra_status_vida
from setup.database import get_connection
import os
import random
import src.avancar_tempo as avancar_tempo
import time

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

minerios = {
    101: {"nome": "Pedra", "descricao": "Um material de construção básico."},
    102: {"nome": "Bronze", "descricao": "Um metal utilizado em ferramentas."},
    103: {"nome": "Ferro", "descricao": "Metal resistente e versátil."},
    104: {"nome": "Ouro", "descricao": "Metal precioso e valioso."},
    105: {"nome": "Fragmento Prismatico", "descricao": "Um raro cristal multicolorido."},
    106: {"nome": "Água Marinha", "descricao": "Uma gema azul-esverdeada brilhante."},
    107: {"nome": "Carvão", "descricao": "Material utilizado para fundição."},
    108: {"nome": "Rubi", "descricao": "Uma gema vermelha reluzente."},
    109: {"nome": "Jade", "descricao": "Uma pedra preciosa verde."},
    110: {"nome": "Ametista", "descricao": "Uma gema roxa brilhante."},
    111: {"nome": "Esmeralda", "descricao": "Uma gema verde de rara beleza."},
    113: {"nome": "Diamante", "descricao": "Uma gema preciosa e brilhante."},
}

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def ataque_inimigo(ambiente, tipo_inimigo):
    andar = ambiente[0] - 15
    dano = tipo_inimigo[4]
    resultado = random.randint(0, 100)
    peso = 0.05 + andar # precisao dos inimigos aumenta conforme o andar
    
    if (25 / peso) <= resultado <= (75 * peso):
        return dano
    return  0

def contar_consumiveis(jogador_dict):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute(""" 
            SELECT c.fk_id_item, c.nome, c.descricao, c.efeito_vida, c.preco, ii.fk_id_jogador, COUNT(*)
            FROM Consumivel c
            JOIN Instancia_de_item ii ON c.fk_id_item = ii.fk_id_item
            WHERE ii.fk_id_jogador = %s
            GROUP BY c.fk_id_item, c.nome, c.descricao, c.efeito_vida, c.preco, ii.fk_id_jogador;""",
        (jogador_dict['id_jogador'],))
        pocoes = cursor.fetchall()

        quantidade_pocoes = sum([pocao[6] for pocao in pocoes])

        return quantidade_pocoes
    except Exception as error:
        print(f"\nOcorreu um erro ao contar os consumíveis: {error}")
        input("Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def exibir_status_combate(jogador_dict, inimigo_dict):
    clear_terminal()

    # Garantindo que não pegue um valor negativo de vida
    vida_jogador = max(jogador_dict['vidaAtual'], 0)
    vida_inimigo = max(inimigo_dict['vida'], 0)

    quantidade_pocoes = contar_consumiveis(jogador_dict)

    print("⚔️  " * 7, " COMBATE ", "⚔️  " * 7)
    print(f"\nStatus do jogador {jogador_dict['nome']}")
    barra_status_vida(vida_jogador, jogador_dict['vidaMax'])
    print(f"\nDano de ataque: {jogador_dict['dano_ataque']} ")  
    print(f"Arma equipada: {jogador_dict['arma'][1]  if jogador_dict['arma'] is not None else "Nenhuma" } ")
    print(f"Dano da arma: {jogador_dict['arma'][3]} ") if jogador_dict['arma'] is not None else None
    print(f"Itens consumíveis: {quantidade_pocoes} ")
    print(f"\nStatus do(a) {inimigo_dict['tipo'][1]}")
    barra_status_vida(vida_inimigo, inimigo_dict['tipo'][3])  

def get_instancia_inimigo(id_inimigo, id_jogador):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("""SELECT * FROM Instancia_de_Inimigo 
                    WHERE fk_inimigo_id = %s AND fk_jogador_id = %s  
                    ORDER BY id_instancia_de_inimigo""", (id_inimigo, id_jogador,))
        instancia_inimigo = cursor.fetchone()

        return instancia_inimigo
    except Exception as error:
        print(f"Ocorreu um erro ao buscar a instância do inimigo: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def verificar_nivel_habilidade(jogador_dict, habilidade_antiga):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("""SELECT * FROM habCombate WHERE fk_Habilidade_id = (
                            SELECT fk_habCombate_fk_Habilidade_id FROM jogador WHERE    id_jogador = %s
                       )""", (jogador_dict["id_jogador"],))
        habilidade_nova = cursor.fetchone()

        if habilidade_nova[1] > habilidade_antiga[1]:
            print(f"\nParabéns! Sua habilidade de combate subiu para o nível {habilidade_nova[1]}!")
            print(f"""Você ganhou +{habilidade_nova[4]} de vida e +{habilidade_nova[5]} de dano!""")

    except Exception as error:
        print(f"\nOcorreu um erro ao verificar o nível da habilidade: {error}")
        input("\Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def commit_vidaAtual(jogador_dict, inimigo_dict=None):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        
        if jogador_dict['vidaAtual'] > jogador_dict['vidaMax']:
            jogador_dict['vidaAtual'] = jogador_dict['vidaMax']

        cursor.execute("UPDATE Jogador SET vidaAtual = %s WHERE id_jogador = %s", (jogador_dict['vidaAtual'], jogador_dict['id_jogador']))
        connection.commit()

        if inimigo_dict is not None:
            cursor.execute("UPDATE Instancia_de_Inimigo SET vidaAtual = %s WHERE id_instancia_de_inimigo = %s", (inimigo_dict['vida'], inimigo_dict['instancia'][0]))
            connection.commit()

        return 
    except Exception as error:
        print(f"\nOcorreu um erro ao atualizar a vida atual: {error}")
        input("Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def resultado_combate(inimigo_dict, jogador_dict):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        exibir_status_combate(jogador_dict, inimigo_dict)

        # vamos precisar da habilidade antiga para comparar com a nova
        cursor.execute("SELECT * FROM habCombate WHERE fk_Habilidade_id = %s", (jogador_dict['fk_habCombate_fk_Habilidade_id'],))
        habCombate = cursor.fetchone()

        commit_vidaAtual(jogador_dict, inimigo_dict)
        
        # neste ponto, uma trigger no banco de dados é acionada para:
        # remover inimigos mortos
        # atualizar o xp de combate do jogador e atualizar stats relacionados a habCombate

        if jogador_dict['vidaAtual'] <= 0:
            resultado = "derrota"
            print("\nVocê foi derrotado 💀")
        elif inimigo_dict['vida'] <= 0:
            resultado = "vitoria"
            print(f"\nVocê derrotou o(a) {inimigo_dict['tipo'][1]}!")
            print(f"Você ganhou +{inimigo_dict['tipo'][5]} de xp de combate.")

            verificar_nivel_habilidade(jogador_dict, habCombate)

        input("\nPressione enter para continuar...")
        return resultado, jogador_dict
    except Exception as error:
        print(f"Ocorreu um erro ao exibir o resultado do combate: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def usar_consumivel(jogador_dict):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute(""" 
            SELECT c.fk_id_item, c.nome, c.descricao, c.efeito_vida, c.preco, ii.fk_id_jogador, COUNT(*)
            FROM Consumivel c
            JOIN Instancia_de_item ii ON c.fk_id_item = ii.fk_id_item
            WHERE ii.fk_id_jogador = %s
            GROUP BY c.fk_id_item, c.nome, c.descricao, c.efeito_vida, c.preco, ii.fk_id_jogador;""",
        (jogador_dict['id_jogador'],))
        pocoes_inventario = cursor.fetchall()

        pocoes_id = []
        quantidade_pocoes = 0
        for pocao in pocoes_inventario:
            pocoes_id.append(pocao[0])
            quantidade_pocoes += pocao[6]

        while quantidade_pocoes > 0:
            # listando poções no inventário do jogador
            #(fk_id_item, nome, descricao, efeito_vida, preco, fk_id_jogador, quantidade)
            clear_terminal()

            for item in pocoes_inventario:
                print(f"-" * 60)
                print(f"Id: {item[0]}")
                print(f"Consumível: {item[1]}")
                print(f"Descrição: {item[2]}")
                print(f"Efeito de vida: {'+' + str(item[3]) if item[3] >= 0 else item[3]}")
                print(f"Preço Unitário: {item[4]}")
                print(f"Quantidade: {item[6]}\n")

            try:
                id_pocao = int(input("\nQual item deseja usar (digite o id do consumível ou digite 0 para cancelar)?\n > "))
                if id_pocao == 0:
                    return jogador_dict
                elif id_pocao in pocoes_id:
                    for item in pocoes_inventario:
                        if item[0] == id_pocao:
                            pocao = item
                            cursor.execute("""
                                DELETE FROM Instancia_de_Item 
                                WHERE ctid = (
                                    SELECT ctid FROM Instancia_de_Item 
                                    WHERE fk_id_item = %s AND fk_id_jogador = %s 
                                    LIMIT 1
                                );""", 
                            (pocao[0], jogador_dict['id_jogador']))
                            connection.commit()
                            jogador_dict['vidaAtual'] = min(pocao[3] + jogador_dict['vidaAtual'], jogador_dict['vidaMax']) 
                            commit_vidaAtual(jogador_dict)
                            print(f"\nVocê usou {pocao[1]} e recuperou {pocao[3]} de vida.")
                            input("Pressione enter para continuar...")
                            return jogador_dict
                else:
                    raise Exception
            except Exception as error:
                print("\nNome inválido. Tente novamente.")
                input("Pressione enter para continuar...")
        
        print("\nVocê não possui consumíveis para usar.")
        input("Pressione enter para continuar...")
        return jogador_dict

    except Exception as error:
        print(f"\nOcorreu um erro ao listar as poções: {error}")
        input("Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def escolher_arma(jogador_dict):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("""
            SELECT a.fk_id_item, a.nome, a.descricao, a.dano_arma, a.preco, ii.fk_id_jogador, COUNT(*)
            FROM Arma a
            JOIN Instancia_de_item ii ON a.fk_id_item = ii.fk_id_item
            WHERE ii.fk_id_jogador = %s
            GROUP BY a.fk_id_item, a.nome, a.descricao, a.dano_arma, a.preco, ii.fk_id_jogador;""",
        (jogador_dict['id_jogador'],))

        armas_inventario = cursor.fetchall()

        armas_id = []
        quantidade_armas = 0
        for item in armas_inventario:
            armas_id.append(item[0])
            quantidade_armas += item[6]

        while quantidade_armas > 0:
            clear_terminal()
            for item in armas_inventario:
                print(f"-" * 60)
                print(f"Id: {item[0]}")
                print(f"Nome: {item[1]}")
                print(f"Descrição: {item[2]}")
                print(f"Dano: {item[3]}")
                print(f"Preço Unitário: {item[4]}\n")

            try:
                id_arma = int(input("\nQual arma deseja equipar (digite o id do item ou digite 0 para cancelar)?\n > "))
                if id_arma == 0:
                    return jogador_dict
                elif id_arma in armas_id:
                    for item in armas_inventario:
                        if item[0] == id_arma:
                            jogador_dict['arma'] = item
                            # precisamos desequipar todas as armas antes de equipar uma nova
                            cursor.execute("""
                                UPDATE instancia_de_item ii
                                SET is_equipado = FALSE
                                FROM arma
                                WHERE arma.fk_id_item = ii.fk_id_item
                                AND ii.fk_id_jogador = %s;""",(jogador_dict['id_jogador'],))
                            connection.commit()
                            # equipando a arma escolhida
                            cursor.execute("""
                                UPDATE instancia_de_item ii
                                SET is_equipado = TRUE
                                FROM arma
                                WHERE arma.fk_id_item = ii.fk_id_item
                                AND ii.fk_id_item = %s
                                AND ii.fk_id_jogador = %s;""",(id_arma, jogador_dict['id_jogador']))
                            connection.commit()
                            input(f"\n{item[1]} equipado(a) com sucesso!\nPressione enter para continuar...")
                            return jogador_dict
                raise Exception
            except Exception as error:
                print("\nNome inválido. Tente novamente.")
                input("Pressione enter para continuar...")
                continue
        print("\nVocê não possui armas para equipar.")
        input("Pressione enter para continuar...")
        return jogador_dict

    except Exception as error:
        print(f"\nOcorreu um erro ao escolher arma: {error}")
        input("Pressione enter para continuar...")

def iniciar_combate(jogador_dict, inimigos_dict, ambiente):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        id_tipo_inimigo = int(input(f"\nQual inimigo deseja combater (digite o ID correspondente)?\n > "))
        
        if id_tipo_inimigo not in [inimigo[0] for inimigo in inimigos_dict["lista_instancias_inimigos"]]:
            input("\nID inválido. Pressione enter para tentar novamente...")
            return 

        instancia_inimigo = get_instancia_inimigo(id_tipo_inimigo, jogador_dict["id_jogador"]) # será a tupla da instancia do inimigo com o menor id_instancia_de_inimigo

        for inimigo in inimigos_dict["lista_instancias_inimigos"]:
            if inimigo[0] == id_tipo_inimigo:
                tipo_inimigo = inimigo
                break

        vida_inimigo = instancia_inimigo[1]
        inimigo_dict = {"vida": vida_inimigo, "tipo": tipo_inimigo, "instancia": instancia_inimigo}

        while inimigo_dict["vida"] > 0 and jogador_dict['vidaAtual'] > 0:        
            if jogador_dict['arma'] is not None:
                dano_jogador = jogador_dict['dano_ataque'] + jogador_dict['arma'][3]
            else:
                dano_jogador = jogador_dict['dano_ataque']

            exibir_status_combate(jogador_dict, inimigo_dict)

            try:
                opcao = int(input("\n O que deseja fazer?\n 1 - Atacar\n 2 - Usar poção de vida\n 3 - Equipar ou trocar de arma\n 4 - Fugir\n> """))

                if opcao == 1:
                    inimigo_dict["vida"] -= dano_jogador 
                    dano_inimigo = ataque_inimigo(ambiente, tipo_inimigo)

                    print(f"\nVocê atacou o(a) {inimigo_dict['tipo'][1]} e causou {dano_jogador} de dano.")
                    
                    if dano_inimigo > 0 and inimigo_dict["vida"] > 0:
                        print(f"O {inimigo_dict['tipo'][1]} te atacou e causou {dano_inimigo} de dano.")
                        jogador_dict['vidaAtual'] -= dano_inimigo
                    elif inimigo_dict["vida"] <= 0:
                        print(f"O(A) {inimigo_dict['tipo'][1]} cai no chão e demonstra não ter sinais de vida...")
                    else:
                        print(f"O {inimigo_dict['tipo'][1]} tentou te atacar, mas você desviou do ataque!")

                    input("\nPressione enter para continuar...")
                elif opcao == 2:
                    jogador_dict = usar_consumivel(jogador_dict)
                elif opcao == 3:
                    jogador_dict = escolher_arma(jogador_dict)
                elif opcao == 4:
                    commit_vidaAtual(jogador_dict, inimigo_dict)
                    return "fuga", jogador_dict
                else:
                    raise Exception
            except ValueError:
                print("\nOpção inválida. Tente novamente.")
                input("Pressione enter para continuar...")
        resultado, jogador_dict = resultado_combate(inimigo_dict, jogador_dict)
        return resultado, jogador_dict
    except Exception as error:
        print(f"\nOcorreu um erro ao iniciar o combate")
        input("Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def info_andar(ambiente, caverna_andar, jogador_dict):

    lista_instancias_inimigos = None
    quantidade_mobs_andar_atual = None

    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("""
            SELECT i.*, COUNT(*) AS quantidade
            FROM Instancia_de_Inimigo ii
            JOIN inimigo i ON ii.fk_inimigo_id = i.id_inimigo
            WHERE ii.fk_id_ambiente = %s AND ii.fk_jogador_id = %s
            GROUP BY i.id_inimigo, i.nome, i.vidamax, i.dano
            ORDER BY quantidade DESC
        """, (caverna_andar[0], jogador_dict['id_jogador'],))
        # lista_instancias_inimigos retorna (nome, id_instancia_de_inimigo, vidaMax, quantidade_tipo_inimigo)
        lista_instancias_inimigos = cursor.fetchall()

        cursor.execute("""
            SELECT COUNT(*)
            FROM instancia_de_inimigo 
            WHERE fk_id_ambiente = %s AND fk_jogador_id = %s;""",
            (ambiente[0], jogador_dict['id_jogador'],))
        quantidade_mobs_andar_atual = cursor.fetchone()

        inimigos_dict = {
            "lista_instancias_inimigos": lista_instancias_inimigos,
            "quantidade_mobs": quantidade_mobs_andar_atual[0] if quantidade_mobs_andar_atual else None
        }
        # TODO:  fazer o mesmo para minerios
        
        return inimigos_dict
    except Exception as error:
        print(f"Ocorreu um erro ao listar os inimigos em info_andar(): {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def atualizar_jogador(jogador):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("SELECT * FROM jogador WHERE id_jogador = %s", (jogador[0],))
        jogador = cursor.fetchone()

        cursor.execute("""
            SELECT a.*
            FROM arma a
            JOIN instancia_de_item ii on ii.fk_id_item = a.fk_id_item
            AND ii.fk_id_jogador = %s
            AND ii.is_equipado = TRUE""" ,(jogador[0],))
        arma = cursor.fetchone()

        jogador_dict = {
            'id_jogador'                        : jogador[0],
            'nome'                              : jogador[1],                  
            'dia'                               : jogador[2],                   
            'tempo'                             : jogador[3],
            'localizacao_atual'                 : jogador[4],                
            'vidaMax'                           : jogador[5],         
            'vidaAtual'                         : jogador[6],       
            'xp_mineracao'                      : jogador[7],     
            'xp_cultivo'                        : jogador[8],       
            'xp_combate'                        : jogador[9],       
            'dano_ataque'                       : jogador[10],
            'moedas'                            : jogador[11],       
            'fk_habMineracao_fk_Habilidade_id'  : jogador[12], 
            'fk_habCombate_fk_Habilidade_id'    : jogador[13],   
            'fk_habCultivo_fk_Habilidade_id'    : jogador[14],
            'arma'                              : arma
        }
            
        return jogador_dict

    except Exception as error:
        print(f"Ocorreu um erro ao atualizar o status do jogador: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def voltar_para_cabana(jogador):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("""
                    UPDATE jogador
                    SET localizacao_atual = 1, vidaAtual = vidaMax 
                    WHERE id_jogador = %s""", (jogador[0],))
        connection.commit()

        clear_terminal()
        print("\nUm dos moradores da cidade estava explorando a caverna quando lhe encontra descordado em um dos andares e te leva para casa...")
        input("\nPressione enter para continuar...")
    except Exception as error:
        print(f"Ocorreu um erro ao voltar para a cabana: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def selecionar_opcao_caverna(inimigos_dict):
    if inimigos_dict["quantidade_mobs"] == 0:
        print("\nNão há inimigos neste andar.")
        opcao = int(input("\nO que deseja fazer?\n 2 - Coletar Minérios\n 3 - Voltar\n> "))
        return opcao
    else:
        print(f"\nVocê olha ao seu redor e enxerga {inimigos_dict['quantidade_mobs']} inimigos:")
        for inimigo in inimigos_dict["lista_instancias_inimigos"]:
            print(f"- {inimigo[6]}x {inimigo[1]} (ID: {inimigo[0]})")
        
        opcao = int(input("\n O que deseja fazer?\n 1 - Iniciar combate\n 2 - Coletar Minérios\n 3 - Voltar\n> "))
        return opcao
            
def conferir_recompensa(jogador_dict, ambiente, caverna_andar):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        quantidade_mobs_andar_atual = info_andar(ambiente, caverna_andar, jogador_dict)["quantidade_mobs"]

        if quantidade_mobs_andar_atual == 0:
            cursor.execute("""
                SELECT Consumivel.*
                FROM Caverna
                Join Consumivel ON fk_id_item_recompensa = fk_id_item
                WHERE Caverna.fk_id_ambiente = %s""",
            (ambiente[0],))
            recompensas = cursor.fetchall()

            if recompensas != []:
                while True:
                    try:
                        print("\nParabéns! Você derrotou todos os inimigos deste andar e encontrou:")
                        for recompensa in recompensas:
                            print(f"- 1x {recompensa[1]}")
                            opcao = int(input("\nPressione 1 para coletar a recompensa e 0 para deixá-la para trás.\n> "))
                            if opcao == 1:
                                cursor.execute("""
                                    INSERT INTO instancia_de_item (fk_id_jogador, fk_id_item, fk_id_inventario)
                                    VALUES
                                    (%s, %s, (
                                                    SELECT id_inventario FROM Inventario WHERE fk_id_jogador = %s
                                            )
                                    );""",
                                (jogador_dict['id_jogador'], recompensa[0], jogador_dict['id_jogador']))
                                connection.commit()
                                print("\nVocê coletou a recompensa com sucesso!")
                                input("\nPressione enter para continuar...")
                                return
                            elif opcao == 0:
                                print("\nVocê deixou a recompensa para trás.")
                                input("\nPressione enter para continuar...")
                                return
                            else:
                                raise Exception
                    except Exception as error:
                        print("\nOpção inválida. Tente novamente.")
                        input("Pressione enter para continuar...")
                        clear_terminal()
            else:
                print("\nVocê derrotou todos os inimigos deste andar, mas não encontrou nenhuma recompensa.")
                input("\nPressione enter para continuar...")
    except Exception as error:
        print(f"\nOcorreu um erro ao conferir a recompensa: {error}")
        input("Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def interacao_caverna(jogador, ambiente):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("SELECT * FROM caverna WHERE fk_id_ambiente = %s", (ambiente[0],))
        caverna_andar = cursor.fetchone()
        jogador_dict = atualizar_jogador(jogador)

        while True:
            clear_terminal()

            if ambiente[0] == 15:
                print("Não há nada para fazer na entrada da caverna.")
                input("\nPressione enter para voltar ao menu...")
                return

            # Exibe o cabeçalho do andar
            print(f"{'=' * 32} {ambiente[1]}: {ambiente[0] - 15}º andar {'=' * 32}")
            print(f"\n{ambiente[3]}")  

            inimigos_dict = info_andar(ambiente, caverna_andar, jogador_dict)


            try:
                opcao = selecionar_opcao_caverna(inimigos_dict)
                if opcao == 1:
                    if inimigos_dict["quantidade_mobs"] == 0:
                        print("\nNão há inimigos para combater neste andar.")
                        input("Pressione enter para continuar...")
                        continue
                    
                    resultado = iniciar_combate(jogador_dict, inimigos_dict, ambiente)
                    avancar_tempo.avancar_tempo(jogador, 10)
                    
                    if resultado == "derrota":
                        voltar_para_cabana(jogador)
                        return
                    elif resultado == "fuga":
                        continue
                    
                    conferir_recompensa(jogador_dict, ambiente, caverna_andar)
                elif opcao == 2:
                    minerar(jogador_dict, caverna_andar)
                    input("Pressione enter para continuar...")
                elif opcao == 3:
                    return  
                else:
                    raise Exception
            except ValueError:
                print("\nOpção inválida. Tente novamente.")
                input("Pressione enter para continuar...")

    except Exception as error:
        print(f"\nOcorreu um erro durante a interação com a caverna: {error}")
        input("Pressione enter para voltar ao menu...")
    finally:
        if connection:
            cursor.close()
            connection.close()
    
def minerar(jogador, caverna_andar):
    andar = 1  # Consultar o banco para descobrir qual o andar atual
    minerios_disponiveis = caverna_andar[3]
    
    if minerios_disponiveis <= 0:    
        print("Você não encontrou minérios para minerar...")
        time.sleep(2)
        return
    print(f"Nesta caverna tem {minerios_disponiveis} minérios")
    time.sleep(2)
    if barra_de_precisao():
        minerio_id = random.choice(list(minerios.keys()))
        minerio = minerios[minerio_id]
        print(f"Parabéns! Você conseguiu minerar e encontrou {minerio['nome']} ({minerio['descricao']})!")
        escolha = int(input("Deseja armazenar o minério? (1 - Sim, 2 - Não) "))
        if escolha == 1:
            connection = get_connection()
            cursor = connection.cursor()
            # cursor.execute("" (,)) (inserir minério na mochila)
            print("Minério armazenado com sucesso!")
            time.sleep(3)
            return minerio
        elif escolha == 2:
            print("Minério descartado...")
            time.sleep(2)
            return
        elif escolha != 1 or escolha != 2:
            print("Opção inválida. Tente novamente.")
            return
    else:
        print("Você quebrou a pedra, mas não encontrou nada de valor :(")
        time.sleep(3)
        return None