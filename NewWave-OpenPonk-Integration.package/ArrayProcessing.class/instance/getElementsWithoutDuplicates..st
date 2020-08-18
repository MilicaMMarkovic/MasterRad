as yet unclassified
getElementsWithoutDuplicates: anArrays
	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| elementsWithoutDuplicates |
	elementsWithoutDuplicates := (anArrays collect: [ :e | e -> true ])
		asOrderedDictionary keys.
	^ elementsWithoutDuplicates