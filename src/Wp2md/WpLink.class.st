Class {
	#name : #WpLink,
	#superclass : #Object,
	#instVars : [
		'url',
		'status'
	],
	#category : #'Wp2md-Model'
}

{ #category : #accessing }
WpLink class >> for: aURL [
	^ self new
		url: aURL;
		yourself
]

{ #category : #comparing }
WpLink >> <= aLink [
	^ self url <= aLink url
]

{ #category : #comparing }
WpLink >> = anObject [
	^ self class = anObject class and: [ self url = anObject url ]
]

{ #category : #utility }
WpLink >> checkHttpStatus [
	(self url beginsWith: 'http') ifFalse: [ ^ self status ].
	[ ZnClient new
		enforceHttpSuccess;
		timeout: 1;
		head: self url;
		response.
	self status: self okStatus ] onErrorDo: [ :ex | self status: ex printString ].
	^ self status
]

{ #category : #accessing }
WpLink >> gtActionWebBrowseFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Open in browser';
		priority: 10;
		icon: BrGlamorousIcons go;
		action: [ WebBrowser openOn: self url ]
]

{ #category : #comparing }
WpLink >> hash [
	^ self url hash
]

{ #category : #initialization }
WpLink >> initialize [
	self status: self unknownStatus
]

{ #category : #constant }
WpLink >> okStatus [
	^ 'ok'
]

{ #category : #printing }
WpLink >> printOn: aStream [
	self url printOn: aStream
]

{ #category : #accessing }
WpLink >> status [
	^ status
]

{ #category : #accessing }
WpLink >> status: anObject [
	status := anObject
]

{ #category : #testing }
WpLink >> statusMissing [
	^ self status = self unknownStatus
]

{ #category : #testing }
WpLink >> statusOk [
	^ self status = self okStatus
]

{ #category : #constant }
WpLink >> unknownStatus [
	^ '?'
]

{ #category : #accessing }
WpLink >> url [
	^ url
]

{ #category : #accessing }
WpLink >> url: anObject [
	url := anObject
]
