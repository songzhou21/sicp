#lang sicp

;; Vector
(define (make-vect xcor ycor)
  (cons xcor ycor)
  )

(define (xcor-vect v)
  (car v)
  )

(define (ycor-vect v)
  (cdr v)
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

(define (scale-vect s vect)
  (make-vect (* s (xcor-vect vect))
             (* s (ycor-vect vect)))
  )

;; Frames
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))


(define (origin-frame frame)
  (car frame)
  )

(define (edge1-frame frame)
  (car (cdr frame))
  )

(define (edge2-frame frame)
  (car (cdr (cdr frame)))
  )

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;; Segment
(define (make-segment start end)
  (list start end))

(define (start-segment segment)
  (car segment)
  )

(define (end-segment segment)
  (cadr segment)
  )



;;; EXERCISES

;; EXERCISE 2.48
#|
(define seg (make-segment (make-vect 0.0 0.0)
                          (make-vect 1.0 1.0)))
(display seg)
(newline)
(start-segment seg)
(end-segment seg)
|#

;; Painters

;; EXERCISE 2.49

;; testing print points


(define (draw-line start end)
  (newline)
  (display start)
  (display "->")
  (display end)
  )


(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))


(define tl (make-vect 0.0 1.0))
(define tr (make-vect 1.0 1.0))
(define bl (make-vect 0.0 0.0))
(define br (make-vect 1.0 0.0))

(define top-mid (make-vect 0.5 1))
(define bottom-mid (make-vect 0.5 0))
(define left-mid (make-vect 0 0.5))
(define right-mid (make-vect 1 0.5))


;; 1
(define (painter-outline frame)
  ((segments->painter (list
                      (make-segment tl tr)
                      (make-segment tr br)
                      (make-segment br bl)
                      (make-segment bl tl)
                      ))
   frame)
  )


;; 2
(define (painter-x frame)
  ((segments->painter (list
                       (make-segment tl br)
                       (make-segment tr bl)
                       ))
   frame))


;; 3
(define (painter-diamond frame)
  ((segments->painter (list
                       (make-segment top-mid left-mid)
                       (make-segment top-mid right-mid)
                       (make-segment bottom-mid left-mid)
                       (make-segment bottom-mid right-mid)
                       ))
   frame))

;; test

#|
(painter-outline (make-frame (make-vect 0 0)
                             (make-vect 2 0)
                             (make-vect 0 2)
                             ))

(newline)
(painter-x (make-frame (make-vect 0 0)
                         (make-vect 2 0)
                         (make-vect 0 2)
                         ))
(newline)
(painter-diamond (make-frame (make-vect 0 0)
                         (make-vect 2 0)
                         (make-vect 0 2)
                         ))


|#