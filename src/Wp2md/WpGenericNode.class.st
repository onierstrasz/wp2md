"
I am a generic node for tags that don't have their own tag type (yet).
"
Class {
	#name : #WpGenericNode,
	#superclass : #WpHtmlNode,
	#instVars : [
		'tag'
	],
	#category : #'Wp2md-Parser'
}

{ #category : #accessing }
WpGenericNode >> asMarkdown [
	^ '<MISSING MARKDOWN ' , self tag , '>' , super asMarkdown
]

{ #category : #accessing }
WpGenericNode >> initialize [
	super initialize.
	self tag: 'unknown'
]

{ #category : #printing }
WpGenericNode >> printOn: aStream [
	aStream
		nextPutAll: self tag;
		nextPutAll: ': ...'
]

{ #category : #accessing }
WpGenericNode >> tag [
	^ tag
]

{ #category : #accessing }
WpGenericNode >> tag: aString [
	tag := aString
]
