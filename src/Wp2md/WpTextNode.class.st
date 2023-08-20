"
I represent plain text, without any tag.
"
Class {
	#name : #WpTextNode,
	#superclass : #WpHtmlNode,
	#category : #'Wp2md-Parser'
}

{ #category : #accessing }
WpTextNode >> asMarkdown [
	^ self text
]

{ #category : #printing }
WpTextNode >> printOn: aStream [
	aStream
		nextPutAll: self tag;
		nextPutAll: ': ';
		nextPutAll: self text
]

{ #category : #initialization }
WpTextNode >> tag [
	^ 'text'
]

{ #category : #accessing }
WpTextNode >> text [
	^ self attributeDict at: 'value'
]

{ #category : #accessing }
WpTextNode >> text: aString [
	self attributeDict at: 'value' put: aString
]
