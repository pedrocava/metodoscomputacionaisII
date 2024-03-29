### TESTES DE ADERENCIA
### TESTAR SE DADOS ADEREM À UMA DISTRIBUIÇÃO ESPECIFICADA

### UMA PRIMEIRA APLICAÇÃO EM EQUILIBRIO DE HARDY-WEINBERG
library(readr)

dados = read_csv("Genotipo.csv")

## vetor de probabilidades compativeis com equilibrio HW
p = c(0.25, 0.50, 0.25)

## frequencias observadas
table(dados$genotipo)/nrow(dados)

## inspecionar as probabilidades

library(dplyr)

tabela_dif = dados %>%
  group_by(genotipo) %>%
  summarise(observada = n()) %>%
  mutate(esperada = p*100)

## teste mais formal chi-quadrado para probabilidades dadas

chisq.test(table(dados$genotipo), 
           p = p,
           correct = FALSE)


################

amostra = read_table2("amostras.txt")

chisq.test(table(amostra$amost1), p = c(.5, .5), correct = FALSE)

teste2 = chisq.test(table(amostra$amost2), p = dbinom(0:3, 3, .8), correct = FALSE)

teste2$expected

teste3 = chisq.test(table(amostra$amost3), 
           p = dpois(x = 0:15, lambda = 10), 
           correct = FALSE)

plot(dpois(0:25, 10))


################# TESTE DE INDEPENDÊNCIA
############# TESTAS SE AMOSTRAS SÃO INDEPENDENTES

## produtos de 3 fábricas, podem ser defeituosos ou não

tabela = matrix(c(8,62,15,67,11,57),
                nrow= 2, 3)
tabela

chisq.test(tabela, correct = FALSE)
## não rejeitamos a hipotese nula de que as probabilidades de cada evento são
## os produtos das marginais, a amostra parece ser independente




##################### TESTE DE HOMOGENEIDADE
#### TESTAR SE UMA PROPRIEDADE É HOMOGENEA ENTRE SUBGRUPOS DE UMA AMOSTRA

## produtos de 3 fábricas, exatamente 80 de cada

tabela2 = matrix(c(8,72,15,65,11,69),
                 nrow= 2, 3)
tabela2

chisq.test(tabela2, correct = FALSE) ## não rejeitamos a hipotese nula
# a amostra parece ser homogênea entre as categorias

for(i in 1:3) {

assign(paste("p",i, sep = ""),
       tabela2[1,i]/(tabela2[1,i]+tabela2[2,i]))

}

probs = rbind(p1, p2, p3)
barplot(probs, horiz = FALSE, beside = TRUE,
        xlab = "Probabilidade de defeito nas fábricas 1, 2 e 3")

