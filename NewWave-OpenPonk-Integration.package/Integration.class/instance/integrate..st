as yet unclassified
integrate: aString
	| loadFile literalArray modelElement numberElements splittedArray arrayProcess namesOfElements nwSequence process nwProcess |
	loadFile := LoadingFile new.
	literalArray := loadFile loadDslFile: aString.
	modelElement := ModelElement new.
	numberElements := modelElement numberOfElementsInDsl: literalArray.
	splittedArray := modelElement
		splitArray: literalArray
		numberOflementsDsl: numberElements.
	arrayProcess := ArrayProcessing new.
	namesOfElements := arrayProcess
		getNamesOfElements: splittedArray
		numberOfElements: numberElements.
	nwSequence := arrayProcess
		processArray: splittedArray
		numberOfElements: numberElements
		array: namesOfElements.
	process := ProcessFlow new.
	nwProcess := process makeFlow: nwSequence.
	^ nwProcess