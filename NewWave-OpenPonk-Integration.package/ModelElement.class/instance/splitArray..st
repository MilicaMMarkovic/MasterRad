as yet unclassified
splitArray: stringArray 
	| arrayOfArrays |
	arrayOfArrays  := ''.
	2 to: (stringArray size - 1) do: [ :i |
		  (stringArray at: i) = ''
		ifTrue: [  ]
		ifFalse: [  ]
		].
	^ arrayOfArrays.