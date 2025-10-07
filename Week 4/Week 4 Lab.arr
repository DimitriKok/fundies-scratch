use context dcic2024
include csv
include data-source

# importing a flights table
flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: String,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end
  

"Exercise 1"
# defining a predicate
fun is_long_flight(row :: Row) -> Boolean:
  doc: "Check if any column named 'distance' is greater than 1500"
  if (row["distance"] >= 1500):
    true
  else:
    false
  end
end

# filtering the table to only show flights >= 1500 then ordering it by air time in descending order
ordered_flights = order-by(filter-with(flights, is_long_flight), "air_time", false)

#Printing the carrier origin and dest of the flight with the highest air time
ordered_flights.row-n(0)["carrier"]

ordered_flights.row-n(0)["origin"]

ordered_flights.row-n(0)["dest"]


"Exercise 2"
# defining a predicate
fun is_delayed_departure(r :: Row) -> Boolean:
  doc: "Checks if there is departure delay over 30 mins"
  if (r["dep_delay"] >= 30):
    true
  else:
    false
  end
end


# defining a predicate
fun is_morning_sched_dep(r :: Row) -> Boolean:
  doc: "Checks if the departure time is in the morning"
  if (r["sched_dep_time"] < 1200):
    true
  else:
    false
  end
end

# filters table to show only flights with a delay using a lambda function
delayed_flights = filter-with(flights, lam(r :: Row): r["dep_delay"] >= 30 end)

# filters the delayed flights to only flights with a distance > 500. The orders by the worst departure delays
worst_delays = order-by(filter-with(delayed_flights, lam(r :: Row): r["distance"] > 500 end), "dep_delay", false)

# Prints the flight with the worst delay number, origin, and delay time
worst_delays.row-n(0)["flight"]

worst_delays.row-n(0)["origin"]

worst_delays.row-n(0)["dep_delay"]


"Exercise 3"

# Replacing flights with negative delay
no_neg_delay = transform-column(transform-column(flights, "dep_delay", lam(n :: Number): if n < 0: 0 else: n end end), "arr_delay", lam(n :: Number): if n < 0: 0 else: n end end)

# adds a effective speed column to the table
flights_with_speed = build-column(no_neg_delay, "effective_speed", lam(r :: Row): if r["air_time"] > 0: (r["distance"] / (r["air_time"] / 60)) else: r end end)

# Orders by fastest flight
flights_with_speed_ordered = order-by(flights_with_speed, "effective_speed", false)

# Prints the carrier, origin, and dest of the fastest flights
flights_with_speed_ordered.row-n(0)["carrier"]

flights_with_speed_ordered.row-n(0)["origin"]

flights_with_speed_ordered.row-n(0)["dest"]


"Exercise 4"

# Was not able to fully figure out, need help

# fun apply_arrival_discount(t :: Table) -> Table:
  
#   if (0 <= t["arr_delay"]) and (t["arr_delay"] < 45):
#     t["arr_delay"] * 0.8
#   else:
#     t["arr_delay"]
#   end
# end

# apply_arrival_discount(flights)

# flights_with_speed