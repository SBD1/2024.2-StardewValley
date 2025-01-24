import time
import random
import sys
import select

def barra_de_precisao():
    largura = 30
    alvo_inicio = random.randint(2, largura - 8)
    alvo_fim = alvo_inicio + 5  # Posição do alvo (fim)
    
    marcador = 0
    direcao = 1  # Direção do movimento
    jogador_interagiu = False  # Flag para capturar a interação do jogador
    acerto = False  # Resultado da mineração

    print("=== MINERAÇÃO ===")
    print("Pressione ENTER quando o marcador estiver na área do alvo [#]")
    print("\nLegenda: [ ] = barra, [#] = alvo, [|] = marcador\n")

    while not jogador_interagiu:
        barra = [" "] * largura
        for i in range(alvo_inicio, alvo_fim):
            barra[i] = "#"
        barra[marcador] = "|"
        
        print("\r[" + "".join(barra) + "]", end="", flush=True)
        
        marcador += direcao
        if marcador == largura - 1 or marcador == 0:
            direcao *= -1

        if sys.stdin in select.select([sys.stdin], [], [], 0)[0]:
            jogador_interagiu = True
            entrada = sys.stdin.readline().strip()
            if alvo_inicio <= marcador <= alvo_fim:
                acerto = True
        
        time.sleep(0.04)

    print("\n")
    if acerto:
        print("Parabéns! Você conseguiu minerar com precisão!")
        return True
    else:
        print("Você errou! Tente novamente!")
        return False

if __name__ == "__main__":
    if barra_de_precisao():
        print("Você encontrou um minério raro!")
    else:
        print("Você quebrou a pedra, mas não encontrou nada de valor.")
