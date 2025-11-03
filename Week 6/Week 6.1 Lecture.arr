use context starter2024

data MobileRecord:
    phone(title :: String, model :: String, color :: String, storage :: Number)
end

phone-1 = phone("Iphone", "13 Pro", "Blue", 64)
phone-2 = phone("Iphone", "17 Pro", "Orange", 512)

phone-2.storage - phone-1.storage

fun costOfPhone(p :: MobileRecord) -> Number:
  basePrice = 500
  price-per-gb = 2
  basePrice + (p.storage * price-per-gb)
end

costOfPhone(phone-1)

fun computeCostCondition(p :: MobileRecord) -> Number:
  doc: "Compute phone cost based on storage, model, and color"
  
  # Base price depends on model
  base-price = if p.model == "13 Pro":
    799
  else if p.model == "14 Pro":
    999
  else if p.model == "17 Pro":
    1399
  else:
    699
  end
  
  # Storage
  storage-cost = if p.storage <= 64:
    0
  else if p.storage <= 128:
    100
  else if p.storage <= 256:
    200
  else if p.storage <= 512:
    400
  else:
    600
  end
  
  # Color
  color-cost = if (p.color == "Orange") or (p.color == "Blue"):
    150
  else:
    0
  end
  
  base-price + storage-cost + color-cost 
  
where:
  computeCostCondition(phone-1) is 949
  computeCostCondition(phone-2) is 1399 + 400 + 150
end



data Priority:
  | low
  | medium
  | high
end

task-1-priority = low
task-2-priority = high
task-3-priority = medium

check:
  is-Priority(task-1-priority) is true
  is-low(task-1-priority) is true
  is-high(task-2-priority) is true
end

data Task:
  | task(description :: String, priority :: Priority)
  | note(description :: String)
end

task-1 = task("Study for exams", high)
task-2 = task("Watch a series", low)
task-3 = task("Go for groceries", medium)
task-1-note = note("This is the note")

fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p) =>
      priority = cases (Priority) p:
        | low => "Low Task: "
        | medium => "Medium Task:  "
        | high => "High Task: "
  end
      priority + d
    | note(d) => d
  end
end

describe(task-3)
