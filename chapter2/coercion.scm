(load "table.scm")
(load "scheme-number.scm")
(load "integer-number.scm")
(load "rational-number.scm")
(load "complex-number.scm")
(load "real-number.scm")

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(define coercion-table (make-table))
(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))

;; other
(define (square x) (* x x))

;; tag
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

;; package
(install-scheme-number-package)
(install-integer-package)
(install-rational-package)
(install-real-package)
(install-complex-package)


;; makers
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (make-integer n)
  ((get 'make 'integer) n))

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (make-real n)
  ((get 'make 'real) n))

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

;; coercion
(define (scheme-number->complex n)
  (make-complex-from-real-imag 
    (contents n) 0))

(put-coercion 'scheme-number 'complex 
              scheme-number->complex)
;; generic selectors
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (exp x y) (apply-generic 'exp x y))
(define (addd x y z) (apply-generic 'addd x y z))

