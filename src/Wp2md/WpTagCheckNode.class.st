Class {
	#name : #WpTagCheckNode,
	#superclass : #WpHtmlNode,
	#category : #'Wp2md-Parser'
}

{ #category : #printing }
WpTagCheckNode >> printOn: aStream [
	aStream
		nextPutAll: self tag
]

{ #category : #accessing }
WpTagCheckNode >> tag: aString [
	"Subclasses know their tag, so we just check that it is correct"

	self assert: aString equals: self tag
]
