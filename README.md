# 2024.2-StardewValley

Repositório para documentação e implementação de projeto para a disciplina Sistema de Bancos de Dados 1.

## Membros do Grupo

<table>
  <tr>
    <td align="center"><a href="https://github.com/MMcLovin"><img style="border-radius: 60%;" src="https://github.com/MMcLovin.png" width="200px;" alt=""/><br /><sub><b>Gabriel Fernando de Jesus Silva</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/GZaranza"><img style="border-radius: 60%;" src="https://github.com/GZaranza.png" width="200px;" alt=""/><br /><sub><b>Gabriel Pessoa Zaranza</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/isaacbatista26"><img style="border-radius: 60%;" src="https://github.com/isaacbatista26.png" width="200px;" alt=""/><br /><sub><b>Isaac Batista</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/manuvaladares"><img style="border-radius: 60%;" src="https://github.com/manuvaladares.png" width="200px;" alt=""/><br /><sub><b>Manuella Valadares</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/devMarcosVM"><img style="border-radius: 60%;" src="https://github.com/devMarcosVM.png" width="200px;" alt=""/><br /><sub><b>Marcos Vieira Marinho</b></sub></a><br /></td>
  </tr>
</table>

## Professor Orientador

Maurício Serrano

## Sobre o Jogo

Stardew Valley é um RPG sem fim da vida no campo! Você herdou a antiga fazenda de seu avô no Vale do Orvalho. Equipado com ferramentas de segunda mão e algumas moedas, você irá começar sua nova vida. Será que você consegue aprender a viver da terra? Não vai ser fácil. Você pode completar missões, criar uma plantação e cuidar de animais, evoluindo suas habilidades e vivendo numa simples fazenda.

# Guia para Rodar o Jogo

## Pré-requisitos

Antes de começar, verifique se você tem os seguintes itens instalados em sua máquina:

- **Python** (versão 3.7 ou superior)
- **Pip** (gerenciador de pacotes Python)
- **Docker** e **Docker Compose** (para gerenciamento de contêineres)

### 1. Clonar o Repositório

Execute o seguinte comando no terminal para clonar o repositório do projeto:

```bash
git clone https://github.com/SBD1/2024.2-StardewValley.git
```

### 2. Entrar na Pasta do Jogo

Acesse o diretório do jogo usando o comando:

```bash
cd 2024.2-StardewValley/game
```

### 3. Inicializar o Docker

Inicie o contêiner Docker no modo em segundo plano (background) com o comando:

```bash
docker compose up -d
```

### 4. Rodar o Jogo

Por fim, execute o seguinte comando para iniciar o jogo:

```bash
python3 main.py
```

## Observações Importantes

- Caso encontre problemas ao executar algum dos comandos, verifique se todos os pré-requisitos estão devidamente instalados e configurados.
- Certifique-se de que o Docker está ativo antes de iniciar o contêiner.

---

<div align="center"> <img src="docs/img/capa.jpg" height="230" width="auto"/> </div>
