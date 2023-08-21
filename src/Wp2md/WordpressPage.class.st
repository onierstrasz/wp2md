Class {
	#name : #WordpressPage,
	#superclass : #Object,
	#instVars : [
		'xml'
	],
	#category : #'Wp2md-Model'
}

{ #category : #'instance - creation' }
WordpressPage class >> for: xmlElement [
^ self new
	xml: xmlElement
]

{ #category : #parsing }
WordpressPage >> ast [
	^ WpHtmlParser parse: self content
]

{ #category : #accessing }
WordpressPage >> content [
	^ self valueFor: 'content:encoded'
]

{ #category : #accessing }
WordpressPage >> exportFilename [
	"For now we don't need any subfolders, but let's check this."

	| filename |
	filename := (self path removePrefix: '/') removeSuffix: '/'.
	filename isEmpty ifTrue: [ filename := 'index' ].
	self assert: (filename includes: $/) not.
	^ filename , '.md'
]

{ #category : #accessing }
WordpressPage >> gtASTfor: aView [
	<gtView>
	^ aView forward
		title: 'HTML AST';
		priority: 40;
		object: [ self ast ];
		view: #gtNodesFor:;
		actionUpdateButton
]

{ #category : #accessing }
WordpressPage >> gtActionWebBrowseFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Open in browser';
		priority: 10;
		icon: BrGlamorousIcons go;
		action: [ WebBrowser openOn: self url ]
]

{ #category : #accessing }
WordpressPage >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Content';
		aptitude: BrGlamorousCodeEditorAptitude;
		priority: 20;
		text: [ self content ]
]

{ #category : #accessing }
WordpressPage >> gtMarkdownfor: aView [
	<gtView>
	^ aView textEditor
		title: 'Markdown';
		priority: 42;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self markdown ];
		actionUpdateButton
]

{ #category : #accessing }
WordpressPage >> gtStateFor: aView [
	<gtView>
	^ aView columnedList
		title: 'State';
		priority: 10;
		items: [ {'Title' -> self title.
				'Path' -> self path.
				'URL' -> self url} ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Attribute'
			text: [ :item | item key ]
			width: 100;
		column: 'Value'
			text: [ :item | item value ]
			width: 300;
		actionUpdateButton
]

{ #category : #accessing }
WordpressPage >> gtXMLfor: aView [
	<gtView>
	^ aView forward
		title: 'XML';
		priority: 60;
		object: [ self xml ];
		view: #gtItemsFor:
]

{ #category : #accessing }
WordpressPage >> links [
	^ self ast links
]

{ #category : #conversion }
WordpressPage >> markdown [
	^ self yamlHeader , self ast asMarkdown
]

{ #category : #accessing }
WordpressPage >> path [
	^ self url copyWithRegex: 'https\:\/\/[^/]+/' matchesReplacedWith: '/'
]

{ #category : #printing }
WordpressPage >> printOn: aStream [
	aStream print: self url
]

{ #category : #accessing }
WordpressPage >> tags [
	^ self ast tags
]

{ #category : #accessing }
WordpressPage >> title [
	^ self valueFor: 'title'
]

{ #category : #accessing }
WordpressPage >> url [
	^ self valueFor: 'link'
]

{ #category : #accessing }
WordpressPage >> valueFor: attribute [
	^ (self xml / attribute) stringValue
]

{ #category : #accessing }
WordpressPage >> xml [
	^ xml
]

{ #category : #accessing }
WordpressPage >> xml: anObject [
	xml := anObject
]

{ #category : #accessing }
WordpressPage >> yamlHeader [
	^ '---
title: ' , self title
		, '
layout: page
permalink: ' , self path
		, '
header:
  image: /assets/images/bernSkylineWide.jpg
  image_description: "City of Bern skyline"
---

'
]
