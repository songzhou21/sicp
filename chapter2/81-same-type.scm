(load "coercion.scm")

(install-scheme-number-package)
(install-complex-package)

;; a
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)

;(put-coercion 'scheme-number 'scheme-number
;              scheme-number->scheme-number)

;(put-coercion 'complex 'complex 
;              complex->complex)

(exp (make-scheme-number 1)
     (make-scheme-number 2))

(exp (make-complex-from-real-imag 1 2)
     (make-complex-from-real-imag 3 4))
