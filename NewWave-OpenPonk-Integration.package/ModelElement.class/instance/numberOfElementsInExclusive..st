as yet unclassified
numberOfElementsInExclusive: array2d
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| numberElements stringArray |
	numberElements := 0.
	2 to: (stringArray size-1) do:[ :i | 
		(stringArray at:i) isNil
		ifFalse: [
			(((stringArray at:i) findTokens: '"') at:1)='		condition '
					ifTrue: [ numberElements := numberElements +1. ] . ] . ].
	^ numberElements .