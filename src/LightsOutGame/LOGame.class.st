"
LOGame class
"
Class {
	#name : #LOGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells',
		'moves',
		'openedCells'
	],
	#classVars : [
		'LaunchCount',
		'TheGame'
	],
	#category : #LightsOutGame
}

{ #category : #'initialize-release' }
LOGame class >> close [
    "Close the game"
    TheGame delete.
    TheGame := nil.
]

{ #category : #'as yet unclassified' }
LOGame class >> incrementLaunchCount [
    "Додали метод класу для збільшення лічильника запусків гри"
    LaunchCount := LaunchCount + 1.
]

{ #category : #'world menu' }
LOGame class >> menuCommandOn: aBuilder [
    <worldMenu>
    (aBuilder item: #'LOGame')
        order: 5;
        with: [
            (aBuilder item: #'Run Game')
                order: 0;
                action: [self new open].
            (aBuilder item: #'Exit Game')
                order: 1;
                action: [self new close].
            (aBuilder item: #'Reset Game')
                order: 2;
                action: [self new resetGame].
            (aBuilder item: #'Show Statistics')
                order: 3;
                action: [self new showStatistics].
        ].
]

{ #category : #'instance creation' }
LOGame class >> open [
    "Open the game in the world"
    ^ self new openInWorld
]

{ #category : #initialization }
LOGame class >> resetGame [
    "Reset the game"
    TheGame close.
    TheGame := self open.
]

{ #category : #'as yet unclassified' }
LOGame >> cellsPerSide [
    "The number of cells along each side of the game"
    ^ 10
]

{ #category : #'initialize-release' }
LOGame >> close [
    "Close the game"
    self delete.
]

{ #category : #'as yet unclassified' }
LOGame >> countMoveAndCell [
    "Track the number of moves and opened cells"
    moves := moves + 1.
    openedCells := (cells flatten select: #isOn) size.
]

{ #category : #initialization }
LOGame >> initialize [
    "Initialize the LOGame instance"
    | sampleCell width height n |
    super initialize.
    n := self cellsPerSide.
    sampleCell := LOCell new.
    width := sampleCell width.
    height := sampleCell height.
    self bounds: (50@50 extent: ((width * n) @(height * n)) + (5 * self borderWidth)).
    cells := MyArray2D new: n tabulate: [ :i :j | self newCellAt: i at: j ].
    moves := 0. "Added variable for the number of moves"
    openedCells := 0. "Added variable for the number of opened cells"

]

{ #category : #'as yet unclassified' }
LOGame >> launchCount [
    "Додали метод класу для отримання лічильника запусків гри"
    ^ LaunchCount
]

{ #category : #'world menu' }
LOGame >> menuCommandOn: aBuilder [
    <worldMenu>
    (aBuilder item: #'LOGame')
        order: 5;
        with: [
            (aBuilder item: #'Run Game')
                order: 0;
                action: [self open].
            (aBuilder item: #'Exit Game')
                order: 1;
                action: [self close].
            (aBuilder item: #'Reset Game')
                order: 2;
                action: [self resetGame].
            (aBuilder item: #'Show Statistics')
                order: 3;
                action: [self showStatistics].
        ].
]

{ #category : #accessing }
LOGame >> newCellAt: i at: j [
    "Create a new cell at position (i, j) and add it to the on-screen representation. Answer the new cell."
    | c origin |
    c := LOCell new.
    origin := self innerBounds origin.
    self addMorph: c.
    c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin.
    c mouseAction: [self toggleNeighboursOfCellAt: i at: j].
    ^ c
]

{ #category : #'as yet unclassified' }
LOGame >> numberOfMoves [
    ^ moves
]

{ #category : #'as yet unclassified' }
LOGame >> numberOfOpenedCells [
    ^ openedCells
]

{ #category : #'instance creation' }
LOGame >> open [
    "Open the game in the world"
    ^ self new openInWorld
]

{ #category : #initialization }
LOGame >> resetGame [
    "Додали метод для скидання гри"
    cells do: [ :each | each turnOff ].
    moves := 0.
    openedCells := 0.

]

{ #category : #'as yet unclassified' }
LOGame >> showStatistics [
    "Додали метод для відображення статистики"
    | message |
    message := 'Statistics: ' , String newLine , 'Moves: ' , (self numberOfMoves printString) , String newLine , 'Opened Cells: ' , (self numberOfOpenedCells printString).
    UIManager inform: message
]

{ #category : #accessing }
LOGame >> toggleNeighboursOfCellAt: i at: j [
    "Toggle the state of neighboring cells based on the position (i, j)"
    (i > 1) ifTrue: [ (cells at: i - 1 at: j) toggleState ].
    (i < self cellsPerSide) ifTrue: [ (cells at: i + 1 at: j) toggleState ].
    (j > 1) ifTrue: [ (cells at: i at: j - 1) toggleState ].
    (j < self cellsPerSide) ifTrue: [ (cells at: i at: j + 1) toggleState ].
]
