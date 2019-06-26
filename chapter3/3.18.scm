(define (loop? l)
  (let ((identity (cons '() '())))
    (define (iter remain-list)
      (cond ((null? remain-list)
             #f)
            ((eq? identity (car remain-list))
             #t)
            (else
              (set-car! remain-list identity)
              (iter (cdr remain-list)))))

    (iter l)))


(loop? (list 1 2 3))

(define loop (list 1 2 3))
(set-cdr! (last-pair loop) loop)
(loop? loop)


