## Lets build our first SummarizedExperiment object
library("SummarizedExperiment")
## Para cargar el paquete, tiene 24 dependencias

## De los ejemplos en la ayuda oficial

## Creamos los datos para nuestro objeto de tipo SummarizedExperiment
## para 200 genes a lo largo de 6 muestras
nrows <- 200
ncols <- 6
## Números al azar de cuentas
set.seed(20220202)
## Semilla es el dia de la clase
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
## Información de nuestros genes
rowRanges <- GRanges(
  rep(c("chr1", "chr2"), c(50, 150)),
  IRanges(floor(runif(200, 1e5, 1e6)), width = 100),
  strand = sample(c("+", "-"), 200, TRUE),
  feature_id = sprintf("ID%03d", 1:200)
)
## strand es aleatorio en este ejemplo
## sprintf("ID%03d", 1:200), los ID tendran 3 digitos
## el primero seria ID001, de 1 a 200
names(rowRanges) <- paste0("gene_", seq_len(length(rowRanges)))
## Información de nuestras muestras, ponerle gen al menos
colData <- DataFrame(
  Treatment = rep(c("ChIP", "Input"), 3),
  row.names = LETTERS[1:6]
)
## Juntamos ahora toda la información en un solo objeto de R
rse <- SummarizedExperiment(
  assays = SimpleList(counts = counts),
  rowRanges = rowRanges,
  colData = colData
)

## Exploremos el objeto resultante
rse

# class: RangedSummarizedExperiment
# dim: 200 6
# metadata(0):
#   assays(1): counts
# rownames(200): gene_1 gene_2 ... gene_199 gene_200
# rowData names(1): feature_id
# colnames(6): A B ... E F
# colData names(1): Treatment
#
## Como queda el resultado final:
#
# GRanges object with 200 ranges and 1 metadata column:
#   seqnames        ranges strand |  feature_id
# <Rle>     <IRanges>  <Rle> | <character>
#   gene_1     chr1 363920-364019      + |       ID001
# gene_2     chr1 237890-237989      - |       ID002
# gene_3     chr1 558232-558331      + |       ID003
# gene_4     chr1 937860-937959      - |       ID004
# gene_5     chr1 350951-351050      + |       ID005
# ...      ...           ...    ... .         ...
# gene_196     chr2 988029-988128      - |       ID196
# gene_197     chr2 119260-119359      + |       ID197
# gene_198     chr2 989126-989225      + |       ID198
# gene_199     chr2 929798-929897      - |       ID199
# gene_200     chr2 512351-512450      - |       ID200
# -------
#   seqinfo: 2 sequences from an unspecified genome; no seqlengths

## Número de genes y muestras
dim(rse)
## IDs de nuestros genes y muestras
dimnames(rse)
## Nombres de tablas de cuentas que tenemos (RPKM, CPM, counts, logcounts, etc)
assayNames(rse)
## El inicio de nuestra tabla de cuentas
head(assay(rse))
## Tabla con información de los genes
rowData(rse) # es idéntico a 'mcols(rowRanges(rse))'
## Tabla con información de las muestras
colData(rse)
##Ejercicio
## Comando 1
 rse[1:2, ]
## restringe el numero de genes que se pueden ver
## Comando 2
 rse[, c("A", "D", "F")]
## restringe el numero de columnas que se pueden visualizar por gen
#
## >>iSEE<<
## Cargar el paquete
 library("iSEE")
## Usar iSEE con lo que trabajamos
 iSEE::iSEE(rse)
## Es una manera interactiva de visualizar los resultados
## A ti te carga en entre 7 y 10 minutos
## >>Ejercicios con spatialLIBD<<
## datos de spatialLIBD
 sce_layer <- spatialLIBD::fetch_data("sce_layer")
## Te va a pedir crear un directorio, dile u si
## Ver que hay
 sce_layer
## Tamano, da 32.41103
 lobstr::obj_size(sce_layer) / 1024^2 ## Convertir a MB
## Usar iSEE para explorar datos
 iSEE::iSEE(sce_layer)
## Ejercicio
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## Sube el PDF
## RNAseq y recount3
