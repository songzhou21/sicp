(define (loop? lst)
  (define (iter x y)
    (let ((x-walk (list-walk 1 x))
          (y-walk (list-walk 2 y)))
      (cond ((or (null? x-walk)
                 (null? y-walk))
             #f)
            ((eq? x-walk y-walk)
             #t)
            (else 
              (iter x-walk y-walk)))))

  (iter lst lst))

(define (list-walk step lst)
  (cond ((null? lst)
         '())
        ((= step 0)
         lst)
        (else
          (list-walk (- step 1)
                     (cdr lst)))))


;; test
(loop? (list 1 2 3))

(define circular-list (list 1 2 3))
(set-cdr! (last-pair circular-list) circular-list)
(loop? circular-list)
