install.packages("devtools")
install_github("ropensci/aRxiv")
install.packages("RSQLite")
library(tibble)

##Подключение библиотек
library(devtools)
library(aRxiv)
library(RSQLite)

##Получение поискового запроса из консоли
inquiry <- readline("Введите поисковый запрос...")

##Парсинг данных из архив
z <- arxiv_search(query = inquiry, limit=50)
str(z)

##Преобразование данных в data.frame
z <- as.data.frame(z)

##Добавление поискового запроса в data.frame
z <- add_column(z, inquiry, .after = 0)

##Подключение БД и запись данных в БД
con <- dbConnect(RSQLite:: SQLite(), "/db")
dbWriteTable(con, "Data_inquiry", z)
dbDisconnect(con)
paste("File uploaded successfully")

##Подключение базы данных и чтение таблицы
con <- dbConnect(RSQLite:: SQLite(), "/db")
data <- dbReadTable(con, "Data_inquiry")
