Extension {
	#name : 'UnicodeString'
}

{ #category : 'Not categorized' }
UnicodeString class >> compare: string1 with: string2 collated: order [
	"Return 1, 2 or 3, if string1 is <, =, or > string2, 
	 with the collating order of characters given by the order array."

	string1 asUnicodeString < string2 asUnicodeString ifTrue: [^1].
	string1 asUnicodeString > string2 asUnicodeString ifTrue: [^3].
	^2
]

{ #category : 'Not categorized' }
UnicodeString >> compare: string1 with: string2 collated: order [

	^UnicodeString compare: string1 asUnicodeString with: string2 asUnicodeString collated: order
]

{ #category : 'Not categorized' }
UnicodeString >> threeWayCompareTo: aString [
	"Do a three-way comparison between the receiver and anotherObject, returning
	-1 if self < anotherObject
	0 if self = anotherObject
	1 if self > anotherObject
	This assumes a total order in accordance with the mathematical law of trichotomy.
	See also:  http://en.wikipedia.org/wiki/Three-way_comparison"

	 ^ (self compare: self with: aString collated: #()) - 2
]
