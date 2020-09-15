as yet unclassified
splitArray: stringArray numberOflementsDsl: aNumberOflementsDsl
	| arrayOfArrays j k red |
	arrayOfArrays := Array2D new: aNumberOflementsDsl.
	j := 1.	"row"
	k := 1.	"column"
	2 to: stringArray size - 1 do: [ :i | 
		red := stringArray at: i.
		red = ''
			ifFalse: [ arrayOfArrays at: j at: k put: red.
				k := k + 1. ]
			ifTrue: [ j := j + 1.
				k := 1. ] ].
	^ arrayOfArrays.
