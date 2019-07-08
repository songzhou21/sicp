(load-option 'format)


;; local tables
(define (make-table)

  (let ((local-table (list '*table*)))

    (define (lookup key-list)
      (define (iter key-list records)
        (cond ((null? key-list) #f)
              (else
                (let ((record (assoc (car key-list) records)))
                  (if record
                      (if (null? (cdr key-list))
                          (cdr record)
                          (iter (cdr key-list) (cdr record)))
                      #f)))))
      (iter key-list (cdr local-table)))

    (define (insert! key-list value)
      (define (iter! subtable key-list value)
        (if (null? key-list)
            (set-cdr! subtable value)
            (let ((cur-key (car key-list))
                  (rest-keys (cdr key-list))
                  (subtable-rest (if (list? subtable) (cdr subtable) '())))
              (let ((record (assoc cur-key subtable-rest)))
                (format #t "~% subtable:~S subtable-rest:~S record:~S " subtable subtable-rest record)
                (if (not record)
                    (begin
                      (set! record (list cur-key))
                      (set-cdr! subtable (cons record subtable-rest))))
                (iter! record rest-keys value)))))

      (iter! local-table key-list value))



    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))


    (define (assoc key records)
      (format #t "~%assoc key:~S records:~S" key records)
      (cond ((null? records) false)
            ((equal? key (caar records)) (car records))
            (else (assoc key (cdr records)))))

    dispatch))

;; test
(define table (make-table))
((table 'insert-proc!) (list 'a) 1)
((table 'lookup-proc) (list 'a))
((table 'insert-proc!) (list 'a 'b) 2)
((table 'lookup-proc) (list 'a 'b))
((table 'insert-proc!) (list 'a 'c) 3)
((table 'lookup-proc) (list 'a 'c))

((table 'insert-proc!) (list 'a 'b 'c) 123)
((table 'lookup-proc) (list 'a 'b 'c))
((table 'insert-proc!) (list 'a 'b 'c) 'hello)
((table 'lookup-proc) (list 'a 'b 'c))

