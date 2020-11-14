# flappybird-as
![Alt Text](https://media.giphy.com/media/efyclU3Mxg5W9aStGN/source.gif)


## Descrição

Pássaro controlado pelo utilizador que possui um movimento vertical
uniformemente acelerado de acordo com a gravidade. O pássaro salta quando o utilizador prime uma interrupção
(I0). Obstáculos verticais vão aparecendo pelo lado direito do ecrã. Estes obstáculos possuem um espaço livre de
tamanho constante ( e posição aleatória) por onde o pássaro deve passar. A colisão com um obstáculo ou com os
limites do jogo causa o fim deste. O utilizador pode controlar a velocidade dos obstáculos recorrendo às interrupções
I1 e I2.
O pássaro só pode ser escrito em intervalos
fixos (linhas). Estas variáveis são a aceleração, a velocidade do pássaro e a posição do pássaro. Temos depois a
constante intervalo de tempo. A velocidade e posição do pássaro são guardadas no registo R6 e R7 respetivamente,
para rápido acesso, outras variáveis são todas guardadas na memória. A variável da posição do pássaro contém a
linha do pássaro e uma parte decimal, o arredondamento desta variável dá a linha atual do pássaro. A implementação
de variáveis em vírgula fixa é feita com a divisão dos 16 bits ao meio (primeiros 8 bits parte inteira e últimos 8 bits
parte decimal).
 Os obstáculos são guardados na tabela da seguinte
forma: os primeiros 8 bits representam o número aleatório gerado que é utilizado para a criação do espaço livre (1
a 15); os últimos 8 bits contêm a coluna atual do obstáculo (0 a 78). As funções que apagam, escrevem, e movem
obstáculos percorrem a tabela e utilizam estes dois valores para executarem as suas funções respetivas.
