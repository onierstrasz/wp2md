Class {
	#name : #WpLiNode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #accessing }
WpLiNode >> asMarkdown [
	^ '- ' , super asMarkdown
]

{ #category : #accessing }
WpLiNode >> tag [
	^ 'li'
]
