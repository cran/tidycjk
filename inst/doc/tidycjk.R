## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidycjk)

## ----corpus-------------------------------------------------------------------
posts <- data.frame(
  id = 1:5,
  text = c(
    "我今天很開心",            # Chinese
    "こんにちは、元気ですか",  # Japanese, with kana
    "안녕하세요",              # Korean
    "東京都",                  # Japanese written without kana
    "no CJK here at all"
  )
)

cjk_summary(posts, text)

## ----counts-------------------------------------------------------------------
cjk_char_counts(posts, text)

## ----detect-------------------------------------------------------------------
cjk_script(posts$text)
cjk_detect_language(posts$text)

## ----detect-optin-------------------------------------------------------------
cjk_detect_language(posts$text, han_only = "chinese")

## ----segment-icu--------------------------------------------------------------
cjk_segment("我今天很開心", engine = "icu")

## ----segment-character--------------------------------------------------------
cjk_segment("我今天很開心", engine = "character")

## ----tokens-------------------------------------------------------------------
cjk_tokens(posts[1:2, ], text, engine = "icu")

## ----sentences----------------------------------------------------------------
cjk_sentences("我今天很開心。你呢？天氣很好！")

## ----ngrams-------------------------------------------------------------------
cjk_ngrams("中文很好")

## ----strip-punct--------------------------------------------------------------
cjk_strip_punct("他說（今天）。真好")

cjk_ngrams(cjk_strip_punct("好。天"))        # nothing spans the stop
cjk_ngrams(cjk_strip_punct("好。天", ""))    # deleting it invents 好天

## ----sort---------------------------------------------------------------------
x <- c("張", "王", "李")   # Zhang, Wang, Li

x[order(vapply(x, utf8ToInt, integer(1)))]  # code point order, explicitly
cjk_sort(x, locale = "zh")                  # pinyin
cjk_sort(x, locale = "zh-u-co-stroke")      # stroke count

## ----width--------------------------------------------------------------------
labels <- c("中文", "abcd", "日本語")

nchar(labels)
cjk_width(labels)

## ----pad----------------------------------------------------------------------
cat(paste0("|", cjk_pad(labels, 8), "|"), sep = "\n")

## ----wrap---------------------------------------------------------------------
cat(cjk_wrap("我今天很開心，因為天氣非常好而且朋友來看我", 12))

## ----halfwidth----------------------------------------------------------------
as.numeric(to_halfwidth("１２３"))
to_halfwidth("½ Ⅸ ①")   # NFKC would rewrite all three

## ----normalize----------------------------------------------------------------
ga <- c("\u304c", "\u304b\u3099")   # composed, then KA + voiced mark
nchar(ga)
nchar(cjk_normalize(ga))
cjk_normalize("ＡＢ　①", form = "nfkc")

## ----translit-----------------------------------------------------------------
cjk_romanize("中文")
cjk_simplify("漢字")
to_hiragana("カタカナ")
cjk_jamo("한")

## ----blocks-------------------------------------------------------------------
head(cjk_blocks(), 8)
nrow(cjk_blocks())

