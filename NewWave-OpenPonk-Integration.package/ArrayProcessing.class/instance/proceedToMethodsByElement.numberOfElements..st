as yet unclassified
proceedToMethodsByElement: array2d numberOfElements: aNumber
	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| arrayProcessed processElementName processElementNameTokeni processElement |
	arrayProcessed := Array2D  new: aNumber  .
	1 to: aNumber do: [ :i | 
		1 to: aNumber do: [ :j | 
			processElementName := array2d at: i at: 1.	"ovo vraca u matrici u svakoj koloni prvi red, deklaracija elementa"
			processElementNameTokeni := processElementName findTokens: '"'.	"podeli na tokene npr. tokeni su activity i A BaseTask 2"
			processElement := processElementNameTokeni at: 2 .
			arrayProcessed at:i at:j put: processElement ] ].
	^ arrayProcessed .