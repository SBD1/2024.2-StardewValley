# Mudanças do Módulo 3

## 1. Adaptação do Diagrama para a Lógica do Jogo

### 1.1 - Casa do Jogador
A missão inicialmente seria atribuída dentro da tabela **Caixa de Mensagem**, mas decidimos removê-la e atribuir a missão para um dia específico do jogo. Isso eliminou a necessidade de especializar esse tipo de ambiente, já que não havia nenhum atributo fora do modelo de ambiente.

### 1.2 - Plantação
Decidimos reduzir o escopo da plantação, mantendo a interação do jogador com ela. Removemos as ações de **plantar** e **regar**, condicionando o jogador às ações de **colher**, **vender planta**, **consumir planta** e **comprar planta**. Dessa forma, o jogador não precisa se preocupar com o plantio e a manutenção, pois, ao comprar uma planta, ela é automaticamente adicionada à sua plantação.

### 1.3 - Instância de Item
Como o jogo é multijogador, decidimos criar **instâncias de itens** para que cada item possa ser atribuído a um jogador específico. Isso garante que o jogador só possa interagir com os itens associados ao seu ID. Essa abordagem evita que um jogador interfira na missão de coleta de outro, por exemplo.

### 1.4 - Utensílio
A entidade **Utensílio** foi removida por não ter um impacto significativo no jogo. **Ferramenta** e **Arma** foram consideradas especializações de **Item**, simplificando a estrutura.

### 1.5 - Recompensa
Percebemos que a entidade **Recompensa** era dispensável, pois é mais lógico atribuir itens diretamente a uma **instância de missão**.

### 1.6 - Inventário
Anteriormente, o **inventário** estava ligado à **instância de inimigo**. No entanto, decidimos alterar essa lógica e relacionar o **inimigo** diretamente com **item**, já que um inimigo pode dropar apenas um item.

### 1.7 - Mapa
Inicialmente, o **mapa** seria criado individualmente para cada jogador. Porém, seguindo a orientação do professor, optamos por manter um único mapa onde todos os jogadores interagem, separando apenas as instâncias de cada um.

---