#lang sicp
;; local tables
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

;; main

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
    (and (number? exp) (= exp num)))
  
(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))

(define (make-exponentiation base exponent)
    (cond ((=number? exponent 0) 1)
          ((=number? exponent 1) base)
          (else (list '** base exponent))))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))


;; package
(define (install-sum-package)
  (define (derivative ops var)
    (make-sum (deriv (car ops) var)
              (deriv (cadr ops) var)))

  
  ;; interface
  (put 'deriv '+ derivative))

(define (install-product-package)
  (define (multiplier p) (car p))

  (define (multiplicand p) (cadr p))
  
  (define (derivative ops var)
    (make-sum
           (make-product (multiplier ops)
                         (deriv (multiplicand ops) var))
           (make-product (deriv (multiplier ops) var)
                         (multiplicand ops))))

  
  
  ;; interface
  (put 'deriv '* derivative))

(define (install-exponent-package)
  (define (base x)
    (car x))

  (define (exponent x)
    (cadr x))

  (define (exponentitation? x)
    (and (pair? x) (eq? (car x) '**)))

  (define (derivative ops var)
    (make-product
          (make-product (exponent ops)
                        (make-exponentiation (base ops)
                                              (make-sum (exponent ops) -1)))
          (deriv (base ops) var)))

  ;; interface
  (put 'deriv '** derivative)
  )

; test
(install-sum-package)
(install-product-package)
(install-exponent-package)

(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
(deriv (make-exponentiation 'x 0) 'x)
(deriv (make-exponentiation 'x 0) 'x)
(deriv (make-exponentiation 'x 2) 'x)
(deriv (make-exponentiation 'x 3) 'x)
(deriv (make-exponentiation 'u 'n) 'u)
(deriv (make-exponentiation 'a (make-sum 'a 'b)) 'a)