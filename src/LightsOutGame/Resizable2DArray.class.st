"
comment
"
Class {
	#name : #Resizable2DArray,
	#superclass : #Object,
	#instVars : [
		'rows'
	],
	#classInstVars : [
		'rows'
	],
	#category : #LightsOutGame
}

{ #category : #accessing }
Resizable2DArray class >> at: i at: j put: value [
    "Set element at position (i, j)"
    (rows at: i) at: j ifAbsent: [ ^ nil ] put: value

]

{ #category : #initialization }
Resizable2DArray class >> initialize: numRows numCols: numCols [
    "Initialize the Resizable2DArray instance with dimensions numRows x numCols"
    rows := OrderedCollection new: numRows.
    1 to: numRows do: [ :i |
        | newRow |
        newRow := OrderedCollection new: numCols.
        rows add: newRow.
    ].

]

{ #category : #accessing }
Resizable2DArray >> at: i at: j [
    "Access element at position (i, j)"
    ^ (rows at: i) at: j ifAbsent: [ nil ]
]

{ #category : #accessing }
Resizable2DArray >> at: i at: j put: value [
    "Set element at position (i, j)"
    (rows at: i) at: j put: value.
]

{ #category : #flattening }
Resizable2DArray >> flatten [
    "Flatten the 2D array into a 1D array"
    ^ rows inject: #() into: [ :flat :row | flat, row asArray ].
]

{ #category : #initialization }
Resizable2DArray >> initialize: numRows numCols: numCols [
    "Initialize the Resizable2DArray instance with dimensions numRows x numCols"
    rows := OrderedCollection new: numRows.
    1 to: numRows do: [ :i |
        | newRow |
        newRow := OrderedCollection new: numCols.
        1 to: numCols do: [ :j |
            newRow add: nil.
        ].
        rows add: newRow.
    ].
]
