(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x)) 1)))

(define t (list 'a 'b 'c))
(count-pairs t)
;(+ 1 (count-pairs 'a) (count-pairs (list 'b 'c))
;(+ 1 (count-pairs (list 'b 'c))
;(+ 1 (+ 1 (count-pairs 'b) (count-pairs (list 'c))))
;(+ 1 (+ 1 (count-pairs (list 'c))))
;(+ 1 (+ 1 (+1 (count-pairs 'c) (count-pairs '() ))))
; 3


(define x2 (list 'c))
(define x1 (list 'b x2))
(define x (list 'a x1))
(set-cdr! x2 x)
(count-pairs x)
;Aborting!: maximum recursion depth exceeded

(define x '(foo))
(define y (cons x x))
(define str2 (list y))
(count-pairs str2)
;4

(define x '(foo))
(define y (cons x x))
(define str3 (cons y y))
(count-pairs str3)
;7
