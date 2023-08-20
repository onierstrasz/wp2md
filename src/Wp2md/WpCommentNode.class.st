"
I represent a comment with a text child.
"
Class {
	#name : #WpCommentNode,
	#superclass : #WpHtmlNode,
	#category : #'Wp2md-Parser'
}

{ #category : #accessing }
WpCommentNode >> asMarkdown [
	^ ''
]

{ #category : #printing }
WpCommentNode >> comment [
	^ self children first text
]

{ #category : #accessing }
WpCommentNode >> comment: aString [
	self children
		add: (WpTextNode new
				text: aString;
				yourself)
]

{ #category : #printing }
WpCommentNode >> printOn: aStream [
	aStream
		nextPutAll: self tag;
		nextPutAll: ': ';
		nextPutAll: self comment
]

{ #category : #initialization }
WpCommentNode >> tag [
	^ 'comment'
]
