as yet unclassified
splitArray: stringArray numberOflementsDsl: aNumberOflementsDsl
	| arrayOfArrays j k red |
	arrayOfArrays := Array2D new: 10.
	"1 to: (arrayOfArrays size) do:
		[ :each | arrayOfArrays at: each put: (Array new: 10) ]."
	j := 1.	"brojac reda matrice"
	k := 1.	"brojac kolona matrice"
	2 to: (stringArray size - 1) do: [ :i | 
		red := stringArray at: i.
		red = ''
			ifFalse: [ arrayOfArrays at: j at: k put:red  .
				k := k + 1. ]
			ifTrue: [ j := j + 1.
				k := 1. ] ].
	^ arrayOfArrays