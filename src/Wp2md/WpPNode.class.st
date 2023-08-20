Class {
	#name : #WpPNode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpPNode >> asMarkdown [
	^ super asMarkdown , String cr, String cr
]

{ #category : #accessing }
WpPNode >> tag [
	^ 'p'
]
