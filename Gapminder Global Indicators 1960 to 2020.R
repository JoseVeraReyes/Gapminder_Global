library(plotly)
library(gapminder)
library(WDI)

indicator <- WDIsearch()
df <- WDI(indicator= c('NY.GDP.PCAP.CD','SP.DYN.LE00.IN','SP.POP.TOTL'),extra = TRUE)
df <- filter(df, df$region != 'Aggregates')
df <- rename(df, gdpPercap = NY.GDP.PCAP.CD, lifeExp =SP.DYN.LE00.IN, population =SP.POP.TOTL)

fig <- df %>%
  plot_ly(
    x = ~gdpPercap,
    y = ~lifeExp,
    size = ~population,
    marker = list(opacity = 0.5, sizemode = 'diameter'),
    color = ~region,
    frame = ~year,
    text = ~country,
    autorange=TRUE,
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers')%>% layout(title = list(text='Gapminder Global Indicators 1960 to 2020', y = 0.97, x = 0.5, xanchor = 'center', yanchor =  'top'))


fig <- fig %>% layout(
    xaxis = list(
      type = "log"
    )
  )


fig


htmlwidgets::saveWidget(
                widget = fig, #the plotly object
                file = "figure.html", #the path & file name
                selfcontained = TRUE #creates a single html file
                )


#Sys.setenv("plotly_username"="jverareyes96")
#Sys.setenv("plotly_api_key"="24wtqmzpxSMdlYpm9Zgn")
#api_create(fig,"Gapminder Global Indicators 1960 to 2020")


