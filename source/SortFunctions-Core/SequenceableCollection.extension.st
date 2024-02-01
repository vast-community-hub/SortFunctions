Extension {
	#name : 'SequenceableCollection'
}

{ #category : 'ES-Portability' }
SequenceableCollection >> isSortedBy: aBlock [
	"Return true if the receiver is sorted by the given criterion."
	"(#(1 2 3) isSortedBy: [:a :b | a <= b ]) >>> true"
	"(#(1 2 3) isSortedBy: [:a :b | a >= b ]) >>> false"
	"(#(xa xc xz xb xy) isSortedBy: #last ascending) >>> false"
	"(#(xa xb xc xy xz) isSortedBy: #last ascending) >>> true"

	| lastElm elm |
	self isEmpty ifTrue: [^ true].
	lastElm := self first.
	2 to: self size do:
		[:index |
		elm := self at: index.
		(aBlock value: lastElm value: elm) ifFalse: [^ false].
		lastElm := elm].
	^ true
]
