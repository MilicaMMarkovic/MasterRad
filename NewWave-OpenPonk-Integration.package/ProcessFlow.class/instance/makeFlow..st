as yet unclassified
makeFlow: niz
	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| process engine |
	process := NWProcess
		id: '1'
		name: 'process1'
		initialFlowElement: (niz at:1).
	engine := WaveEngine new.
	engine addProcess: process name: 'process1'.
	engine startProcess: 'process1'.
	^ process