as yet unclassified
loadDslFile: path
	| niz |
	niz := path asFileReference
		readStreamDo: [ :in | 
			Array
				streamContents: [ :out | [ in atEnd ] whileFalse: [ out nextPut: in nextLine ] ] ].
	^ niz.