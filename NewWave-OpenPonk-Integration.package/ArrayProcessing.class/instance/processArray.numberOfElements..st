as yet unclassified
processArray: array2d numberOfElements: aNumber
	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| arrayProcessed k r red |
	k := 1.
	r := 1.
	1 to: aNumber do: [ :i | 
		1 to: aNumber do: [ :j | 
			red := array2d at: i at: j .
			(red isNil) 
				ifFalse: [ "Pozvati instance klasa, drugi red desc i u zavisnosti sta je sta sledeci atributi"
					k:=k+1. ]
				ifTrue: [ r:=r+1.k:=1. ]
		] 
	].
	arrayProcessed := 1.
	^ arrayProcessed