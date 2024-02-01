Extension {
	#name : 'Boolean'
}

{ #category : '*SortFunctions-Core' }
Boolean >> threeWayCompareTo: anotherObject [
	^ self asInteger threeWayCompareTo: anotherObject asInteger
]
