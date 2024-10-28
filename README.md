# Advent of Code 2023
## Explicação:
Advent of Code é um desafio anual no qual, durante os dias 1 até 25 de dezembro, são lançados desafios de código no qual são dados uma explicação do desafio, um arquivo de texto que serve como input, e deve-se escrever um programa que, dado esse input, retorna o valor correto. Cada dia possuí duas partes, com a segunda parte usando parte do que foi feita na primeira como uma base.

Para esse trabalho, decidi realizar os primeiros 4 dias + a primeira parte do dia 5. Uma implementação da segunda parte do dia 5 foi escrita, porém ela demoraria horas (possivelmente mais de um dia) para executar. Além disso, também foram feitas implementações dos dias 1 e 2 em Python, como uma forma de comparar a implementação em linguagens funcionais com em linguagens imperativas.

## Dia 1
### Parte 1
O primeiro desafio involve apenas a leitura de strings do arquivo, achar o primeiro e último digítos de cada string, ler eles como um número e realizar a soma desses. 
### Parte 2
Na segunda parte é necessário ler strings dos nomes dos números além dos dígitos. Para isso, usei uma função com pattern matching para transformar a primeira letra de cada número presente no digito desse número e então é feito o mesmo que na parte 2.

## Dia 2
### Parte 1
O desafio do dia 2 involve principalmente a leitura do arquivo. Para isso, foi criado uma função `splitString :: Char -> String -> [String]`, que recebe um caractere e uma string, e retorna uma lista de strings na qual cada elemento é uma parte da string original, dividido pelo caractere. Essa função é então usada para ler cada linha do input: primeiro, a linha é divivida no caractere ':', que divide o indice do jogo dos sets do jogo. Os sets então são divididos em ';',  em cada set individual, cada set é então dividido em ',', que resulta em cada número de cubos, e o número de cubos é dividido em ' ', resultando no número e na cor dos cubos. Cada set então retorna uma tupla de 3 Ints, representando os cubos vermelhos, verdes e azuis, e cada jogo retorna uma tupla com seu index, e uma lista de tuplas que representam os cubos de cada set. É usado um `filter` para retornar todos os jogos possíveis (ou seja, aqueles cujo nenhum dos sets tem mais cubos vermelhos do que 12, verdes que 13 e azuis que 14), e é usado o `sum` nos indíces desses jogos.
### Parte 2
Para a parte 2, é usado o parsing da parte 1, mas é usado um `foldl` para achar a quantidade mínima de cubos para que o jogo seja possível através da função `max`, e a soma é realizada no resultado da multiplicação dessas quantidades minínimas ao invés do indíce dos jogos.

## Dia 1 e 2: Python
Na versão escrita em Python, as principais diferenças do código em relação ao código em haskell é o uso de loops e modificações de listas para a criação de novas listas contendo os elementos corretos. Em haskell, isso é feito de forma declarativa através de `map`, `filter`, ou `list comprehension`. Por exemplo, o que em haskell pode ser apenas `filter (gameIsPossible (12 13 14)) games`, em python precisaria ser:
```py
possibleGames = []
for game in games:
    if isPossible(game):
        possibleGames.append(game)
```
Essa diferença torna o código funcional mais sucinto do que o procedimental.

## Dia 3
### Parte 1
O desafio do dia 3 involve a leitura de diversos números de lista de strings e descobrir quais desses números estão adjacentes a símbolos que não são dígitos nem um ponto final '.'. Para isso, criei uma função `isSymbol :: Char -> Bool` que retorna se um dado caractere é ou não um símbolo e uma função `charAt :: Int -> Int -> [String] -> Char` que retorna o caractere na posição dada dentro dessa lista de strings. Essa função também verifica se a posição está fora dos limites da lista ou das strings e se for retorna um '.', ou seja, o espaço fora do que foi dado é assumido que seja apenas '.'.
Seguindo, a próxima função importante é `getNumber :: Int -> Int -> String -> ((Int, Int, Int, Int), String)`. Essa função recebe uma linha e coluna e uma string, e retorna uma tupla. Essa tupla contém informações do número (a linha, coluna, número de dígitos e valor) assim como o resto da string após o final do número. Essa função é então usada em `getNumbersFromLine :: Int -> Int -> String -> [(Int, Int, Int, Int)]` para ler a informação de todos os números em uma dada linha. A função `getNumbersFromSchematic :: [String] -> [(Int, Int, Int, Int)]` então concatena todos os números da esquemática em uma única lista através da função `concat` e com `list comprehension`.
Podemos então usar a função `regionAdjacentToSymbol :: Int -> Int -> Int -> [String] -> Bool`, que recebe o número de dígitos de uma região, a linha e a coluna inicial, gera uma lista de todos os vizinhos dessa região através de list comprehension e verifica se qualquer símbolo nessa lista de vizinhos é um símbolo.
A parte 1 então é resolvida simplesmente usando um `filter` com `regionAdjacentToSymbol` no resultado de `getNumbersFromSchematic` e somando o valor de todos os resultados com `sum`.
### Parte2 

## Dia 4

## Dia 5
