use context dcic2024
include csv
include data-source


items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

items

fun subtract-1(n :: Number) -> Number:
  doc: "Subtracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

moved-items = transform-column(items, "x-coordinate", subtract-1)

moved-items

fun calc-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-sqrt(
    num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]))
where:
  calc-distance(items.row-n(0)) is-roughly
    num-sqrt(num-sqr(23) + num-sqr(-87))
      
  calc-distance(items.row-n(3)) is-roughly
    num-sqrt(num-sqr(-9) + num-sqr(64))
end

items-with-dist = build-column(items, "distance", calc-distance)

items-with-dist

fun pull-closer(n :: Number) -> Number:
  doc: "Multiplies coordinates by 0.9 to pull 10% closer to origin"
  n * 0.9
where:
  pull-closer(10) is 9
end

#Apply transformation to both x and y coordinates
items-pulled-closer = transform-column(transform-column(items, "x-coordinate", pull-closer), "y-coordinate", pull-closer)

items-pulled-closer

fun hide-name(r :: String) -> String:
  string-repeat("X", string-length(r))
end


items-hidden = transform-column(items, "item", hide-name)

items-hidden

cpi = load-table:
  code :: String,
  indicies :: String,
  Aug-24 :: Number,
  Sep-2 :: Number,
  Oct-24 :: Number,
  Nov-24 :: Number,
  Dec-24 :: Number,
  Jan-25 :: Number,
  Feb-25 :: Number,
  Mar-25 :: Number,
  Apr-25 :: Number,
  May-25 :: Number,
  Jun-25 :: Number,
  Jul-25 :: Number,
  Aug-25 :: Number
  source: csv-table-file("ons-cpih-aug25.csv", default-options)
  sanitize Aug-24 using num-sanitizer
  sanitize Sep-2 using num-sanitizer
  sanitize Oct-24 using num-sanitizer
  sanitize Nov-24 using num-sanitizer
  sanitize Dec-24 using num-sanitizer
  sanitize Jan-25 using num-sanitizer
  sanitize Feb-25 using num-sanitizer
  sanitize Mar-25 using num-sanitizer
  sanitize Apr-25 using num-sanitizer
  sanitize May-25 using num-sanitizer
  sanitize Jun-25 using num-sanitizer
  sanitize Jul-25 using num-sanitizer
  sanitize Aug-25 using num-sanitizer
end

cpi

fun difference(r :: Row):
  if (r["Aug-24"] > r["Aug-25"]):
    r["Aug-24"] - r["Aug-25"]
  else:
    r["Aug-25"] - r["Aug-24"]
  end
end

cpi-with-difference = build-column(cpi, "Difference", difference)

cpi-with-difference

fun pct-difference(r :: Row):
  num-floor(((r["Aug-25"] - r["Aug-24"]) / ((r["Aug-25"] + r["Aug-24"]) / 2)) * 100

end


cpi-with-pct = build-column(cpi, "PCT", pct-difference)

order-by(cpi-with-pct, "PCT", false)


