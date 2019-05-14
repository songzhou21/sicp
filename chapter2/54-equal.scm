#lang sicp

(define (equal? x y)
  (cond ((and (symbol? x) (symbol? y))
         (symbol-equal? x y))
        ((and (list? x) (list? y))
         (list-equal? x y))
        (else
         false)))

(define (symbol-equal? x y)
  (eq? x y))

(define (list-equal? x y)
  (cond ((and (null? x) (null? y))
         true)
        ((or (null? x) (null? y))
         false)
        ((equal? (car x) (car y))
         (equal? (cdr x) (cdr y)))
        (else 
         false)))

; test

(equal? '(this is a list)
        '(this is a list))


(equal? '(this (is a) list)
        '(this (is a) list))

(equal? '(this is a list)
        '(this (is a) list))

; 2.55
(car ''abracadabra)
(car (quote (quote abracadabra)))
(list 'car (list 'quote (list 'quote 'abracadabra)))