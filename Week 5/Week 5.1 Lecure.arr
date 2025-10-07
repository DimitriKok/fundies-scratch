use context dcic2024
include csv
include data-source

voter-data =
  load-table: VoterID,DOB,Party,Address,City,County,Postcode
    source: csv-table-file("voters.csv", default-options)
end

# voter-data

filter-with(voter-data, lam(r): r["Party"] == "Labour" end).length()
# 4

voter-data.row-n(3)["Party"]

fun blank-to-undecided(s :: String) -> String:
  doc: "replaces an empty string with Undecided"
  if s == "":
    "Undecided"
  else:
    s
  end
where:
  blank-to-undecided("") is "Undecided"
  blank-to-undecided("blah") is "blah"
end

undecided-voters = transform-column(voter-data, "Party", blank-to-undecided)

undecided-voters

# freq-bar-chart(undecided-voters, "Party")


fun normalize-data(s :: String):
  doc: "Normalizes the date of the table"
  # Create a new string that takes seperate substrings and adds them together
  
  # Use the String-replace method to change the / to -
  newString = string-substring(s, 6, 10) + string-substring(s, 2, 6) + string-substring(s, 0, 2)
  
  string-replace(newString, "/", "-")
end

normalized = transform-column(undecided-voters, "DOB", normalize-data)

fun normalize-postcode(s :: String):
  
  # Remove all spaces
  
  # Get the last 3 letters of the sub string, add a space before it then add the first letters up to the last 3 letters
  
  # Make all uppercase
  
  
  noSpace = string-replace(s, " ", "")
  
  fourLetts = string-substring(noSpace, 0, string-length(noSpace) - 3) + " " + string-substring(noSpace, (string-length(noSpace) - 3), string-length(noSpace))
  
  upper = string-to-upper(fourLetts)
  
  upper
end

Post = transform-column(normalized, "Postcode", normalize-postcode)

Post