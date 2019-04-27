#lang sicp
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))



(define (up-split painter n)
  (if (= n 0)
     painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller))
      )
  ))

(define (split first last)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller (((split first last) paint (- n 1)))))
        (first painter (last smaller smaller))
      )
  )))

(define right-split (split beside below))
(define up-split (split below beside))