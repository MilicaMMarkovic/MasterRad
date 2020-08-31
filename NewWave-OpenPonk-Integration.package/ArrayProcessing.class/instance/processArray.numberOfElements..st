as yet unclassified
processArray: array2d numberOfElements: aNumber
	| k r red se nextElement sc exclusive condition1 nextElement1 condition2 nextElement2 previous bt1 ee previous1 previous2 niz bt2 me numberOfExc condition |
	k := 1.
	r := 1.
	niz := Array new: aNumber.
	me := ModelElement new.
	numberOfExc := me
		numberOfElementsInExclusive: array2d
		aNumber: aNumber.
	Transcript
		show: numberOfExc;
		cr.
	1 to: aNumber do: [ :i | 
		1 to: aNumber do: [ :j | 
			red := array2d at: i at: j.
			red isNil
				ifFalse:
					[ "Pozvati instance klasa, drugi red desc i u zavisnosti sta je sta sledeci atributi"
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A StartEvent'
						ifTrue: [ se := NWStartEvent new.
							se description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							nextElement := ((array2d at: i at: 3) findTokens: '"') at: 2.
							niz at: i put: se. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A ScriptTask'
						ifTrue: [ sc := NWScriptTask new.
							sc description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							sc script: [ (((array2d at: i at: 2) findTokens: '"') at: 2) ].
							previous := ((array2d at: i - 1 at: 1) findTokens: '"') at: 2.	"prethodni"
							nextElement := ((array2d at: i at: 4) findTokens: '"') at: 2.
							niz at: i put: sc.
							(niz at: (i - 1)) addOutgoingEdge: sc. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'An Exclusive'
						ifTrue: [ exclusive := NWExclusive new.
							exclusive description: 'Exclusive'.
							previous := ((array2d at: i - 1 at: 1) findTokens: '"') at: 2.	"prethodni"
							1 to: numberOfExc do: [ :x | 
								condition := ((array2d at: i at: 1 + x) findTokens: '"') at: 2.
								nextElement := ((array2d at: i at: 2 + x) findTokens: '"')
									at: 2 ].
							condition1 := ((array2d at: i at: 2) findTokens: '"') at: 2.
							nextElement1 := ((array2d at: i at: 3) findTokens: '"') at: 2.
							condition2 := ((array2d at: i at: 4) findTokens: '"') at: 2.
							nextElement2 := ((array2d at: i at: 5) findTokens: '"') at: 2.
							niz at: i put: exclusive.
							(niz at: (i - 1)) addOutgoingEdge: exclusive. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A BaseTask 1'
						ifTrue: [ bt1 := NWBaseTask new.
							bt1
								description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							bt1 value: (((array2d at: i at: 3) findTokens: '"') at: 2).
							previous := ((array2d at: i - 1 at: 1) findTokens: '"') at: 2.	"prethodni"
							nextElement := ((array2d at: i at: 4) findTokens: '"') at: 2.
							niz at: i put: bt1. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'A BaseTask 2'
						ifTrue: [ bt2 := NWBaseTask new.
							bt2
								description: (((array2d at: i at: 2) findTokens: '"') at: 2).
							bt2 value: (((array2d at: i at: 3) findTokens: '"') at: 2).
							"Posto je exclusive, treba ispitati"
							(((array2d at: i - 2 at: 1) findTokens: '"') at: 2)
								= 'An Exclusive'
								ifTrue:
									[ previous := ((array2d at: i - 2 at: 1) findTokens: '"') at: 2.	"prethodni"
									exclusive
										addOutgoingEdge: bt1
										withCondition: [ :x | condition1 ].
									exclusive
										addOutgoingEdge: bt2
										withCondition: [ :x | condition2 ] ]
								ifFalse:
									[ previous := ((array2d at: i - 1 at: 1) findTokens: '"') at: 2	"prethodni" ].
							nextElement := ((array2d at: i at: 4) findTokens: '"') at: 2.
							niz at: i put: bt2. ].
					(((array2d at: i at: 1) findTokens: '"') at: 2) = 'An EndEvent'
						ifTrue: [ ee := NWEndEvent new.
							ee description: 'End'.
							(((array2d at: i - 3 at: 1) findTokens: '"') at: 2)
								= 'An Exclusive'
								ifTrue:
									[ previous1 := ((array2d at: i - 2 at: 1) findTokens: '"') at: 2.	"prethodni prvi"
									previous2 := ((array2d at: i - 1 at: 1) findTokens: '"')
										at: 2.	"prerhodni drugi"
									1 to: numberOfExc do: [ :x | (niz at: i - x) addOutgoingEdge: ee ]. ]
								ifFalse: [ Transcript
										show: 0;
										cr ].
							niz at: i put: ee. ].
					]
				ifTrue: [ "r := r + 1." k := 1 ] ] ].
	"1 to: niz size do: [ :i | 
		Transcript
			show: (niz at: i) description;
			cr ]."
	^ niz.