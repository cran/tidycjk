## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, message = FALSE, warning = FALSE, comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidycjk)

## ----engines------------------------------------------------------------------
cjk_segmenters()

## ----icu----------------------------------------------------------------------
cjk_segment("我今天很開心", engine = "icu")

cjk_segment("今天天氣很好我們去公園散步", engine = "icu")

## ----icu-ja-------------------------------------------------------------------
cjk_segment("今日は良い天気ですね", engine = "icu", locale = "ja")

## ----character----------------------------------------------------------------
cjk_segment("我今天很開心", engine = "character")

## ----mixed--------------------------------------------------------------------
cjk_segment("hello 中文 world", engine = "character")

## ----tokens-------------------------------------------------------------------
posts <- data.frame(
  id = 1:3,
  text = c("我今天很開心", "今天天氣很好", "hello 中文 world")
)

cjk_tokens(posts, text, engine = "icu")

## ----counting-----------------------------------------------------------------
tok <- cjk_tokens(posts, text, engine = "icu")
sort(table(tok$token), decreasing = TRUE)[1:5]

## ----compare------------------------------------------------------------------
x <- "今天天氣很好"
vapply(c("icu", "character"),
       function(e) paste(cjk_segment(x, engine = e)[[1]], collapse = " | "),
       character(1))

