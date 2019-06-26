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

(define x '(foo))
(define y (cons x x))
(define str2 (list y))
(count-pairs str2)
;3

(define x '(foo))
(define y (cons x x))
(define str3 (cons y y))
(count-pairs str3)
;3

; 带有重复指针的序对
(count-pairs (let ((x (cons 1 2)))
                     (cons x x)))
