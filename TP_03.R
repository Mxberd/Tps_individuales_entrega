#TRABAJO PRACTICO 03- SCRAPEO EN LINEA.

library(rvest)
library(tidyverse)
library(tibble)
library(stringr)


#CARGAMOS LAS LIBRERIAS A UTILIZAR
#LA IDEA ES CAPTURAR DATOS DESDE LA WEB USANDO LA INFORMACION DEL INTERFAZ DE PAGINAS.

#Vamos a investigar la informacion sobre guacamayos en Wikipedia.
#usamos Selector Gadget para identificar los contenidos de la pagina y poder traerlos

url <- "https://es.wikipedia.org/wiki/Ara_(animal)"

base_00 <- read_html(url)


Subespecies <- base_00 %>% 
  html_elements("i a") %>% 
  html_text2()

#Aprovechamos que cada especie es un tipo de objeto (hipervinculo a su propio articulo para hacer una lista de todas las especies)

Subespecies_00 <- tibble(Subespecies)

# Hemos Generado una lista con las especies de Guacamayo con la informacion extraida de Wikipedia

Subespecies_00 <- Subespecies_00 %>% 
  data.frame()


#Queremos realizar una busqueda de palabras clave. Hacemos un experimemento con la pagina del
#ARA ARARAUNA

url_00 <- "https://es.wikipedia.org/wiki/Ara_ararauna"
base_01 <- read_html(url_00)

Datos <- base_01  %>% 
  html_elements("div p") %>% 
  html_text2() %>% 
  data.frame()

Peligro<- base_01  %>% 
  html_elements("td a") %>% 
  html_text2() %>% data.frame() %>% 
  slice(4) 

Subespecies_Peligro<- 
  data.frame(Subespecie=c("Ara Arauna"), Estado= c("Preocupacion Menor"))

#Podemos repetir esta operacion recopilando datos por medio del scrapeo y asi construir
#nuestra tabla de especies en peligro.

#extrajimos informacion de texto, ahora preguntamos si habitan en el Amazonas
#Para ello, buscamos palabras que refieran a ese habitat.

Ararauna_00 <- Datos %>% 
  as.character(.) %>% 
  str_detect( string = ., pattern = "Amazonia") 
Ararauna_01 <- Datos %>% 
  as.character(.) %>% 
  str_detect( string = ., pattern = "Amazonas") 
Ararauna_02 <- Datos %>% 
  as.character(.) %>% 
  str_detect( string = ., pattern = "Amazonica") 
Ararauna_03 <- Datos %>% 
  as.character(.) %>% 
  str_detect( string = ., pattern = "Amazonicas")
Ararauna_04 <- Datos %>% 
  as.character(.) %>% 
  str_detect( string = ., pattern = "Amazonicos")
Ararauna_05 <- Datos %>% 
  as.character(.) %>% 
  str_detect( string = ., pattern = "Amazonico")


#En el texto analizado no se detectaron referencias explicitas al Amazonas. Deberia incluirse.
#Podemos utilizar str_detect para identificar paralabras claves, o realizar correcciones si estan faltan.
