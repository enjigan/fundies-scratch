use context starter2024
data TaxonomyTree:
  node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])
house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])
felidae = node("Family", "Felidae", [list: panthera, felis])

# Takes a TaxonomyTree and counts the number of nodes with the rank Species.
fun count-species(t :: TaxonomyTree) -> Number:
  cases (TaxonomyTree) t:
    | node(rank, name, children) =>
        if rank == "Species":
          1 + count-species-children(children)
        else:
          count-species-children(children)
      end
  end
end

fun count-species-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
        count-species(first) + count-species-children(rest)
  end
end

check:
  count-species(lion) is 1
  count-species(panthera) is 3
  count-species(felis) is 2
  count-species(felidae) is 5
end