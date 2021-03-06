as yet unclassified
processArray2: array2d numberOfElements: aNumber array: anArray
	| k r niz se sc ee exclusive bt1 bt2 receiver1 message1 result1 condition1 condition2 keyword1 argument1 receiver2 result2 receiver3 keyword2 argument2 result3 |
	k := 1.
	r := 1.
	niz := OrderedDictionary new.
	1 to: aNumber do: [ :e | 
		(anArray at: e) = 'A StartEvent'
			ifTrue: [ se := NWStartEvent new.
				se
					description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				niz at: e put: se.
				k := 1.
				r := r + 1 ].
		(anArray at: e) = 'A ScriptTask'
			ifTrue: [ sc := NWScriptTask new.
				sc description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				receiver1:=((((array2d at: r at:k+2) findTokens: '"')at:2 ) asInteger) .
				message1:=(((((array2d at: r at:k+2) findTokens: '"')at:2 ) findTokens: ' ')at:2)asSymbol .
				result1 := receiver1 perform: message1.
				sc script: [ result1 ] .
				niz at: e put: sc.
				k := 1.
				r := r + 1.
				(niz at: e - 1) addOutgoingEdge: sc ].
		(anArray at: e) = 'An Exclusive'
			ifTrue: [ exclusive := NWExclusive new.
				exclusive description: 'Exclusive'.
				niz at: e put: exclusive.
				condition1:=(((array2d at: r at: k + 1) findTokens: '"') at: 2).
				condition2:=(((array2d at: r at: k + 3) findTokens: '"') at: 2).
				k := 1.
				r := r + 1.
				(niz at: e - 1) addOutgoingEdge: exclusive ].
		(anArray at: e) = 'A BaseTask 1'
			ifTrue: [ bt1 := NWBaseTask new.
				bt1 description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				bt1 value: (((array2d at: r at: k + 2) findTokens: '"') at: 2).
				niz at: e put: bt1.
				receiver2:=sc script value.
				
				keyword1:=(((condition1 findTokens: 'x')at:1) copyFrom: 1 to: (condition1 size)-2) asSymbol.
				argument1 :=condition1 asInteger .
				result2 := receiver2 perform: keyword1 asSymbol withArguments: (Array with: argument1) .
				(niz at: e - 1) = exclusive
					ifTrue: [ exclusive addOutgoingEdge: bt1 withCondition: [ :x | result2  ] ]
					ifFalse: [ (niz at: e - 1) addOutgoingEdge: bt1 ].
				k := 1.
				r := r + 1 ].
		(anArray at: e) = 'A BaseTask 2'
			ifTrue: [ bt2 := NWBaseTask new.
				bt2 description: (((array2d at: r at: k + 1) findTokens: '"') at: 2).
				bt2 value: (((array2d at: r at: k + 2) findTokens: '"') at: 2).
				niz at: e put: bt2.
				receiver3:=sc script value.
				
				keyword2:=(((condition2 findTokens: 'x')at:1) copyFrom: 1 to: (condition2 size)-2) asSymbol.
				argument2 :=condition2 asInteger .
				result3 := receiver3 perform: keyword2 asSymbol withArguments: (Array with: argument2) .
				(niz at: e - 2) = exclusive
					ifTrue: [ exclusive addOutgoingEdge: bt2 withCondition: [ :x | result3 ] ]
					ifFalse: [ (niz at: e - 1) addOutgoingEdge: bt2 ].
				k := 1.
				r := r + 1 ].
		(anArray at: e) = 'An EndEvent'
			ifTrue: [ ee := NWEndEvent new.
				ee description: 'End'.
				niz at: e put: ee.
				(niz at: e - 3) = exclusive
					ifTrue: [ (niz at: e - 1) addOutgoingEdge: ee.
						(niz at: e - 2) addOutgoingEdge: ee ]
					ifFalse: [ (niz at: e - 1) addOutgoingEdge: ee ].
				k := 1.
				r := r + 1 ] ].
	^ niz