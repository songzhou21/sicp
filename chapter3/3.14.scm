(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))
v
(define w (mystery v))
w
v

;(loop (list 'a 'b 'c 'd) '())
;(loop (list 'b 'c 'd) (list 'a))
;(loop (list 'c 'd) (list 'b 'a))
;(loop (list 'd) (list 'c 'b 'a))
;(loop '() (list 'd 'c 'b 'a))
