as yet unclassified
numberOfElementsInExclusive: array2d aNumber: aNumberOfElements
	| numberElements red |
	numberElements := 0.
	1 to: aNumberOfElements do: [ :i | 
		1 to: aNumberOfElements do: [ :j | 
			red := array2d at: i at: j.
			red isNil
				ifFalse: [ ((red findTokens: '"') at: 1) = '		condition '
						ifTrue: [ numberElements := numberElements + 1 ] ]
				ifTrue: [ numberElements := numberElements ] ] ].
	^ numberElements