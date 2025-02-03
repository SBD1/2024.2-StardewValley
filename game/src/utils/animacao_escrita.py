import time
import sys

def print_animado(mensagem, delay=0.02):
    for char in mensagem:
        sys.stdout.write(char)
        sys.stdout.flush()  # Garante que o caractere seja exibido imediatamente
        time.sleep(delay)
    print()  # Para pular para a próxima linha após a mensagem