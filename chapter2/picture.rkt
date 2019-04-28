#lang racket/gui

(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))
(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

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


#;(define (draw-line start end)
  (newline)
  (display start)
  (display "->")
  (display end)
  )


(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (let (
             (start-coord-map ((frame-coord-map frame) (start-segment segment)))
             (end-coord-map ((frame-coord-map frame) (end-segment segment))))
         (line
          (make-posn (xcor-vect start-coord-map) (ycor-vect start-coord-map))
          (make-posn (xcor-vect end-coord-map) (ycor-vect end-coord-map)))))
     segment-list
     )))


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

;; 4
(define wave-painter
  (segments->painter
   (list
    (make-segment (make-vect 0.5 0.4) ;;; leg triangle
                  (make-vect 0.6 0))
    (make-segment (make-vect 0.5 0.4)
                  (make-vect 0.4 0))
    (make-segment (make-vect 0.3 0)
                  (make-vect 0.35 0.4))
    (make-segment (make-vect 0.35 0.4)
                  (make-vect 0.3 0.7))
    (make-segment (make-vect 0.3 0.7)
                  (make-vect 0.2 0.6))
    (make-segment (make-vect 0.2 0.6)
                  (make-vect 0 0.8))
    (make-segment (make-vect 0 0.9)
                  (make-vect 0.2 0.7))
    (make-segment (make-vect 0.2 0.7)
                  (make-vect 0.3 0.75))
    (make-segment (make-vect 0.3 0.75)
                  (make-vect 0.4 0.75))
    (make-segment (make-vect 0.4 0.75)
                  (make-vect 0.35 0.9))
    (make-segment (make-vect 0.35 0.9)
                  (make-vect 0.4 1))
    (make-segment (make-vect 0.5 1)
                  (make-vect 0.55 0.9))
    (make-segment (make-vect 0.55 0.9)
                  (make-vect 0.5 0.75))
    (make-segment (make-vect 0.5 0.75)
                  (make-vect 0.6 0.75))
    (make-segment (make-vect 0.6 0.75)
                  (make-vect 1 0.45))
    (make-segment (make-vect 1 0.3)
                  (make-vect 0.6 0.5))
    (make-segment (make-vect 0.6 0.5)
                  (make-vect 0.7 0)))))

;; test
(define unit-frame (make-frame (make-vect 0 500)
                               (make-vect 500 0)
                               (make-vect 0 -500)
                               ))

#;(painter-outline unit-frame)
#;(painter-x unit-frame)
#;(painter-diamond unit-frame)
#;(wave-painter unit-frame)


