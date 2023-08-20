Trait {
	#name : #TWordPressPageGroup,
	#category : #'Wp2md-Model'
}

{ #category : #view }
TWordPressPageGroup >> gtLinksFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Links';
		priority: 12;
		items: [ self links ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'URL'
			text: [ :each | each  url ]
			width: 400
	
]

{ #category : #view }
TWordPressPageGroup >> gtPagesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pages';
		priority: 10;
		items: [ self pages ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Path'
			text: [ :each | each path ]
			width: 200;
		column: 'Title'
			text: [ :each | each title ]
			width: 200
]

{ #category : #search }
TWordPressPageGroup >> gtSpotterForPageContents: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page content';
		priority: 20;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #content;
		sendCategory: [ :aCategory :aStep :thisSearch | aCategory items contents asWordpressPageGroup ];
		filterBySubstring
]

{ #category : #search }
TWordPressPageGroup >> gtSpotterForPageNames: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page names';
		priority: 10;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #path;
		sendCategory: [ :aCategory :aStep :thisSearch | aCategory items contents asWordpressPageGroup ];
		filterBySubstring
]

{ #category : #accessing }
TWordPressPageGroup >> links [
	^ (self pages flatCollect: #links) asSet asOrderedCollection sorted
]

{ #category : #accessing }
TWordPressPageGroup >> pages [
	^ self explicitRequirement
]
