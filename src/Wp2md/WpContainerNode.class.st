"
I am like a generic node, however I just display the markdown of my children.
"
Class {
	#name : #WpContainerNode,
	#superclass : #WpGenericNode,
	#category : #'Wp2md-Parser'
}

{ #category : #accessing }
WpContainerNode >> asMarkdown [
	^ '' join: (self children collect: #asMarkdown)
]
