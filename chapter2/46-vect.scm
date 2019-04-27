(define (make-vect xcor ycor)
  (list xcor ycor)
  )

(define (xcor-vect v)
  (car v)
  )

(define (ycor-vect v)
  (cadr v)
  )

(define (add-vect a b)
  (make-vect (+ (xcor-vect a) (xcor-vect b))
             (+ (ycor-vect a) (ycor-vect b))
             )
  )

(define (sub-vect a b)
  (make-vect (- (xcor-vect a) (xcor-vect b))
             (- (ycor-vect a) (ycor-vect b))
             )
  )

(define (scale-vect vect s)
  (make-vect (* s (xcor-vect vect)) (* s (xcor-vect vect)))
  )


(define sum (add-vect (make-vect 0.5 0.5)
                      (make-vect 0.1 0.1)))


(define diff (sub-vect (make-vect 0.5 0.5)
                      (make-vect 0.1 0.1)))

(define scale (scale-vect (make-vect 0.5 0.5)
                      2))

(xcor-vect sum)
(xcor-vect diff)
(xcor-vect scale)
