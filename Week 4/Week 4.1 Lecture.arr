use context dcic2024
include csv
include data-source

#Creates a table for orders, has amount and time
orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

#function that returns if the amount is greater than 8
fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.0
end

#Tests the function
is-high-value(orders.row-n(0))

#Filters the table, uses a first class function as a way to do without previously written function
filter-with(orders, lam(o): o["amount"] >= 8.0 end)


#Function that checks if orders is in the morning
fun is-morning(o :: Row) -> Boolean:
  o["time"] < "12:00"
end

#Tests the function
is-morning(orders.row-n(0))

#filters the table to time before 12
filter-with(orders, lam(o): o["time"] < "12:00" end)


#Loads a new table from a url
photos = load-table:
  Forest :: String,
  Location :: String,
  Date :: String
  source: csv-table-url("https://pdi.run/f25-2000-photos.csv", default-options)
end

#Sorts the table by earliest to latest
order-by(orders, "time", true)

#sorts the table by date
order-by(photos, "Date", true)

#sorts the table by the count of each location, high to low
order-by(count(photos, "Location"), "count", false)

#creates a bar chart by location
freq-bar-chart(photos, "Location")