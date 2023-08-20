Class {
	#name : #WpHeaderNode,
	#superclass : #WpTagCheckNode,
	#instVars : [
		'tag'
	],
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpHeaderNode >> asMarkdown [
	^ ('#' repeat: (self tag removePrefix: 'h') asNumber) , ' ' , super asMarkdown
		, String cr
]

{ #category : #accessing }
WpHeaderNode >> tag [
	^ tag
]

{ #category : #accessing }
WpHeaderNode >> tag: aString [
	self assert: (#(h1 h2 h3) includes: aString).
	tag := aString
]
