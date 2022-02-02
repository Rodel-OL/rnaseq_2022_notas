## Uso de model.matrix
 mat <- with(trees, model.matrix(log(Volume) ~ log(Height) + log(Girth)))
 mat
## with, evita que tengas que poner $ antes de cada variable
## Ver informacion de las columnas
 summary(lm(log(Volume) ~ log(Height) + log(Girth), data = trees))
##ExploreModelMatrix
## Ver que modelo estadistico utilizar
## Ejemplo
 (sampleData <- data.frame(
   genotype = rep(c("A", "B"), each = 4),
   treatment = rep(c("ctrl", "trt"), 4)
 ))
## Crear imagenes con ExploreModelMatrix
 vd <- ExploreModelMatrix::VisualizeDesign(
   sampleData = sampleData,
   designFormula = ~ genotype + treatment,
   textSizeFitted = 4
 )
## Ver el plot
## No solo que significa, sino a donde va
 cowplot::plot_grid(plotlist = vd$plotlist)
## Version interactiva (No carga)
 app <- ExploreModelMatrix(
   sampleData = sampleData,
   designFormula = ~ genotype + treatment
 )
 if (interactive()) shiny::runApp(app)
## Ejemplo II
 (sampleData <- data.frame(
   Response = rep(c("Resistant", "Sensitive"), c(12, 18)),
   Patient = factor(rep(c(1:6, 8, 11:18), each = 2)),
   Treatment = factor(rep(c("pre","post"), 15)),
   ind.n = factor(rep(c(1:6, 2, 5:12), each = 2))))
## full rank, cuando no la hay es que no puedes obtener ciertos datos
## imagen y plot
 vd <- VisualizeDesign(
   sampleData = sampleData,
   designFormula = ~ Response + Response:ind.n + Response:Treatment,
   textSizeFitted = 3
 )
 cowplot::plot_grid(plotlist = vd$plotlist, ncol = 1)
## Busca como descargar VisualizeDesign
## Para el interactivo
 app <- ExploreModelMatrix(
   sampleData = sampleData,
   designFormula = ~ Response + Response:ind.n + Response:Treatment
 )
 #> This Font Awesome icon ('warning') does not exist:
 #> * if providing a custom `html_dependency` these `name` checks can
 #>   be deactivated with `verify_fa = FALSE`
 #> This Font Awesome icon ('') does not exist:
 #> * if providing a custom `html_dependency` these `name` checks can
 #>   be deactivated with `verify_fa = FALSE`
 #> The `name` provided ('hand-o-right') is deprecated in Font Awesome 5:
 #> * please consider using 'hand-point-right' or 'fas fa-hand-point-right' instead
 #> * use the `verify_fa = FALSE` to deactivate these messages
 #> This Font Awesome icon ('question-circle fa-1g') does not exist:
 #> * if providing a custom `html_dependency` these `name` checks can
 #>   be deactivated with `verify_fa = FALSE`
 if (interactive()) shiny::runApp(app)
