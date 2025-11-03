use context dcic2024

data TaxonomyTree:
    node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

# Example: Part of the cat family
lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])

house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])


felidae = node("Family", "Felidae", [list: panthera, felis])

fun is-leaf(t :: TaxonomyTree) -> Boolean:
  is-empty(t.children)
where:
  is-leaf(house-cat) is true
  is-leaf(felis) is false
end

fun count-nodes(t :: TaxonomyTree) -> Number:
  1 + count-nodes-children(t.children)
where:
  count-nodes(lion) is 1
  count-nodes(panthera) is 4
  count-nodes(felis) is 3
end

fun count-nodes-children(c :: List<TaxonomyTree>) -> Number:
  cases(List) c:
    | empty => 0
    | link(f, r) => count-nodes(f) + count-nodes-children(r)
  end
end

# Uses recursion and checks if the rank of each child is = to children
fun get-rank(c :: List<TaxonomyTree>) -> Number:
  cases(List) c:
    | empty => 0
    | link(f, r) => if (f.rank == "Species"): 1 + get-rank(r) else: get-rank(r) end
  end
end

# Just passes through .children so you dont have to add it to the end of the function
fun count-species(t :: TaxonomyTree) -> Number block:
  get-rank(t.children)
end


count-species(panthera)

# Literally the same as the last functions but it lets the user specify the rank
fun get-rank-new(c :: List<TaxonomyTree>, rank :: String) -> Number:
  cases(List) c:
    | empty => 0
    | link(f, r) => if (f.rank == rank): 1 + get-rank-new(r, rank) else: get-rank-new(r, rank) end
  end
end


fun count-rank(t :: TaxonomyTree, rank :: String) -> Number:
  get-rank-new(t.children, rank)
end

count-rank(felidae, "Genus")



fun all-names(c :: List<TaxonomyTree>, a :: List):
  cases(List) c:
    | empty => [list: ""]
    | link(f, r) => a.append([list: f.name]) + all-names(r, a)
  end
end

fun all-names-list(r :: TaxonomyTree) -> List:
  a = [list: ""]
  all-names(r.children, a)
end

all-names-list(panthera)

# fun taxon-height(t :: List<TaxonomyTree>) -> Number:
#   cases(List) t:
#     | empty => 0
#     | link(f, r) => if (f.children.length() > 0): 1 + taxon-height(r) else: taxon-height(r) end
# end
# end

# fun pass(t :: TaxonomyTree):
#   taxon-height(t.children)
# end

# pass(felis)

# felis.children.length()