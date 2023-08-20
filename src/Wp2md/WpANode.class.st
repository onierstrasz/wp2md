Class {
	#name : #WpANode,
	#superclass : #WpTagCheckNode,
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpANode >> asMarkdown [
	^ '[' , super asMarkdown , '](' , (self removeRootUrlPrefix: self href) , ')'
]

{ #category : #accessing }
WpANode >> href [
	"Error if missing. NB: May need to rewrite some URLs here."

	^ self attributeDict at: 'href'
]

{ #category : #accessing }
WpANode >> links [
	^ { WpLink for: self href} asOrderedCollection
]

{ #category : #utility }
WpANode >> removeRootUrlPrefix: anUrl [
	^ anUrl removePrefix: self websitePrefix
]

{ #category : #accessing }
WpANode >> tag [
	^ 'a'
]
