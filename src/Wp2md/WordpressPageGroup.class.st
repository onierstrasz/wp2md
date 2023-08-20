Class {
	#name : #WordpressPageGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems + TWordPressPageGroup',
	#classTraits : 'TGtGroupWithItems classTrait + TWordPressPageGroup classTrait',
	#instVars : [
		'items'
	],
	#category : #'Wp2md-Model'
}

{ #category : #accessing }
WordpressPageGroup >> pages [
	^ self items
]
