use context starter2024

data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end

# example
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)

# merge points (nodes with two children)
merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

fun total-flow(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => total-flow(left) + total-flow(right)
    | stream(flow) => flow
  end
  
where: 
  total-flow(stream-a) is 5
  total-flow(main-river) is 16
end


# count merges
fun count-merges(r :: River) -> Number:
  cases(River) r:
    | merge(width, left, right) => 1 + count-merges(left) + count-merges(right)
    | stream(flow) => 0
  end
  
where:
  count-merges(stream-a) is 0
  count-merges(main-river) is 2
end

# design a function count-streams which counts how many individual streams feed into a river network

fun count-streams(r :: River) -> Number:
  cases(River) r:
    | merge(width, left, right) => count-streams(left) + count-streams(right)
    | stream(flow) => 1
  end
  
where:
  count-streams(merge-1) is 2
  count-streams(main-river) is 3
end

fun max-width(r :: River) -> Number:
  cases(River) r:
    | merge(width, left, right) => num-max(width, num-max(max-width(left), max-width(right)))
    | stream(flow) => 0
  end
where:
  max-width(main-river) is 15
  max-width(merge-1) is 12
end

fun widen-river(r, wider):
  doc: "returns a new network where every merge point is increased by wider"
  cases(River) r:
    | merge(w, left, right) =>
      merge(
        w + wider,
        widen-river(left, wider),
        widen-river(right, wider))
    | stream(f) => stream(f)
  end
where:
  widen-river(main-river, 10).width is 25
  widen-river(main-river, 10).left.width is 22
end