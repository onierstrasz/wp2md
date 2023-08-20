Class {
	#name : #WpTableNode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #accessing }
WpTableNode >> asMarkdown [
	| rows headerLine |
	self assert: self children size equals: 1.
	self assert: self children first tag equals: 'tbody'.
	rows := self children first children
			collect: [ :row | row children flatCollect: [ :item | item children collect: #asMarkdown ] ].
	headerLine := rows first collect: [ :each | '---' ].
	rows add: headerLine afterIndex: 1.
	^ '|'
		, ('|
|' join: (rows collect: [ :each | '|' join: each ])) , '|'
]

{ #category : #accessing }
WpTableNode >> tag [
	^ 'table'
]
