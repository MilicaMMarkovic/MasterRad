as yet unclassified
processArray2: array2d numberOfElements: aNumber
	| k r niz me numberOfExc red se sc |
	k := 1.
	r := 1.
	niz := OrderedCollection new.
	me := ModelElement new.
	numberOfExc := me
		numberOfElementsInExclusive: array2d
		aNumber: aNumber.
	red := array2d at: r at: k.
	red isNil
		ifFalse: [ 
			(((array2d at: r at: k) findTokens: '"') at: 2) = 'A StartEvent'
						ifTrue: [ 
							se := NWStartEvent new.
							se description: (((array2d at: r at: k+1) findTokens: '"') at: 2).
							niz add: se. ].
			(((array2d at: r at: k) findTokens: '"') at: 2) = 'A ScriptTask'
						ifTrue: [ 
							sc := NWScriptTask new.
							sc description: (((array2d at: r at: k+1) findTokens: '"') at: 2).
							sc script: [ (((array2d at: r at: k+2) findTokens: '"') at: 2) ].
							niz add: sc.
							"(niz at: (i - 1)) addOutgoingEdge: sc." ].
			 ]
		ifTrue: [ r := r + 1.
			k := 1 ].
	^ niz.