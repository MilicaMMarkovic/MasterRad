as yet unclassified
processArray: array2d numberOfElements: aNumber
	| k r red se nextElement sc |
	k := 1.
	r := 1.
	[ (k <= aNumber & r <= aNumber) ]
		whileTrue: [ 1 to: aNumber do: [ :i | 
				1 to: aNumber do: [ :j | 
					red := array2d at: i at: j.
					red isNil
						ifFalse:
							[ "Pozvati instance klasa, drugi red desc i u zavisnosti sta je sta sledeci atributi"
							(((array2d at: i at: j) findTokens: '"') at: 2) = 'A StartEvent'
								ifTrue: [ se := NWStartEvent new.
									k := k + 1.
									se description: (((array2d at: r at: k) findTokens: '"') at: 2).
									k := k + 1.
									nextElement := ((array2d at: r at: k) findTokens: '"') at: 2.
								   r := r + 1.
									Transcript show: se; cr ].
							(((array2d at: i at: j) findTokens: '"') at: 2) = 'A ScriptTask'
								ifTrue: [ k:=1.sc := NWScriptTask  new.
									k := k + 1.
									sc	description: (((array2d at: r at: k) findTokens: '"') at: 2).
									k := k + 1.
									sc script: [ (((array2d at: r at: k) findTokens: '"') at: 2) ].k := k + 1.
									nextElement := ((array2d at: r at: k) findTokens: '"') at: 2.
									r := r + 1.
									Transcript show: sc script; cr ]
							"k := k + 1"
							"Transcript
						show: (array2d at: i at: j);
						cr" ]
						ifTrue: [ "r := r + 1."
							k := 1 ] ] ] ]