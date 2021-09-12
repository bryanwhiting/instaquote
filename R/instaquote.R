#' Generate HTML for quotes
#'
#' @param title Title
#' @param subtitle Subtitle (optional)
#' @param title_size Font size of title. Default:30
#' @param subtitle_size
#'
#' @return
#' @export
#'
#' @examples
#' insta_text("hi there!")
insta_text <- function(title, subtitle = NULL, title_size = 30, subtitle_size = 12) {
  # Don't want to confuse this with the global span
  span <- function(text, size) {
    glue::glue(
      "<span style='font-size:{size}pt; font-family:Helvetica;'>
    {text}
    </span>"
    )
  }

  top <- span(title, size = title_size)
  text <- top
  if (!is.null(subtitle)) {
    middle <- span("**———————————————————————————————————————————————**", size = 3)
    bottom <- span(subtitle, size = subtitle_size)
    text <- glue::glue("{text}<br>{middle}<br><br>{bottom}")
  }
  text
}

#' Generate a ggplot of a quote
#'
#' Uses `ggtext::geom_textbox()` and `ggplot2::theme_void()` to generate
#' a simple quote. Quotes can be posted to social media or within rmarkdown.
#'
#' @param text Text you want to pass in. use generate_text().
#' @param bg_color Plot background color, default: ggthemes::palette_pander(n = 1)
#' @param text_color Color of text. default: white.
#'
#' @return ggplot2 object
#' @export
#'
#' @examples
#' txt <- insta_text("hello world")
#' instaquote(txt)
instaquote <- function(title,
                       subtitle = NULL,
                       title_size = 30,
                       subtitle_size = 12,
                       bg_color = "#56B4E9",
                       text_color = "white",
                       caption = "gospelanalysis.com") {

  text <- insta_text(title = title, subtitle = subtitle, title_size = title_size, subtitle_size = subtitle_size)

  df <- data.frame(text = text, x = 1, y = 1)

  ggplot2::ggplot(df, ggplot2::aes(x = x, y = x, label = text)) +
    ggplot2::theme_void() +
    ggtext::geom_textbox(
      width = grid::unit(0.9, "npc"), # 73% of plot panel width
      # hjust = 0, vjust = 1,
      # halign = 0.5 # centered text
      box.padding = ggplot2::unit(c(0, 0, 0, 0), "pt"),
      box.color = bg_color, # border color
      text.color = text_color,
      fill = bg_color, # color inside the label
      halign = 0.5
      # size = 20
    ) +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = bg_color),
      plot.caption = ggtext::element_markdown(color = "white", size = 8)
    ) +
    ggplot2::labs(caption = caption)
}
