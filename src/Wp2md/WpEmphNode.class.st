Class {
	#name : #WpEmphNode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #utility }
WpEmphNode >> asMarkdown [
	^ '*' , super asMarkdown , '*'
]

{ #category : #accessing }
WpEmphNode >> tag [
	^ 'em'
]
