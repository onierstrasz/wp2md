Extension { #name : #SequenceableCollection }

{ #category : #'*Wp2md' }
SequenceableCollection >> asWordpressPageGroup [
	^ WordpressPageGroup withAll: self
]
