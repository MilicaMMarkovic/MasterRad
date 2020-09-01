as yet unclassified
processArray: array2d numberOfElements: aNumber
	| k r red se sc exclusive bt1 ee niz bt2 me numberOfExc |
	k := 1.
	r := 1.
	niz := OrderedDictionary new: aNumber .
	me := ModelElement new.
	numberOfExc := me numberOfElementsInExclusive: array2d aNumber: aNumber.
	1 to: aNumber do: [ :i | 
		1 to: aNumber do: [ :j | 
			red := array2d at: i at: j.
			red isNil
				ifFalse:
					[ "Pozvati instance klasa, drugi red desc i u zavisnosti sta je sta sledeci atributi"
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A StartEvent'
						ifTrue: [ se := NWStartEvent new.
							se description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							niz at:1 put: se. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A ScriptTask'
						ifTrue: [ sc := NWScriptTask new.
							sc description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							sc script: [ (((array2d at: i at: 3) findTokens: '"') at: 2) ].
							niz at:i put: sc.
							(niz at: (i - 1)) addOutgoingEdge: sc. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'An Exclusive'
						ifTrue: [ exclusive := NWExclusive new.
							exclusive description: 'Exclusive'.
							niz at:i put: exclusive.
							(niz at: (i - 1)) addOutgoingEdge: exclusive. 
							].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A BaseTask 1'
						ifTrue: [ bt1 := NWBaseTask new.
							bt1 description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							bt1 value: (((array2d at: i at: 3) findTokens: '"') at: 2).
							niz at: i put: bt1. 
							(niz at:(i-1))=exclusive 
							ifTrue: [ exclusive addOutgoingEdge: bt1 withCondition: (((array2d at: (i-1) at: 2) findTokens: '"') at: 2). Transcript show:'Jeste exclusive prethodni';cr. ].
							"Ovde treba ispitati da li je Exclusive prethodni element u procesu"
							 ]
							ifFalse: [ Transcript show:'nije dobro';cr. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A BaseTask 2'
						ifTrue: [ bt2 := NWBaseTask new.
							bt2 description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							bt2 value: (((array2d at: i at: 3) findTokens: '"') at: 2).
							"Posto je exclusive, treba ispitati"
							niz at:i put: bt2. 
							(niz at:(i-2))=exclusive 
								ifTrue: [ exclusive addOutgoingEdge: bt2 withCondition: (((array2d at: (i-2) at: 4) findTokens: '"') at: 2). Transcript show:'Jeste exclusive pre 2 elementa';cr. ]
								ifFalse: [ (niz at: (i-2)) addOutgoingEdge: bt2 withCondition: [ :x | (((array2d at: i - 2 at: 4) findTokens: '"') at: 2) ]. 
							(niz at: (i-1)) addOutgoingEdge: bt1 withCondition: [ :x | (((array2d at: i - 1 at: 2) findTokens: '"') at: 2) ]. ] ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'An EndEvent'
						ifTrue: [ ee := NWEndEvent new. 
							ee description: 'End'.
							(((array2d at: i - 3 at: 1) findTokens: '"') at: 2)
								= 'An Exclusive'
								ifTrue:
									[ 1 to: numberOfExc do: [ :x | (niz at: (i - x)) addOutgoingEdge: ee. ].
										Transcript show: 'ok' ;cr.
										"(niz at: (i-1)) addOutgoingEdge: ee.
										(niz at: (i-2)) addOutgoingEdge: ee."
									Transcript show: 'Jeste exclusive pre 3 elementa';cr. ]
								ifFalse: [ Transcript show: 0;
										cr ].
							niz at:i put: ee. 
							"(niz at: (i-1)) addOutgoingEdge: ee.
							(niz at: (i-2)) addOutgoingEdge: ee. " ].
					]
				ifTrue: [ "r := r + 1." k := 1 ] ] ].
	^ niz.