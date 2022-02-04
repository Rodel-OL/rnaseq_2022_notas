library("recount3")

human_projects <- available_projects()

rse_gene_SRP045638 <- create_rse(
  subset(
    human_projects,
    project == "SRP045638" & project_type == "data_sources"
  )
)

rse_gene_SRP045638$sra.sample_attributes[1:3]
## Problema, no se pueden leer bien los datos
## [1] "age;;67.78|biomaterial_provider;;LIBD|BioSampleModel;;Human|dev_stage;;Fetal|disease;;Control|Fraction;;total|isolate;;DLPFC|race;;AA|RIN;;8.3|sex;;female|tissue;;DLPFC"
## [2] "age;;40.42|biomaterial_provider;;LIBD|BioSampleModel;;Human|disease;;Control|Fraction;;total|isolate;;DLPFC|race;;AA|RIN;;8.4|sex;;male|tissue;;DLPFC"
## [3] "age;;41.58|biomaterial_provider;;LIBD|BioSampleModel;;Human|disease;;control|Fraction;;total|isolate;;R2869|race;;AA|RIN;;8.7|sex;;male|tissue;;DLPFC"
## Elimina info de solo ciertas muestras con gsub
rse_gene_SRP045638$sra.sample_attributes <- gsub("dev_stage;;Fetal\\|", "", rse_gene_SRP045638$sra.sample_attributes)
rse_gene_SRP045638$sra.sample_attributes[1:3]
## Resultado
# [1] "age;;67.78|biomaterial_provider;;LIBD|BioSampleModel;;Human|disease;;Control|Fraction;;total|isolate;;DLPFC|race;;AA|RIN;;8.3|sex;;female|tissue;;DLPFC"
# [2] "age;;40.42|biomaterial_provider;;LIBD|BioSampleModel;;Human|disease;;Control|Fraction;;total|isolate;;DLPFC|race;;AA|RIN;;8.4|sex;;male|tissue;;DLPFC"
# [3] "age;;41.58|biomaterial_provider;;LIBD|BioSampleModel;;Human|disease;;control|Fraction;;total|isolate;;R2869|race;;AA|RIN;;8.7|sex;;male|tissue;;DLPFC"
## Analisis posterior
rse_gene_SRP045638 <- expand_sra_attributes(rse_gene_SRP045638)

colData(rse_gene_SRP045638)[
  ,
  grepl("^sra_attribute", colnames(colData(rse_gene_SRP045638)))
]
## Pasar de character a numeric o factor
rse_gene_SRP045638$sra_attribute.age <- as.numeric(rse_gene_SRP045638$sra_attribute.age)
rse_gene_SRP045638$sra_attribute.disease <- factor(rse_gene_SRP045638$sra_attribute.disease)
rse_gene_SRP045638$sra_attribute.RIN <- as.numeric(rse_gene_SRP045638$sra_attribute.RIN)
rse_gene_SRP045638$sra_attribute.sex <- factor(rse_gene_SRP045638$sra_attribute.sex)

## Resumen de las variables de interés
summary(as.data.frame(colData(rse_gene_SRP045638)[
  ,
  grepl("^sra_attribute.[age|disease|RIN|sex]", colnames(colData(rse_gene_SRP045638)))
]))
## Encontraremos diferencias entre muestra prenatalas vs postnatales
rse_gene_SRP045638$prenatal <- factor(ifelse(rse_gene_SRP045638$sra_attribute.age < 0, "prenatal", "postnatal"))
table(rse_gene_SRP045638$prenatal)

rse_gene_SRP045638$assigned_gene_prop <- rse_gene_SRP045638$recount_qc.gene_fc_count_all.assigned / rse_gene_SRP045638$recount_qc.gene_fc_count_all.total
summary(rse_gene_SRP045638$assigned_gene_prop)

with(colData(rse_gene_SRP045638), plot(assigned_gene_prop, sra_attribute.RIN))

## Buscar diferencias
with(colData(rse_gene_SRP045638), tapply(assigned_gene_prop, prenatal, summary))

## Guardemos nuestro objeto entero por si luego cambiamos de opinión
rse_gene_SRP045638_unfiltered <- rse_gene_SRP045638

## Eliminemos las muestras malas
hist(rse_gene_SRP045638$assigned_gene_prop)

table(rse_gene_SRP045638$assigned_gene_prop < 0.3)

rse_gene_SRP045638 <- rse_gene_SRP045638[, rse_gene_SRP045638$assigned_gene_prop > 0.3]

## Calculemos los niveles medios de expresión de los genes en nuestras
## muestras.
## Ojo: en un análisis real probablemente haríamos esto con los RPKMs o CPMs
## en vez de las cuentas.
# Apartir de aqui, algo salio mal>>>>>cambia "counts" por "raw_counts"
gene_means <- rowMeans(assay(rse_gene_SRP045638, "raw_counts"))
summary(gene_means)

## Eliminar genes
rse_gene_SRP045638 <- rse_gene_SRP045638[gene_means > 0.1, ]

## Dimensiones finales
dim(rse_gene_SRP045638)
## Porcentaje de lo retenido
round(nrow(rse_gene_SRP045638) / nrow(rse_gene_SRP045638_unfiltered) * 100, 2)
## Deberia ser [1] 73.5, sale [1] 85.6

## Normalizacion de datos, paquete edgeR
library("edgeR") # BiocManager::install("edgeR", update = FALSE)

dge <- DGEList(
  counts = assay(rse_gene_SRP045638, "raw_counts"),
  genes = rowData(rse_gene_SRP045638)
)
dge <- calcNormFactors(dge)
