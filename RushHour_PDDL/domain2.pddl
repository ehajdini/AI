(define (domain rush-hour)
    (:requirements :typing :strips)
    (:types num car - object)

    (:predicates
        (plusone ?p1 - num ?p2 - num)
        (isOccupied ?px ?py - num)
        (carTail ?c - car ?px ?py - num)
        (carHead ?c - car ?px ?py - num)
    )

    ; preconditions for moving move-down
    ; 1- The new postion (x,4y) where the head will be placed should be non Occupied
    ; 2- The postions of: (previous head -> (x,3y) , next head -> (x,4y) and 
    ; (previous tail -> (x,1y) , next tail -> (x,2y) should be adjecent 
    ; 3- The current head should be placed in position (x,3y)
    ; 4- The current tail should be placed in position (x,1y)
    
    ;effects
    ; 1- previous tail is not occupied anymore
    ; 2- previous head is not anymore the head of the car
    ; 3- previous tail is not anymore the tail of the car
    ; 4- the next position will be occupied
    ; 5- the next position will be carHead
    ; 6- the tail position will change from (x,1y) to (x,2y)
    (:action move-down
        :parameters (?c - car ?px - num ?p1y - num ?p2y - num ?p3y - num ?p4y - num)
        :precondition (and
            (not (isOccupied ?px ?p4y))
            (plusone ?p1y ?p2y)
            (plusone ?p3y ?p4y)
            (carHead ?c ?px ?p3y)
            (carTail ?c ?px ?p1y)
        )
        :effect (and
            (not (isOccupied ?px ?p1y))
            (not (carHead ?c ?px ?p3y))
            (not (carTail ?c ?px ?p1y))
            (isOccupied ?px ?p4y)
            (carHead ?c ?px ?p4y)
            (carTail ?c ?px ?p2y)
        )
    )
    
    ; preconditions for moving move-up
    ; 1- The new postion (x,1y) where the tail will be placed should be non isOccupied
    ; 2- The postions of: (previous head -> (x,4y) , next head -> (x,3y) and 
    ; (previous tail -> (x,2y) , next tail -> (x,1y) should be adjecent 
    ; 3- The current head should be placed in position (x,4y)
    ; 4- The current tail should be placed in position (x,2y)
    
    ;effects
    ; 1- previous head is not occupied anymore
    ; 2- previous head is not anymore the head of the car
    ; 3- previous tail is not anymore the tail of the car
    ; 4- the next position will be occupied
    ; 5- the Head position will change from (x,4y) to (x,3y) 
    ; 6- the next position will be carTail
    (:action move-up
        :parameters (?c - car ?px - num ?p1y - num ?p2y - num ?p3y - num ?p4y - num)
        :precondition (and
            (not (isOccupied ?px ?p1y))
            (plusone ?p1y ?p2y)
            (plusone ?p3y ?p4y)
            (carHead ?c ?px ?p4y)
            (carTail ?c ?px ?p2y)
            
        )
        :effect (and
            (not (isOccupied ?px ?p4y))
            (not (carHead ?c ?px ?p4y))
            (not (carTail ?c ?px ?p2y))
            (isOccupied ?px ?p1y)
            (carHead ?c ?px ?p3y)
            (carTail ?c ?px ?p1y)
        )
    )
    
    ; preconditions for moving move-left
    ; 1- The new postion (1x,y) where the tail will be placed should be non occupied
    ; 2- The postions of: (previous head -> (4x,y) , next head -> (3x,y) and 
    ; (previous tail -> (2x,y) , next tail -> (1x,y) should be adjecent 
    ; 3- The current head should be placed in position (4x,y)
    ; 4- The current tail should be placed in position (2x,y)
    
    ;effects
    ; 1- previous head is not occupied anymore
    ; 2- previous head is not anymore the head of the car
    ; 3- previous tail is not anymore the tail of the car
    ; 4- the next position (1x,y) will be occupied
    ; 5- the Head position will change from (4x,y) to (3x,y) 
    ; 6- the next position will be carTail
    (:action move-left
        :parameters (?c - car ?py - num ?p1x - num ?p2x - num ?p3x - num ?p4x - num)
        :precondition (and
            (not (isOccupied ?p1x ?py))
            (plusone ?p1x ?p2x)
            (plusone ?p3x ?p4x)
            (carHead ?c ?p4x ?py)
            (carTail ?c ?p2x ?py)
           
        )
        :effect (and
            (not (isOccupied ?p4x ?py))
            (not (carHead ?c ?p4x ?py))
            (not (carTail ?c ?p2x ?py))
            (isOccupied ?p1x ?py)
            (carHead ?c ?p3x ?py)
            (carTail ?c ?p1x ?py)
        )
    )
    
    ; preconditions for moving move-right
    ; 1- The new postion (4x,y) where the head will be placed should be non occupied
    ; 2- The postions of: (previous head -> (3x,y) , next head -> (4x,y) and 
    ; (previous tail -> (1x,y) , next tail -> (2x,y) should be adjecent 
    ; 3- The current head should be placed in position (3x,y)
    ; 4- The current tail should be placed in position (1x,y)
    
    ;effects
    ; 1- previous tail is not occupied anymore
    ; 2- previous head is not anymore the head of the car
    ; 3- previous tail is not anymore the tail of the car
    ; 4- the next position (4x,y) will be occupied
    ; 5- the next position (4x,y) will be carHead
    ; 6- the tail position will change from (1x,y) to (2x,y)
    
    (:action move-right
        :parameters (?c - car ?py - num ?p1x - num ?p2x - num ?p3x - num ?p4x - num)
        :precondition (and
            (not (isOccupied ?p4x ?py))
            (plusone ?p1x ?p2x)
            (plusone ?p3x ?p4x)
            (carHead ?c ?p3x ?py)
            (carTail ?c ?p1x ?py)
            
        )
        :effect (and
            (not (isOccupied ?p1x ?py))
            (not (carHead ?c ?p3x ?py))
            (not (carTail ?c ?p1x ?py))
            (isOccupied ?p4x ?py)
            (carHead ?c ?p4x ?py)
            (carTail ?c ?p2x ?py)
        )
    )
    
)
