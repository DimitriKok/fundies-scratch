use context starter2024

data SensorNet:
  | hub(bandwidth :: Number, left :: SensorNet, right :: SensorNet)
  | sensor(rate :: Number)
end

# Example network
sA = sensor(60)
sB = sensor(120)
sC = sensor(45)

# You can construct larger networks like:
hub1 = hub(150, sA, sB)
core = hub(200, hub1, sC)


fun total-load(n :: SensorNet) -> Number:
  doc: "Returns a sum of all the bandwitdths in a SensorHub Tree"
  
  cases(SensorNet) n:
    | hub(b, l, r) => total-load(l) + total-load(r)
    | sensor(s) => s
  end
  
where:
  total-load(core) is 225
end

total-load(core)

# Checks if there is a sensor or a hub
fun check-length(n :: SensorNet) -> Number:
  cases(SensorNet) n:
    | sensor(S) => 0
    | hub(b, l, r) => 1
  end
end

# Checks if the bandwith is greater than the sum of the bandwitdth of left and right
fun fits-capacities(n :: SensorNet) -> Boolean:
  cases(SensorNet) n:
    | sensor(s) => true
    | hub(b, l, r) => 
      if (check-length(l) == 0) and (check-length(r) == 0):
        if (b > (l.rate + r.rate)):
          true
        else:
          false
        end
      else if (check-length(l) == 1) and (check-length(r) == 0):
        if (b > (l.bandwidth + r.rate)):
          true
        else:
          false
        end
      else if (check-length(l) == 0) and (check-length(r) == 1):
        if (b > (l.rate + r.bandwidth)):
          true
        else:
          false
        end
      else if (check-length(l) == 1) and (check-length(r) == 1):
        if (b > (l.bandwidth + r.bandwidth)):
          true
        else:
          false
        end
      end
  end
where:
  fits-capacities(core) is true
end

fits-capacities(hub1)

fun deepest-depth(n :: SensorNet) -> Number:
  doc: "Returns the depth of the deepest sensor in a given SensorNet"
  cases(SensorNet) n:
    | sensor(s) => 0
    | hub(b, l, r) => num-max(1 + (deepest-depth(l)), (1 + deepest-depth(r)))
  end
end

deepest-depth(core)

fun apply-scale(n :: SensorNet, s :: Number) -> SensorNet:
  doc: "Divides the bandwidth of a SensorNet object by s"
  cases(SensorNet) n block:
    | sensor(w) => sensor(w / s)
    | hub(b, l, r) => 
      hub(b / s,
        apply-scale(l, s),
        apply-scale(r, s))
  end
where:
  apply-scale(core, 2).bandwidth is 100
end

apply-scale(core, 1.2)


fun needed-scale(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate)  => 1
    | hub(bw, l, r) =>
      block:
        load = total-load(l) + total-load(r)
        here = load / bw
        num-max( num-max(here, needed-scale(l)), needed-scale(r) )
      end
  end
where:
  # For 'core': max(225/200 = 1.125, hub1: 180/150 = 1.2) = 1.2
  needed-scale(core) is 1.2
end

fun scale-to-fit(n :: SensorNet) -> SensorNet:
  doc: "If a SensorNet Object needs a scale to fit, it will be applied using previous functions"
  cases(SensorNet) n:
    | sensor(rate) => sensor(rate)
    | hub(b, l, r) =>
      if (needed-scale(n) <= 1):
        hub(b, l, r)
      else:
        apply-scale(n, needed-scale(n))
      end
  end
where:
  fits-capacities(scale-to-fit(core)) is true
  total-load(scale-to-fit(core)) is total-load(core) / needed-scale(core)
end

scale-to-fit(core)