as yet unclassified
splitArray: stringArray numberOflementsDsl: aNumberOflementsDsl
	| arrayOfArrays |
	arrayOfArrays := Array new: (stringArray size).
	1 to: aNumberOflementsDsl do: [ :j | 
		2 to: stringArray size - 1 do: [ :i | 
			"arrayOfArrays add: (stringArray at: 1)"
			(arrayOfArrays at: i) = ''
				ifFalse: [ arrayOfArrays
						at: j
						put: ((Array new: (stringArray size)) at: i put: (stringArray at: i)) ]
				ifTrue: [  ] ] ].
	^ arrayOfArrays