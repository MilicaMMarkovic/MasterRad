as yet unclassified
numberOfElementsInDsl: stringArray
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| numberElements |
	numberElements := 0.
	2 to: (stringArray size-1) do: [ :i |
		(stringArray at: i) = ''
			ifTrue: [ numberElements := numberElements + 1. ] ].
	numberElements := numberElements + 1. 
	^ numberElements .