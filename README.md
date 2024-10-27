# Advent of Code 2023
## Explicação:
Advent of Code é um desafio anual no qual, durante os dias 1 até 25 de dezembro, são lançados desafios de código no qual são dados uma explicação do desafio, um arquivo de texto que serve como input, e deve-se escrever um programa que, dado esse input, retorna o valor correto. Cada dia possuí duas partes, com a segunda parte usando parte do que foi feita na primeira como uma base.

Para esse trabalho, decidi realizar os primeiros 4 dias + a primeira parte do dia 5. Uma implementação da segunda parte do dia 5 foi escrita, porém ela demoraria horas (possivelmente mais de um dia) para executar. Além disso, também foram feitas implementações dos dias 1 e 2 em Python, como uma forma de comparar a implementação em linguagens funcionais com em linguagens imperativas.

## Dia 1resultando
### Parte 1
O primeiro desafio involve apenas a leitura de strings do arquivo, achar o primeiro e último digítos de cada string, ler eles como um número e realizar a soma desses. 
### Parte 2
Na segunda parte é necessário ler strings dos nomes dos números além dos dígitos. Para isso, usei uma função com pattern matching para transformar a primeira letra de cada número presente no digito desse número e então é feito o mesmo que na parte 2.

## Dia 2
### Parte 1
O desafio do dia 2 involve principalmente a leitura do arquivo. Para isso, foi criado uma função `splitString :: Char -> String -> [String]`, que recebe um caractere e uma string, e retorna uma lista de strings na qual cada elemento é uma parte da string original, dividido pelo caractere. Essa função é então usada para ler cada linha do input: primeiro, a linha é divivida no caractere ':', que divide o indice do jogo dos sets do jogo. Os sets então são divididos em ';',  em cada set individual, cada set é então dividido em ',', que resulta em cada número de cubos, e o número de cubos é dividido em ' ', resultando no número e na cor dos cubos. Cada set então retorna uma tupla de 3 Ints, representando os cubos vermelhos, verdes e azuis, e cada jogo retorna uma tupla com seu index, e uma lista de tuplas que representam os cubos de cada set. É usado um `filter` para retornar todos os jogos possíveis (ou seja, aqueles cujo nenhum dos sets tem mais cubos vermelhos do que 12, verdes que 13 e azuis que 14), e é usado o `sum` nos indíces desses jogos.
### Parte 2
Para a parte 2, é usado o parsing da parte 1, mas é usado um `foldl` para achar a quantidade mínima de cubos para que o jogo seja possível através da função `max`, e a soma é realizada no resultado da multiplicação dessas quantidades minínimas ao invés do indíce dos jogos.

## Dia 3

## Dia 4

## Dia 5
