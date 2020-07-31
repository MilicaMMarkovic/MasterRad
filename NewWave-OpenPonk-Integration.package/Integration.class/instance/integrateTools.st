as yet unclassified
integrateTools
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| literalArray2  drugi treci initialFlowElementName se drugiTokeni drugiTokeniPrvi drugiTokeniDrugi |
	literalArray2 := 'C:\Users\Mica\Desktop\dsl2.txt' asFileReference readStreamDo: [ :in |
 		Array streamContents: [ :out |
 		[ in atEnd ] whileFalse: [ out nextPut: in nextLine ] ] ].
	drugi := literalArray2 second .
treci := literalArray2 third .
initialFlowElementName := drugi copyFrom: 17 to: ((drugi size)-2).

se := NWStartEvent new.
se description:  initialFlowElementName.

drugiTokeni := drugi findTokens: '"'.
drugiTokeniPrvi := drugiTokeni at: 1 .
drugiTokeniPrvi = '	initial state '
ifTrue: [ se:= NWStartEvent new. ].
drugiTokeniDrugi := drugiTokeni at: 2.
drugiTokeniDrugi = 'A StartEvent'
	ifTrue: [ se:= NWStartEvent new.  ] .