;(define (append x y)
;  (if (null? x)
;      y
;      (cons (car x) (append (cdr x) y))))
;
;
;(define (append! x y)
;  (set-cdr! (last-pair x) y)
;  x)
;
;(define (last-pair x)
;  (if (null? (cdr x))
;      x
;      (last-pair (cdr x))))


;; test
(define x (list 'a 'b))
; (a (b nil))
(define y (list 'c 'd))
; (c (d nil))
(define z (append x y))
; (a (b (c (d nil))))

z
(cdr x)

(define w (append! x y))
; (a (b (c (d nil))))


w

(cdr x)
; (b (c (d nil)))