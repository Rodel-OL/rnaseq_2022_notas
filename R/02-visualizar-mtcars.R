library("sessioninfo")
library("here")
library("ggplot2")

## Hello world
print("Soy Rodelmar")

## Directorios
dir_plots <- here::here("figuras")
dir_rdata <- here::here("processed-data")

## Crear directorio para las figuras y archivos
dir.create(dir_plots, showWarnings = FALSE)
dir.create(dir_rdata, showWarnings = FALSE)

## Hacer una imagen de ejemplo
pdf(file.path(dir_plots, "mtcars_gear_vs_mpg.pdf"),
    useDingbats = FALSE
)
ggplot(mtcars, aes(group = gear, y = mpg)) +
  geom_boxplot()
dev.off()

## Para reproducir mi código
options(width = 120)
sessioninfo::session_info()
# R version 4.0.5 (2021-03-31) -- "Shake and Throw"
# Copyright (C) 2021 The R Foundation for Statistical Computing
# Platform: x86_64-w64-mingw32/x64 (64-bit)
#
# R es un software libre y viene sin GARANTIA ALGUNA.
# Usted puede redistribuirlo bajo ciertas circunstancias.
# Escriba 'license()' o 'licence()' para detalles de distribucion.
#
# R es un proyecto colaborativo con muchos contribuyentes.
# Escriba 'contributors()' para obtener más información y
# 'citation()' para saber cómo citar R o paquetes de R en publicaciones.
#
# Escriba 'demo()' para demostraciones, 'help()' para el sistema on-line de ayuda,
# o 'help.start()' para abrir el sistema de ayuda HTML con su navegador.
# Escriba 'q()' para salir de R.
#
# > usethis::use_r("01-notas.R")
# √ Setting active project to 'C:/Users/OL/rnaseq_2022_notas'
# * Modify 'R/01-notas.R'
# * Call `use_test()` to create a matching test file
# > usethis::use_r("02-visualizar-mtcars.R")
# * Modify 'R/02-visualizar-mtcars.R'
# * Call `use_test()` to create a matching test file
# > sessioninfo::session_info()
# - Session info ------------------
#   setting  value
# version  R version 4.0.5 (2021-03-31)
# os       Windows 10 x64 (build 19042)
# system   x86_64, mingw32
# ui       RStudio
# language (EN)
# collate  Spanish_Mexico.1252
# ctype    Spanish_Mexico.1252
# tz       America/Mexico_City
# date     2022-02-01
# rstudio  1.4.1106 Tiger Daylily (desktop)
# pandoc   NA
#
# - Packages ----------------------
#   package     * version date (UTC) lib source
# cli           3.1.1   2022-01-20 [1] CRAN (R 4.0.5)
# crayon        1.4.2   2021-10-29 [1] CRAN (R 4.0.5)
# ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.0.5)
# fansi         1.0.2   2022-01-14 [1] CRAN (R 4.0.5)
# fs            1.5.2   2021-12-08 [1] CRAN (R 4.0.5)
# glue          1.6.1   2022-01-22 [1] CRAN (R 4.0.5)
# here          1.0.1   2020-12-13 [1] CRAN (R 4.0.5)
# lifecycle     1.0.1   2021-09-24 [1] CRAN (R 4.0.5)
# magrittr      2.0.2   2022-01-26 [1] CRAN (R 4.0.5)
# pillar        1.7.0   2022-02-01 [1] CRAN (R 4.0.5)
# pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.5)
# purrr         0.3.4   2020-04-17 [1] CRAN (R 4.0.5)
# rlang         0.4.12  2021-10-18 [1] CRAN (R 4.0.5)
# rprojroot     2.0.2   2020-11-15 [1] CRAN (R 4.0.5)
# rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.0.5)
# sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.0.5)
# tibble        3.1.6   2021-11-07 [1] CRAN (R 4.0.5)
# usethis       2.1.5   2021-12-09 [1] CRAN (R 4.0.5)
# utf8          1.2.2   2021-07-24 [1] CRAN (R 4.0.5)
# vctrs         0.3.8   2021-04-29 [1] CRAN (R 4.0.5)
#
# [1] C:/Users/OL/Documents/R/win-library/4.0
# [2] C:/Program Files/R/R-4.0.5/library
#
# ---------------------------------
