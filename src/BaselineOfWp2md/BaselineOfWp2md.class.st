Class {
	#name : #BaselineOfWp2md,
	#superclass : #BaselineOf,
	#category : #BaselineOfWp2md
}

{ #category : #loading }
BaselineOfWp2md class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'wp2md' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfWp2md >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Wp2md'
		]
]
