(define (install-real-package)
  (define (tag x)
    (attach-tag 'real x))    

  (define (real->complex r)
    (make-complex-from-real-imag r 0))

  (put 'add '(real real)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(real real)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(real real)
       (lambda (x y) (tag (* x y))))
  (put 'div '(real real)
       (lambda (x y) (tag (/ x y))))
  (put 'equ? '(real real) =)
  (put '=zero? '(real)
       (lambda (x) (= 0 x)))
  (put 'make 'real
       (lambda (x) (if (real? x)
                       (tag x)
                       (error "non-real value" x))))
  
  (put-coercion 'real 'complex real->complex)

  (put 'addd '(real real real)
       (lambda (x y z) (tag (+ x y z))))

  'done)
