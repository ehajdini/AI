
;; TODO: model exercise 3 here
(declare-const x Int)
(declare-const y Int)
(declare-const stat1 Bool)
(declare-const stat2 Bool)
(declare-const stat3 Bool)
(declare-fun p (Int Int) Bool)
(declare-fun q (Int Int) Bool)
(declare-fun r (Int Int) Bool)
(check-sat)

;Statement 1
(assert (forall ((x Int))  (exists ((y Int)) (p x y))))
;;assign statement 1 to stat1 
(assert (= stat1 (forall ((x Int))  (exists ((y Int)) (p x y)))))


;Statement2
(assert (forall ((x Int))  (exists ((y Int)) (q x y))))
;;assign statement 2 to stat2
(assert (= stat2 (forall ((x Int))  (exists ((y Int)) (q x y)))))

;Statement3
(assert (forall ((x Int) (y Int)) 
                ( =>
                  (or (p x y ) (q x y)) 
                    (forall ((z Int))  
                        (=> 
                          (or (p y z) (q y z))
                          (r x z)
                        )
                    ) 
                )
             ))
;;assign statement 3 to stat3          
(assert (= stat3  (forall ((x Int) (y Int)) 
                ( =>
                  (or (p x y ) (q x y)) 
                    (forall ((z Int))  
                        (=> 
                          (or (p y z) (q y z))
                          (r x z)
                        )
                    ) 
                )
             ))
  )
             
;;Proof
;not (stat1 /\ stat2 /\ stat3)  or StatementToProve
(assert (or (not (and stat1 stat2 stat3)) (forall ((x Int))  (exists ((y Int)) (r x y)))))
(check-sat)
(get-model)

