use context starter2024
# fun choose-hat(temp-in-C :: Number) -> String:
#   doc: "This function determines the appropriate head gear, with above 27C a sun hat, below nothing"
  
#   if temp-in-C > 27:
#     "sun hat"
#   else if temp-in-C < 10:
#     "winter hat"
#   else:
#     "nothing"
#   end
  
# end

fun choose-hat(temp-in-C :: Number) -> String:
  doc: "This function determines the appropriate head gear, with above 27C a sun hat, below nothing"
  
  ask:
    | temp-in-C > 27 then: "sun hat" 
    | temp-in-C < 10 then: "winter hat" 
    | otherwise: "nothing"
  end
end


fun add-glasses(outfit :: String) -> String:
  doc: "adds glasses to any outfit"
  "add glasses"
end

fun choose-hat-or-visor(temp-in-C :: Number, has-visor :: Boolean) -> String:
  doc: "This function determines the appropriate head gear, with above 27C a sun hat, below nothing. Also if above 30C and the person has  visor they will wear that"
  
  if (temp-in-C > 30) and (has-visor):
    "sun hat with visor"
  else if temp-in-C > 27:
    "sun hat"
  else if temp-in-C < 10:
    "winter hat"
  else:
    "nothing"
  end
  
end



choose-hat(29)
choose-hat(15)
choose-hat(5)
choose-hat-or-visor(35, true)

check:
  choose-hat(29) is "sun hat"
  choose-hat(15) is "nothing"
  choose-hat(5) is "winter hat"
  choose-hat-or-visor(35, true) is "sun hat with visor"
  choose-hat-or-visor(35, false) is "sun hat"
end