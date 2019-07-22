### DT {data-width=200}

```{r}
output$hot = renderRHandsontable({
  rhandsontable(new_df(), height = 550) %>%  hot_rows()
})
rHandsontableOutput("hot") 