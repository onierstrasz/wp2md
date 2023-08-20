Class {
	#name : #WpBreakNode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpBreakNode >> asMarkdown [
	^ String cr
]

{ #category : #accessing }
WpBreakNode >> tag [
	^ 'br'
]
