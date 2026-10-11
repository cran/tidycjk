## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, message = FALSE, warning = FALSE, comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidycjk)

## ----jamo---------------------------------------------------------------------
cjk_jamo("한글")

## ----jamo-roundtrip-----------------------------------------------------------
back <- vapply(cjk_jamo("한글"), paste, character(1), collapse = "")
cjk_compose_jamo(back)

## ----jamo-other---------------------------------------------------------------
cjk_jamo("café")
cjk_compose_jamo("豈") == "豈"

## ----jamo-count---------------------------------------------------------------
nchar("한")
cjk_width("한")
lengths(cjk_jamo("한"))

## ----kana---------------------------------------------------------------------
to_hiragana("カタカナ")
to_katakana("ひらがな")

to_hiragana(to_katakana("ひらがな"))

## ----kana-mixed-roundtrip-----------------------------------------------------
x <- "アか"                      # one katakana, one hiragana
to_hiragana(x)                    # both become hiragana
to_katakana(to_hiragana(x))       # and cannot be told apart again

## ----kana-icu-----------------------------------------------------------------
to_hiragana("ヵヶ")
to_katakana("ヿ")

## ----kana-mixed---------------------------------------------------------------
to_katakana("日本語のtext です")

## ----kana-width---------------------------------------------------------------
to_hiragana("ｶﾀｶﾅ")
to_katakana("ｶﾞ")
nchar(to_katakana("ｶﾞ"))

## ----han----------------------------------------------------------------------
cjk_simplify("漢字")
cjk_traditionalize("汉字")

## ----han-context--------------------------------------------------------------
cjk_traditionalize(c("头发", "发送"))   # hair, send
cjk_traditionalize(c("干净", "树干"))   # clean, tree trunk
cjk_traditionalize(c("后天", "皇后"))   # after, empress: 后 splits both ways

## ----han-limit----------------------------------------------------------------
cjk_traditionalize(c("软件", "鼠标", "网络"))

## ----romanize-----------------------------------------------------------------
cjk_romanize("中文")
cjk_romanize("中文", ascii = TRUE)

## ----romanize-scripts---------------------------------------------------------
cjk_romanize(c("こんにちは", "안녕하세요"))

## ----romanize-polyphone-------------------------------------------------------
cjk_romanize(c("银行", "音乐"))   # bank, music: yín háng and yīn yuè

## ----romanize-mixed-----------------------------------------------------------
cjk_romanize("漢字カナ")

## ----romanize-ja--------------------------------------------------------------
cjk_romanize("私は日本語を話します")

## ----width-forms--------------------------------------------------------------
as.numeric(to_halfwidth("１２３"))

to_halfwidth("½ Ⅸ ①")   # NFKC rewrites all three; this leaves them

## ----voiced-------------------------------------------------------------------
x <- "ｶﾞ"
nchar(x)
nchar(to_halfwidth(x))
to_halfwidth(x) == "ガ"

## ----normalize----------------------------------------------------------------
both <- c("が", "が")   # composed, then KA + voiced mark
nchar(both)
nchar(cjk_normalize(both))

## ----nfkc---------------------------------------------------------------------
cjk_normalize("ＡＢ　①", form = "nfkc")
cjk_normalize("ＡＢ　①", form = "nfc")

## ----compat-------------------------------------------------------------------
block <- vapply(c(0xF900:0xFA6D, 0xFA70:0xFAD9), intToUtf8, character(1))
sum(cjk_normalize(block, "nfc") != block)   # folded away by plain NFC
sum(cjk_normalize(block, "nfc") == block)   # and the survivors

## ----ivs----------------------------------------------------------------------
ivs <- "辻\U000E0100"
nchar(cjk_normalize(ivs))
nchar(cjk_normalize(ivs, drop_variation_selectors = TRUE))

