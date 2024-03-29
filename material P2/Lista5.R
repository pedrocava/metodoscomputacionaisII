

require(tidyverse)
require(readr)
require(readxl)

# -------------------

# 1)


  ## a)

  # O que nos ? informado:
    
      ## amostra gerada de uma distribui??o normal 
      ## media desconhecida
      ## variancia conhecida = 25


teste.media.esq = function(x, alpha, mu0, sigma2){
  
  # Tratando o vetor x para ficar sem NA:
  amostra = na.omit(x)
  
  
  n = length(amostra)
  
  # Obtendo estimativa pontual:
  x.barra = mean(amostra)
  
  # Sob H0, a distribui??o de x.barra ? N(mu0, sigma2 = 25/n):
  x.critico = qnorm(alpha, mean = mu0, sd = sqrt(sigma2/n) )
  
  # Decis?o com base na regi?o critica:
  decisao = ifelse(x.barra < x.critico, "Rejeito H0", "N?o rejeito H0")
  
  # Calculo do p.valor:
  p.valor = pnorm(x.barra, mean = mu0, sd = sqrt(sigma2/n))
  
  # Decis?o com base no p.valor calculado:
  decisao_p.valor = ifelse(p.valor < alpha, "Rejeito H0", "N?o rejeito H0")
  
  # Retorno da fun??o:
  return( cat("Estimativa pontual =", round(x.barra, 3), "\n", 
              "Regi?o Cr?tica:", "[-Inf,", round(x.critico, 3), "]", "\n",
              "Decis?o (RC):", decisao, "\n",
              "P-valor =", p.valor, "\n",
              "Decis?o (p.valor):", decisao_p.valor, sep = "") )
  
  
}



  ## e)

    # H0: mu = mu0
    # H1: mu < mu0

  # Nesse caso, a RC = [-Inf, mu.critico]

  beta.esq = function(n, alpha, mu, mu0, sigma2){
    
    x.critico = qnorm(alpha, mu0, sqrt(sigma2/n))
    
    # erro tipo II = probabilidade de n?o rejeitar dado mu (H1):
    prob = pnorm(x.critico, mu, sqrt(sigma2/n), lower.tail = FALSE)
    return(prob)
    
  }

  ## f)
  
  ggplot(data = data.frame(x = c(0, 60)), aes(x = x)) + 
    stat_function(fun = beta.esq, args = list(n = 20, alpha = 0.05, mu0 = 30, sigma2 = 25)) + 
    xlab(expression(mu)) + 
    ylab(expression(beta(mu))) 
  
  
  # 5)
  
    # H0: p = p0
    # H1: p > p0
  
  ## Nesse caso, a rc = [p.critico, +Inf)
  
  beta.prop.dir = function(n, alpha, p, p0){
    
    p.critico = qnorm( 1 - alpha, mean = p0, sd = sqrt(p0 * (1 - p0)/n))
    
    # erro tipo II = probabilidade de n?o rejeitar dado mu (H1):
    prob = pnorm(p.critico, p, sd = sqrt(p0 * (1 - p0)/n) )
    return(prob)
  }
  
  # Testando a fun??o:
  ggplot(data = data.frame(x = c(0, 1)), aes(x = x)) + 
    stat_function(fun = beta.prop.dir, args = list(n = 20, alpha = 0.05, p0 = 0.45)) + 
    xlab(expression(p)) + 
    ylab(expression(beta(p))) 
  