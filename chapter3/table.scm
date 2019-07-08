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


; table list vs cons
(define t (list '*table* 
                (list 'math 
                      (cons '+ 43)
                      (cons '- 45)) 
                (list 'letter
                      (cons 'a 97))))

t
(define t (cons '*table* 
                (cons (cons 'math (cons 
                                    (cons 
                                      (cons '+ 43)
                                      (cons 
                                        (cons '- 45)
                                        '()))
                                    '()))
                      (cons 'letter (cons 
                                      (cons 'a 97)
                                      '())))))
t
