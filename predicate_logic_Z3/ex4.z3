
(set-option :produce-models true)

(declare-datatypes () ((Plant apple banana cherry rose tulip lily onion carrot pepper)))
(declare-datatypes () ((Garden garden1 garden2 garden3 garden4)))

(declare-fun Fruit (Plant) Bool)
(declare-fun Flower (Plant) Bool)
(declare-fun Vegetable (Plant) Bool)

(declare-fun GrowsIn (Plant Garden) Bool)
(declare-const stat1 Bool)
(declare-const stat2 Bool)
(declare-const stat3 Bool)
(declare-const stat4 Bool)
(declare-const stat5 Bool)
(declare-const stat6 Bool)
(declare-const stat7 Bool)
(declare-const stat8 Bool)
(declare-const stat9 Bool)
(declare-const stat10 Bool)

(assert (forall ((x Plant)) (= (Fruit x) (or (= x apple) (= x banana) (= x cherry)))))
(assert (forall ((x Plant)) (= (Flower x) (or (= x rose) (= x tulip) (= x lily)))))
(assert (forall ((x Plant)) (= (Vegetable x) (or (= x onion) (= x carrot) (= x pepper)))))


;; TODO: constraint 1
;; for all plants x they are either a fruit flower or vegetable
(assert (forall ((x Plant)) (or (Fruit x) (Flower x) (Vegetable x))))
;;assign above statement to stat1 for simplicity
(assert (= stat1 (forall ((x Plant)) (or (Fruit x) (Flower x) (Vegetable x)))))

;; TODO: constraint 2
;; for all gardens y there exists plants x w z that all grow in y and are distinct and for all plants r that grow in y then r must either be x w or z
;; so in other words there are at least 3 distinct plants in garden y and at most 3 distinct plants in garden y
(assert (forall ((y Garden)) (exists ((x Plant) (w Plant) (z Plant)) (and (and(GrowsIn x y) (GrowsIn w y) (GrowsIn z y)  (distinct x z w))  (forall ((r Plant)) (=> (GrowsIn r y)  (or(= x r) (= w r) (= z r))))))))
;;assign above statement to stat2 for simplicity
(assert (= stat2 (forall ((y Garden)) (exists ((x Plant) (w Plant) (z Plant)) (and (and(GrowsIn x y) (GrowsIn w y) (GrowsIn z y)  (distinct x z w))  (forall ((r Plant)) (=> (GrowsIn r y)  (or(= x r) (= w r) (= z r)))))))))
                          
;; TODO: constraint 3
;; all plants x are grown in a garden y
(assert (forall ((x Plant)) (exists ((y Garden)) (GrowsIn x y))))
;;assign above statement to stat3 for simplicity
(assert (= stat3 (forall ((x Plant)) (exists ((y Garden)) (GrowsIn x y)))))

;; TODO: constraint 4
;;there are three distinct plants a b c that are fruits and that grow in a garden y and for all gardens z that have a b c planted then z must be the same garden as y
;; so there is at least one garden with exactly 3 plants and at most 1 garden with exactly 3 plants
(assert  (exists ((y Garden) (a Plant) (b Plant) (c Plant))  (and (and (Fruit a) (Fruit b) (Fruit c) (GrowsIn a y) (GrowsIn b y) (GrowsIn c y) (distinct a b c) )
 (forall ((z Garden))  (=>(and (GrowsIn a z) (GrowsIn b z) (GrowsIn c z)) (= y z)) ))))
;;assign above statement to stat4 for simplicity
(assert (= stat4 (exists ((y Garden) (a Plant) (b Plant) (c Plant))  (and (and (Fruit a) (Fruit b) (Fruit c) (GrowsIn a y) (GrowsIn b y) (GrowsIn c y) (distinct a b c) )
 (forall ((z Garden))  (=>(and (GrowsIn a z) (GrowsIn b z) (GrowsIn c z)) (= y z)) )))))


;; TODO: constraint 5
;; there are 2 gardens x and y in which plants a b and c are planted both in x and y and the plants are a combination of 2 fruits and 1 vegetable
(assert (exists ((x Garden) (y Garden)) (exists ( (a Plant) (b Plant) (c Plant)) (and  (GrowsIn a x)  (GrowsIn b x) (GrowsIn c x)  (GrowsIn a y)  (GrowsIn b y) (GrowsIn c y) 
  (or (and (Fruit a) (Fruit b) (Vegetable c) )   (and (Fruit c) (Fruit a) (Vegetable b) ) (and (Fruit b) (Fruit c) (Vegetable a) )   )  )   )   ))
;;assign above statement to stat5 for simplicity
(assert (= stat5 (exists ((x Garden) (y Garden)) (exists ( (a Plant) (b Plant) (c Plant)) (and  (GrowsIn a x)  (GrowsIn b x) (GrowsIn c x)  (GrowsIn a y)  (GrowsIn b y) (GrowsIn c y) 
  (or (and (Fruit a) (Fruit b) (Vegetable c) )   (and (Fruit c) (Fruit a) (Vegetable b) ) (and (Fruit b) (Fruit c) (Vegetable a))   )  )   )   )))


;; TODO: constraint 6
;; for all gardens y they should not have both roses and carrots
(assert (forall ((y Garden)) (not (and  (GrowsIn rose y) (GrowsIn carrot y))  )))
;;assign above statement to stat6 for simplicity
(assert (= stat6 (forall ((y Garden)) (not (and  (GrowsIn rose y) (GrowsIn carrot y))  ))))

;; TODO: constraint 7
;;for all gardes y either they dont grow a tulip or if they do then they must have another flower distinct from tulip
(assert (forall ((y Garden)) (or (not (GrowsIn tulip y)) (exists ((x Plant)) (and (distinct x tulip) (Flower x) (GrowsIn x y) )))))
;;assign above statement to stat7 for simplicity
(assert (= stat7 (forall ((y Garden)) (or (not (GrowsIn tulip y)) (exists ((x Plant)) (and (distinct x tulip) (Flower x) (GrowsIn x y) ))))))

;; TODO: constraint 8
;;Garden 1 has 1 flower and 1 fruit and 1 vegetable
(assert (and (exists ((x Plant)) (and (Flower x) (GrowsIn x garden1))) (exists ((y Plant)) (and (Fruit y) (GrowsIn y garden1))) 
  (exists ((z Plant)) (and (Vegetable z) (GrowsIn z garden1))) ))
;;assign above statement to stat8 for simplicity
(assert (= stat8 (and (exists ((x Plant)) (and (Flower x) (GrowsIn x garden1))) (exists ((y Plant)) (and (Fruit y) (GrowsIn y garden1))) 
  (exists ((z Plant)) (and (Vegetable z) (GrowsIn z garden1))) )))

;; TODO: constraint 9
;;for all plants x either x does not grow in garden 2 or it is not a flower
(assert (forall ((x Plant))(or (not (GrowsIn x garden2)) (not (Flower x)) )))
;;assign above statement to stat9 for simplicity
(assert (= stat9 (forall ((x Plant))(or (not (GrowsIn x garden2)) (not (Flower x)) ))))

;; TODO: constraint 10
;;carrot grows in garden 1 and 4 and banana grows in garden 3
(assert (and (GrowsIn carrot garden1)(GrowsIn carrot garden4)(GrowsIn banana garden3)))
;;assign above statement to stat10 for simplicity
(assert ( = stat10 (and (GrowsIn carrot garden1)(GrowsIn carrot garden4)(GrowsIn banana garden3))))

(declare-const all Bool)
;;assign above statements to all for simplicity
(assert (= all (and stat1 stat2 stat3 stat4 stat5 stat6 stat7 stat8 stat9 stat10)))
;; TODO: statements (a-c) to prove
;statement a
;; all statements imply lily in garden1
(assert (or (not all) (GrowsIn lily garden1)))
(check-sat)
;statement b
;;all statements imply a fruit in gardens 2 and 3 (the same kind of fruit in both),
(assert  (or (not all) (exists ((x Plant)) (and (Fruit x) (GrowsIn x garden2) (GrowsIn x garden3)))))
(check-sat)
;statement c
;; all statements imply tulips and roses are in the same garden.
(assert  (or (not all) (forall ((x Plant) (y Plant)) (=> (and (= x tulip) (= y rose))  (exists ((z Garden)) (and (GrowsIn x z)  (GrowsIn y z) ) ))   )))

;; check and print model
(check-sat)

(echo "garden1:")
(get-value ((GrowsIn apple garden1) (GrowsIn banana garden1) (GrowsIn cherry garden1) (GrowsIn rose garden1) (GrowsIn tulip garden1) (GrowsIn lily garden1) (GrowsIn onion garden1) (GrowsIn carrot garden1) (GrowsIn pepper garden1)))

(echo "garden2:")
(get-value ((GrowsIn apple garden2) (GrowsIn banana garden2) (GrowsIn cherry garden2) (GrowsIn rose garden2) (GrowsIn tulip garden2) (GrowsIn lily garden2) (GrowsIn onion garden2) (GrowsIn carrot garden2) (GrowsIn pepper garden2)))

(echo "garden3:")
(get-value ((GrowsIn apple garden3) (GrowsIn banana garden3) (GrowsIn cherry garden3) (GrowsIn rose garden3) (GrowsIn tulip garden3) (GrowsIn lily garden3) (GrowsIn onion garden3) (GrowsIn carrot garden3) (GrowsIn pepper garden3)))

(echo "garden4:")
(get-value ((GrowsIn apple garden4) (GrowsIn banana garden4) (GrowsIn cherry garden4) (GrowsIn rose garden4) (GrowsIn tulip garden4) (GrowsIn lily garden4) (GrowsIn onion garden4) (GrowsIn carrot garden4) (GrowsIn pepper garden4)))
(echo "")

