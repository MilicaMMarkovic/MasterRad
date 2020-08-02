as yet unclassified
loadDslFile: path
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| niz  |
	niz  := path asFileReference readStreamDo: [ :in |
 		Array streamContents: [ :out |
 		[ in atEnd ] whileFalse: [ out nextPut: in nextLine ] ] ].
	^ niz.