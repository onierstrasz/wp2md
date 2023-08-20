"
I represent nodes of the parse tree for Wordpress HTML.
"
Class {
	#name : #WpHtmlNode,
	#superclass : #Object,
	#instVars : [
		'attributeDict',
		'children'
	],
	#category : #'Wp2md-Parser'
}

{ #category : #conversion }
WpHtmlNode >> asMarkdown [
	"Default behavior is just to show children"

	^ '' join: (self children collect: #asMarkdown)
]

{ #category : #accessing }
WpHtmlNode >> attributeDict [
	^ attributeDict
]

{ #category : #accessing }
WpHtmlNode >> attributeDict: anObject [
	attributeDict := anObject
]

{ #category : #accessing }
WpHtmlNode >> children [
	^ children
]

{ #category : #accessing }
WpHtmlNode >> children: aNodeCollection [
	children := aNodeCollection
]

{ #category : #view }
WpHtmlNode >> gtMarkdownfor: aView [
	<gtView>
	^ aView textEditor
		title: 'Markdown';
		priority: 42;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self asMarkdown ];
		actionUpdateButton
]

{ #category : #accessing }
WpHtmlNode >> gtNodesFor: aView [
	<gtView>
	^ aView tree
		title: 'Tree';
		priority: 10;
		items: [ {self} ];
		children: [ :each | each children ];
		itemText: [ :each | each gtDisplayText ];
		expandUpTo: 2
]

{ #category : #initialization }
WpHtmlNode >> initialize [
	self attributeDict: Dictionary new.
	self children: OrderedCollection new
]

{ #category : #accessing }
WpHtmlNode >> links [
	^ self children flatCollect: #links
]

{ #category : #accessing }
WpHtmlNode >> tag [
	^ self subclassResponsibility
]

{ #category : #accessing }
WpHtmlNode >> tags [
	^ (self children flatCollect: #tags) asSet
		add: self tag;
		yourself
]

{ #category : #constant }
WpHtmlNode >> websitePrefix [
	"This shouldn't be hardwired here ..."

	^ 'https://icberne.wordpress.com'
]
