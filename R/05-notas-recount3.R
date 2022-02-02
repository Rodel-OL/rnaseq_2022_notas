## Datos de RNAseq y recount3
## Cargar recount3
 library("recount3")
## Descargar datos de un estudio de interes
 create_rse()
## Revisa los proyectos para humano
 human_projects <- available_projects()
##
## SRP009615 de ejemplo
 proj_info <- subset(
   human_projects,
   project == "SRP009615" & project_type == "data_sources"
 )
## RangedSummarizdExperiments
 rse_gene_SRP009615 <- create_rse(proj_info)
## Explora los proyectos disponibles de forma interactiva
 proj_info_interactive <- interactiveDisplayBase::display(human_projects)
## Selecciona un solo renglón en la tabla y da click en "send".
## Aquí verificamos que solo seleccionaste un solo renglón.
 stopifnot(nrow(proj_info_interactive) == 1)
## Crea el objeto RSE
 rse_gene_interactive <- create_rse(proj_info_interactive)
## Convirtamos las cuentas por nucleotido a cuentas por lectura
## usando compute_read_counts().
## Para otras transformaciones como RPKM y TPM, revisa transform_counts().
 assay(rse_gene_SRP009615, "counts") <- compute_read_counts(rse_gene_SRP009615)
##>>Ejercicio con iSEE<<
 iSEE::iSEE(rse_gene_SRP009615)
##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
## Sube el PDF
