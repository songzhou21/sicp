(define x (cons 1 2))

(eq? x x)

(define (count-pairs x)
    (length (inner x '())))


(define (inner x memo-list)
    (if (and (pair? x)
             (false? (memq x memo-list)))
        (inner (car x)
               (inner (cdr x)
                	  (cons x memo-list)))
        memo-list))
        

        
;; test
(define t (list 'a 'b 'c))
(count-pairs t)
; 3

(define two (list 'a 'b))
(define four (cons two (cdr two)))
(count-pairs four)

; 带有重复指针的序对
(count-pairs (let ((x (cons 1 2)))
                     (cons x x)))
