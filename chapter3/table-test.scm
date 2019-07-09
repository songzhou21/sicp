(load "table.scm")

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
