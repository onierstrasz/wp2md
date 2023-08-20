Class {
	#name : #WpStrongNode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpStrongNode >> asMarkdown [
	^ '**' , super asMarkdown , '**'
]

{ #category : #accessing }
WpStrongNode >> tag [
	^ 'strong'
]
