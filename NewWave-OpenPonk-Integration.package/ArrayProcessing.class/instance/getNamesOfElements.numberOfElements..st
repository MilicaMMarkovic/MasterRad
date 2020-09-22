as yet unclassified
getNamesOfElements: array2d numberOfElements: aNumber
	| arrayProcessed processElementName processElementNameTokeni processElement |
	arrayProcessed := Array new: aNumber.
	1 to: aNumber do: [ :i | 
		processElement := array2d at: i at: 1.
		processElementNameTokeni := processElement findTokens: '"'.
		processElementName := processElementNameTokeni at: 2.
		arrayProcessed at: i put: processElementName ].
	^ arrayProcessed.