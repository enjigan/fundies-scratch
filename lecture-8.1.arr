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

# Takes a TaxonomyTree and a rank string that returns the number of nodes with that rank.
fun count-rank(t :: TaxonomyTree, target-rank :: String) -> Number:
  cases (TaxonomyTree) t:
    | node(rank, name, children) =>
        if rank == target-rank:
          1 + count-rank-children(children, target-rank)
        else:
          count-rank-children(children, target-rank)
        end
  end
end

fun count-rank-children(c :: List<TaxonomyTree>, target-rank :: String) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
        count-rank(first, target-rank) + count-rank-children(rest, target-rank)
  end
end

check:
  count-rank(felidae, "Species") is 5
  count-rank(felidae, "Genus") is 2
  count-rank(felidae, "Family") is 1
  count-rank(panthera, "Species") is 3
  count-rank(panthera, "Genus") is 1
end

# Returns the number of levels in the TaxonomyTree.
fun taxon-height(t :: TaxonomyTree) -> Number: 
   cases (TaxonomyTree) t:
    | node(rank, name, children) =>
        1 + taxon-height-children(children)
  end
end

fun taxon-height-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
        num-max(taxon-height(first), taxon-height-children(rest))
  end
end

check:
  taxon-height(lion) is 1        
  taxon-height(panthera) is 2    
  taxon-height(felis) is 2
  taxon-height(felidae) is 3  
end

# Returns a list of all names in the TaxonomyTree (duplicates are okay). You'll need an all-names and all-names-list functions.
fun all-names(t :: TaxonomyTree) -> List<String>:
  cases (TaxonomyTree) t:
    | node(rank, name, children) =>
        append([list: name], all-names-list(children))
  end
end

fun all-names-list(c :: List<TaxonomyTree>) -> List<String>:
  cases (List) c:
    | empty => [list:]
    | link(first, rest) =>
        append(all-names(first), all-names-list(rest))
  end
end

check:
  all-names(lion) is [list: "Panthera leo"]
  all-names(panthera) is [list: "Panthera", "Panthera leo", "Panthera tigris", "Panthera pardus"]
  all-names(felis) is [list: "Felis", "Felis catus", "Felis silvestris"]
  all-names(felidae) is
    [list:
      "Felidae",
      "Panthera", "Panthera leo", "Panthera tigris", "Panthera pardus",
      "Felis", "Felis catus", "Felis silvestris"]
end