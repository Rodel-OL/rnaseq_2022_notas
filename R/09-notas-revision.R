## Porque es importante explorar relaciones entre variables y muestras?
## Es importante explorar la relacion, para luego determinar el modelo
## estadistico que se va a usar. Proporcion de RIN y genes, si hubiera sido una
## no necesito usar todas, pero aunque haya algo de relacion entre ciertas
## muestras, en otras no hay una relacion tan lineal.
##
## Normalizacion de datos en expresion diferencial. Corregir el composition bias
## Se asume que la gran mayoria de los genes ...
##
## Ordena los genes con mayor nivel de expresion diferencial, se usa la opcion de non
## ordena por el valor p. Si no lo arreglamos, tenemos que usar match despues para
## tener un orden personalizado.
## "Se encarga de ordenar los genes con mayores diferencias en su expresión y
## usualmente queremos conservar las posiciones originales"->Daianna
##
## Ejercicio de revision
speaqeasy_data <- file.path(tempdir(), "rse_speaqeasy.RData")
download.file("https://github.com/LieberInstitute/SPEAQeasy-example/blob/master/rse_speaqeasy.RData?raw=true", speaqeasy_data, mode = "wb")
library("SummarizedExperiment")
load(speaqeasy_data, verbose = TRUE)
## Cuantos genes y muestras hay en los datos?
rse_gene
## genes, en rownames, ENSG... muestras, en colnames, R13896
## tmbn se puede ver por las dimensiones
## Ejercicio
rse_gene[rse_gene$PrimaryDx %in% c("totalAssignedGene", "mitoRate"), ]

tapply(rse_gene$mitoRate, rse_gene$PrimaryDx, summary)

library("ggplot2")
ggplot(as.data.frame(colData(rse_gene)), aes(y = mitoRate, x = PrimaryDx)) +
  geom_boxplot() +
  theme_bw(base_size = 20) +
  ylab("mitoRate") +
  xlab("Group")
