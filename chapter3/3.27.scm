(load "table.scm")

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result 
             (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize
   (lambda (n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else
            (+ (memo-fib (- n 1))
               (memo-fib (- n 2))))))))


; test
(memo-fib 3)

(define memoize
    (lambda (f)
        ((lambda (table)
            (lambda (x)
                ((lambda (previously-computed-result)
                    (or previously-computed-result
                        ((lambda (result)
                            (insert! x result table)
                            result)
                         (f x))))
                 (lookup x table))))
         (make-table))))

((lambda (f)
        ((lambda (table)
            (lambda (x)
                ((lambda (previously-computed-result)
                    (or previously-computed-result
                        ((lambda (result)
                            (insert! x result table)
                            result)
                         (f x))))
                 (lookup x table))))
         (make-table)))

(lambda (n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else
            (+ (memo-fib (- n 1))
               (memo-fib (- n 2))))))
 )

((lambda (table)
            (lambda (x)
                ((lambda (previously-computed-result)
                    (or previously-computed-result
                        ((lambda (result)
                            (insert! x result table)
                            result)
                         ((lambda (n)
                            (cond ((= n 0) 0)
                                  ((= n 1) 1)
                                  (else
                                    (+ (memo-fib (- n 1))
                                       (memo-fib (- n 2))))))
                          x))))
                 (lookup x table))))
 (make-table))

(lambda (x)
  ((lambda (previously-computed-result)
     (or previously-computed-result
         ((lambda (result)
            (insert! x result table)
            result)
          ((lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else
                     (+ (memo-fib (- n 1))
                        (memo-fib (- n 2))))))
           x))))
   (lookup x table)))

3,2,1,0,1

