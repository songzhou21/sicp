(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

  (define (rational->real r)
           (make-real (/ (numer r)
                        (denom r))))

  (define (rational->integer r)
    (make-integer (round (/ (numer r)
                            (denom r)))))

  (define (addd x y z)
    (make-rat (+ (* (numer x) (denom y) (denom z))
                 (* (denom x) (numer y) (denom z))
                 (* (denom x) (denom y) (numer z)))
              (* (denom x) (denom y) (denom z))))

  (define (equ? x y)
    (and (= (numer x) (numer y))
         (= (denom x) (denom y))))

  ; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))

  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))

  (put 'equ? '(rational rational)
       (lambda (x y) (equ? x y)))

  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))

  (put 'addd '(rational rational rational)
       (lambda (x y z) (tag (addd x y z))))

  (put-coercion 'rational 'real rational->real)
  (put-coercion 'rational 'integer rational->integer)

  'done)
