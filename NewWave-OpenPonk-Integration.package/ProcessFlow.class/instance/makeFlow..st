as yet unclassified
makeFlow: anArray
	| process engine |
	process := NWProcess
		id: '1'
		name: 'process1'
		initialFlowElement: (anArray at: 1).
	engine := WaveEngine new.
	engine addProcess: process name: 'process1'.
	engine startProcess: 'process1'.
	^ anArray.