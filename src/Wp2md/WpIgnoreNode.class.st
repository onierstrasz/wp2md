"
I am like a generic node, but I am ignored for Markdown generation.
"
Class {
	#name : #WpIgnoreNode,
	#superclass : #WpGenericNode,
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpIgnoreNode >> asMarkdown [
	^ ''
]
