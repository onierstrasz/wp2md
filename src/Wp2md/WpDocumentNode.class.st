"
I am a root node for a document.
"
Class {
	#name : #WpDocumentNode,
	#superclass : #WpHtmlNode,
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpDocumentNode >> asMarkdown [
	^ super asMarkdown
]

{ #category : #accessing }
WpDocumentNode >> tag [
	^ 'document'
]
