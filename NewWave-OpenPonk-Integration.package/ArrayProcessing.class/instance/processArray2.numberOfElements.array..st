as yet unclassified
processArray2: array2d numberOfElements: aNumber array: anArray
	| k r niz se sc ee exclusive bt1 bt2 |
	k := 1.
	r := 1.
	niz := OrderedDictionary new.
	1 to: aNumber do: [ :e | 
		(anArray at: e) = 'A StartEvent'
			ifTrue: [ se := NWStartEvent new.
				se description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				niz at: e put: se.
				k := 1.
				r := r + 1 ].
		(anArray at: e) = 'A ScriptTask'
			ifTrue: [ sc := NWScriptTask new.
				sc description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				sc script: [ 10 atRandom ].
				niz at: e put: sc.
				k := 1.
				r := r + 1.
				(niz at: e - 1) addOutgoingEdge: sc ].
		(anArray at: e) = 'An Exclusive'
			ifTrue: [ exclusive := NWExclusive new.
				exclusive description: 'Exclusive'.
				niz at: e put: exclusive.
				k := 1.
				r := r + 1.
				(niz at: e - 1) addOutgoingEdge: exclusive ].
		(anArray at: e) = 'A BaseTask 1'
			ifTrue: [ bt1 := NWBaseTask new.
				bt1 description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				bt1 value: (((array2d at: r at: k + 2) findTokens: '"') at: 2).
				niz at: e put: bt1.
				(niz at: e - 1) = exclusive
					ifTrue: [ exclusive addOutgoingEdge: bt1 withCondition: [ :x | x >= 5 ].
						Transcript show: 'Jeste exclusive prethodni'; cr ]
					ifFalse: [ (niz at: e - 1) addOutgoingEdge: bt1 ].
				k := 1.
				r := r + 1 ].
		(anArray at: e) = 'A BaseTask 2'
			ifTrue: [ bt2 := NWBaseTask new.
				bt2 description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				bt2 value: (((array2d at: r at: k + 2) findTokens: '"') at: 2).
				niz at: e put: bt2.
				(niz at: e - 2) = exclusive
					ifTrue: [ exclusive addOutgoingEdge: bt2 withCondition: [ :x | x < 5 ].
						Transcript show: 'Jeste exclusive prethodni'; cr ]
					ifFalse: [ (niz at: e - 1) addOutgoingEdge: bt2 ].
				k := 1.
				r := r + 1 ].
		(anArray at: e) = 'An EndEvent'
			ifTrue: [ ee := NWEndEvent new.
				ee description: 'End'.
				niz at: e put: ee.
				(niz at: e - 3) = exclusive
					ifTrue: [ (niz at: e - 1) addOutgoingEdge: ee.
						(niz at: e - 2) addOutgoingEdge: ee.
						Transcript show: 'Jeste exclusive pre 3 elementa'; cr ]
					ifFalse: [ (niz at: e - 1) addOutgoingEdge: ee ].
				k := 1.
				r := r + 1.
				"(niz at: e - 1) addOutgoingEdge: ee. " ] ].
	"Dodat flow, fali deo sa ispiivanjem exclusive: condition i gde ide"
	^ niz