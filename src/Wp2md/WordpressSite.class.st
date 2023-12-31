Class {
	#name : #WordpressSite,
	#superclass : #Object,
	#traits : 'TWordPressPageGroup',
	#classTraits : 'TWordPressPageGroup classTrait',
	#instVars : [
		'xml'
	],
	#category : #'Wp2md-Model'
}

{ #category : #'instance creation' }
WordpressSite class >> from: anXMLFile [
	^ self new
		xml: anXMLFile
]

{ #category : #'instance creation' }
WordpressSite class >> icBerne [
	^ self
		from: 'pharo-local/iceberg/onierstrasz/wp2md/wordpressData/theinternationalclubofberne.wordpress.2023-08-15.000.xml'
				asFileReference
]

{ #category : #accessing }
WordpressSite >> allPages [
	^ (self xml // 'item') asOrderedCollection
		collect: [ :each | WordpressPage for: each ]
]

{ #category : #exporting }
WordpressSite >> cleanExport: aMarkdownString [
	"Here we try to clean up the generated markdown."

	| clean lflf lines newlines inList |
	clean := aMarkdownString.
	

	"Replace CR by LF."
	clean := clean copyReplaceAll: String cr with: String lf.	
	
	"Replace multiple blank lines by at most one."
	lflf := String lf repeat: 2.
	clean := clean copyWithRegex: '\n\n\n+' matchesReplacedWith: lflf.
	
	"Remove empty bullets."
	clean := clean  copyWithRegex: '\n\-\s*\n' matchesReplacedWith: ''.
	
	"Remove blank lines with a list."
	lines := String lf split: clean.
	newlines := OrderedCollection new.
	inList := false.
	lines
		do: [ :each | 
			each isEmpty
				ifTrue: [ inList ifFalse: [ newlines add: each ] ]
				ifFalse: [ (each beginsWith: '- ')
						ifTrue: [ inList := true ]
						ifFalse: [ inList := false ].
					newlines add: each ] ].
	clean := String lf join: newlines.

	^ clean
]

{ #category : #exporting }
WordpressSite >> export [
	| targetFolder file |
	targetFolder := self exportFolder.
	self pages
		do: [ :page | 
			file := targetFolder / page exportFilename.
			file
				writeStreamDo: [ :aStream | aStream nextPutAll: (self cleanExport: page markdown) ] ].
	^ targetFolder
]

{ #category : #accessing }
WordpressSite >> exportFolder [
	^ (FileLocator imageDirectory / 'wpExport') asFileReference
		ensureCreateDirectory
]

{ #category : #accessing }
WordpressSite >> gtActionExportFor: anAction [
	<gtAction>
	^ anAction explicit
		priority: 10;
		stencil: [ | button |
			button := BrButton new
					id: GtInspectorInspectButtonId;
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons down;
					label: 'Export markdown';
					action: [ :aButton :aModel :anEvent | 
						| aTool |
						aTool := self gtDefaultInspectorTool.
						aButton phlow spawnObject: self export ].
			button ]
]

{ #category : #accessing }
WordpressSite >> gtAllPagesFor: aView [
	<gtView>
	^ aView forward
		title: 'All Pages';
		priority: 11;
		object: [ (self sortPages: self allPages) asWordpressPageGroup ];
		view: #gtPagesFor:
]

{ #category : #search }
WordpressSite >> gtSpotterForAllPageContents: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'All page content';
		priority: 30;
		items: [ self allPages ];
		itemsLimit: Float infinity;
		itemName: #content;
		sendCategory: [ :aCategory :aStep :thisSearch | aCategory items contents asWordpressPageGroup ];
		filterBySubstring
]

{ #category : #search }
WordpressSite >> gtSpotterForAllPageNames: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'All Page names';
		priority: 11;
		items: [ self allPages ];
		itemsLimit: Float infinity;
		itemName: #path;
		sendCategory: [ :aCategory :aStep :thisSearch | aCategory items contents asWordpressPageGroup ];
		filterBySubstring
]

{ #category : #view }
WordpressSite >> gtXMLfor: aView [
	<gtView>
	^ aView forward
		title: 'XML';
		priority: 50;
		object: [ self xml ];
		view: #gtItemsFor:
]

{ #category : #action }
WordpressSite >> missingStatusLinks [
	^ self links select: #statusMissing
]

{ #category : #accessing }
WordpressSite >> pages [
	^ self sortPages: self selectPages
]

{ #category : #accessing }
WordpressSite >> path: aPath hasPrefixIn: aPrefixList [
	| prefix found prefixes |
	prefixes := aPrefixList asOrderedCollection.
	found := false.
	[ found not and: [ prefixes notEmpty ] ]
		whileTrue: [ prefix := prefixes removeFirst.
			found := aPath beginsWith: prefix ].
	^ found
]

{ #category : #constant }
WordpressSite >> prefixesToIgnore [
	^ #('/?' '/20' '/1996' '/testimonial')
]

{ #category : #utility }
WordpressSite >> selectPages [
	^ self allPages
		reject: [ :each | 
			each content isEmpty
				or: [ self path: each path hasPrefixIn: self prefixesToIgnore ] ]
]

{ #category : #utility }
WordpressSite >> sortPages: asWordpressPageCollection [
	^ asWordpressPageCollection
		sort: [ :a :b | 
			(a path occurrencesOf: $/) < (b path occurrencesOf: $/)
				or: [ (a path occurrencesOf: $/) = (b path occurrencesOf: $/)
						and: [ a path < b path ] ] ]
]

{ #category : #accessing }
WordpressSite >> xml [
	^ xml
]

{ #category : #accessing }
WordpressSite >> xml: anXMLFile [
	xml := XMLDOMParser parse: anXMLFile
]
