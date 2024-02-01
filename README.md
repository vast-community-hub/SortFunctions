# SortFunctions for VAST Platform

## Introduction

SortFunctions provides a set of utility classes and extension methods that allow you to build composite sorting criteria using different collators without having to deal with complex block nesting and logic.


## Examples
It enables you to perform sorting as follows:
```smalltalk

"Sort people by lastName and then by firstName"
people sorted: #lastName ascending, #firstName descending.

"Convert the employees collection into a sorted collection
sorting elements by its salary, and then by its supervisor,
placing the employees without supervisor at the end (similar to SQL's NULLS LAST)."

employees asSortedCollection: #salary descending, [:each | each supervisor ] ascending undefinedLast

"Sort by salary and then whether each employee has a bonus."
employees asSortedCollection: #salary descending, #hasBonus asSortFunction
```

## Installation

### Using Tonel Support
Clone this repository in your local filesystem, load the `ST: Tonel Support` and `ST: SUnit` features in VAST 12 or newer, and then evaluate: 

```smalltalk
| loader |
loader := TonelLoader readFromPath: (CfsPath named: 'path-to-cloned-repo').
loader
	beUnattended;
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
```
We provide convenience scripts for this in the `scripts` directory, both for importing from a Tonel repository and exporting to it.

### Using exported binary apps

Load the `ST: SUnit` feature and then import and load the `SortFunctions` configuration map in the `envy\SortFunctions.dat` file in this repository.

## Main concepts

### Three way comparison
Collation is performed by means of doing a [three way comparison](https://en.wikipedia.org/wiki/Three-way_comparison) where if an _objectA_ is less than _objectB_  the comparison will return -1, if they're equal it will return 0 and if _objectB_ is greater than _objectA_ it will return 1.

If you want to be able to compare objects within sort functions they need to be able to respond to the `#threeWayCompareTo:` message using the criteria described above.

### Helper methods
Usually you don't have to instantiate these classes manually, and you create the different sort functions by means of sending `#ascending`, `#descending` or `#asSortFunction` (that is a synonym of `#ascending`) to either a `Symbol` or to a `Block`. These methods will return an instance of `PropertySortFunction`, which then you can chain with other sort functions by means of the `#,` message (this will instantiate a `ChainedSortFunction`), and then wrap them using a `#reverse` function and/or define the order for elements that peroperties that return `nil` using the `#undefinedFirst` or `#undefinedLast` messages.

### Sort Functions as sort blocks
You can use a sort function, either a simple one, or a composed one as replacement for a `SortedCollection` sort block, as `SortFunction` implements the `#value:value:` method, making it polymorphic with a block.

If you convert a two-args block into a sort function (e.g. `[:a :b | a <= b] asSortFunction`) it will instantiate `CollatorBlockFunction` that will use the block as a collation function instead of performing a three way comparison.

## Further reading

See the `SortFunctionTest` SUnit class to see the different combinations you can use.

## History

The original concept was written by [written by Travis Griggs](https://objology.blogspot.com/2010/11/tag-sortfunctions.html) and then ported to Pharo first by [Nicolas Cellier](https://github.com/nicolas-cellier-aka-nice) and then ported again by Esteban A. Maringolo, who added tests and some other sort functions.

When SortFunctions became part of the Pharo kernel, it received some curation and modifications, most notably the replacement of the _"spaceship operator"_ `<=>` selector with the `#threeWayCompareTo:` keyword selector.
