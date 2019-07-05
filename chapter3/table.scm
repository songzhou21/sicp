(define (make-table)
  (list '*table*))

(define (lookup key table)
  (display table)
  (display (cdr table))
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) 
         (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)


;; test

(define table (make-table))
(insert! 'a 1 table)
(insert! 'b 2 table)

(lookup 'a table)

(list 1 2)
(cons 1 (cons 2 '()))
(define a (cons (cons 'a 1) (cons (cons 'b 2) '())))
(define b (list (cons 'a 1) (cons 'b 2)))

a
b
