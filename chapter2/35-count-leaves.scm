#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves tree)
  (accumulate +
              0
              (map (lambda (subtree)
                     (if (pair? subtree)
                         (count-leaves subtree)
                         1))
               tree)))

; test
(define x (list (list 1 2) (list 3 4)))
(count-leaves x)
