from setup.database import get_connection
import os

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def interacao_cabana(Jogador):
    clear_terminal()
    while True:

        print("Você chegou na cabana!")
        print("O que deseja fazer?")
        print("1 - Dormir")
        print("2 - Sair")
        opcao = input("Digite a opção desejada: ")

        if opcao == "1":
            print("Você dormiu por 8 horas")
            Jogador.dormir()
        elif opcao == "2":
            print("Você saiu da cabana")
        else:
            print("Opção inválida")