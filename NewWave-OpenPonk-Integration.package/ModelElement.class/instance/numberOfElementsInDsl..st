as yet unclassified
numberOfElementsInDsl: stringArray
			
	| numberOfElements |
	numberOfElements := 0.
	2 to: (stringArray size-1) do: [ :i |
		(stringArray at: i) = ''
			ifTrue: [ numberOfElements := numberOfElements + 1. ] ].
	numberOfElements := numberOfElements + 1. 
	^ numberOfElements .