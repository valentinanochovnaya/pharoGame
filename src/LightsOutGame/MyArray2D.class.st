"
Array2D class
"
Class {
	#name : #MyArray2D,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #LightsOutGame
}

{ #category : #'as yet unclassified' }
MyArray2D class >> averageValueForArrays: arrays [
    "Calculate the average value for an array of MyArray2D instances"
    | totalValues totalCount |
    totalValues := 0.
    totalCount := 0.

    arrays do: [ :array |
        array do: [ :value |
            totalValues := totalValues + value.
            totalCount := totalCount + 1.
        ].
    ].

    ^ totalCount > 0 ifTrue: [ totalValues / totalCount ] ifFalse: [ 0 ].
]

{ #category : #'instance creation' }
MyArray2D class >> new: n tabulate: aBlock [
    "Create a new instance of MyArray2D with dimensions n x n, populated using the given block"
    | array |
    array := self new: n.
    1 to: n do: [ :i |
        array at: i put: (Array new: n).
        1 to: n do: [ :j |
            array at: i at: j put: (aBlock value: i value: j) ] ].
    ^ array
]

{ #category : #'instance creation' }
MyArray2D class >> newZeroFilled: n [
    "Create a new instance of MyArray2D with dimensions n x n, filled with zeros"
    ^ self new: n tabulate: [ :i :j | 0 ]
]

{ #category : #accessing }
MyArray2D >> at: i at: j [
    "Access element at position (i, j)"
    ^ (data at: i ifAbsent: [ ^ nil ]) at: j ifAbsent: [ ^ nil ]
]

{ #category : #accessing }
MyArray2D >> at: i at: j put: value [
    "Set element at position (i, j)"
    | innerArray |

    " Ensure the outer array is initialized "
    data ifNil: [ data := Array new ].

    " Ensure the inner array is initialized "
    innerArray := data at: i ifAbsent: [ data at: i put: Array new ].

    " Set the value in the inner array "
    innerArray at: j put: value.
]

{ #category : #flattening }
MyArray2D >> flatten [
    "Flatten the 2D array into a 1D array"
    ^ data inject: #() into: [ :flat :row | flat, row ]
]

{ #category : #initialization }
MyArray2D >> initialize [
    "Initialize the MyArray2D instance"
    super initialize.
    data := #( #(1 2 3) #(4 5 6) #(7 8 9) ). "Replace this with your actual 2D array"
]

{ #category : #initialization }
MyArray2D >> initialize: n [
    "Initialize the MyArray2D instance with dimensions n x n"
    super initialize.
    data := Array new: n.
]

{ #category : #'instance creation' }
MyArray2D >> new: n tabulate: aBlock [
    "Create a new instance of MyArray2D with dimensions n x n, populated using the given block"
    | array |
    array := self new: n.
    1 to: n do: [ :i |
        array at: i put: (Array new: n).
        1 to: n do: [ :j |
            array at: i at: j put: (aBlock value: i value: j) ] ].
    ^ array
]
