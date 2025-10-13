use context dcic2024
include csv
include data-source

dat = load-table:
  rownames, 
  dep_time, 
  sched_dep_time, 
  dep_delay, 
  arr_time, 
  sched_arr_time, 
  arr_delay, 
  carrier, 
  flight, 
  tailnum :: String, 
  origin, 
  dest, 
  air_time, 
  distance, 
  hour, 
  minute, 
  time_hour
  source: csv-table-file("flights_sample53.csv", default-options)
  sanitize dep_delay using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize air_time using num-sanitizer
end


# Task Plan
# Problem: There are empty values in tailnum
# Planned Step: Replace all empty values with the string "Unknown"
# Implementation: Use the transform-column function to check if there are string values with a length < 0


# Using a lam function to replace all empty strings to Unknown
tailnumsFixed = transform-column(dat, "tailnum", lam(s :: String): if (string-length(s) == 0): "UNKNOWN" else: s end end)



# Checking for all valuse < 0 in dep and arr delay
delayTimesFixed = transform-column(tailnumsFixed, "dep_delay", lam(n :: Number): if (n < 0): 0 else: n end end)

timesFixed = transform-column(delayTimesFixed, "arr_delay", lam(n :: Number): if (n < 0): 0 else: n end end)

# Identifying duplicate rows

# First Step: Converting flights to string
# Since it is not sanitized, it is a string

# Second Step: Normalizing the characters

carriersSpace = transform-column(timesFixed, "carrier", lam(s :: String): string-replace(s, " ", "") end)

carriersFixed = transform-column(carriersSpace, "carrier", lam(s :: String): string-to-upper(s) end)


# Third Step: Fixing dep_time to fit HH:MM

# Making sure all has a length of 4
timeLengthFixed = transform-column(carriersFixed, "dep_time", lam(s :: String): if (string-length(s) == 3): "0" + s else: s end end)


# Adding a :
depTimesFixed = transform-column(timeLengthFixed, "dep_time", lam(s :: String): string-substring(s, 0, 2) + ":" + string-substring(s, 2, string-length(s)) end)

# Building the key column
dedupkey = build-column(depTimesFixed, "dedup_key", lam(r :: Row): r["flight"] + "-" + r["carrier"] + "-" + r["dep_time"] end)

# Grouping and counting the keys
group(dedupkey, "dedup_key")

count(dedupkey, "dedup_key")


# # Creating a frequency bar chart by carrier
# freq-bar-chart(dedupkey, "carrier")

# # Creating a histogram
# histogram(dedupkey, "distance", 500)

# # Creating a scatter plot
# scatter-plot(dedupkey, "air_time", "distance")

distanceList = dedupkey.get-column("distance")

# Sums the distances
fun distanceSum(l :: List) -> Number block:
  var total = 0
  for each(n from l):
    total := total + n
  end
  total
end

# Finds the Average Distance
fun avgDistance(l :: List) -> Number block:
  var total = 0
  for each(n from l):
    total := total + n
  end
  total / l.length()
end

# Finds the Max Distance
fun maxDistance(l :: List) -> Number block:
  var max = 0
  for each(n from l):
    if (n > max):
      max := n
    else:
      max := max
    end
  end
  max
end

distanceSum(distanceList)
avgDistance(distanceList)
maxDistance(distanceList)