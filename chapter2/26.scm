#lang sicp

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)


(cons x y)
(cons x (cons 4 (cons 5 (cons 6 nil))))

(list x y)
(cons x (cons y nil))
(cons x (cons (cons 4 (cons 5 (cons 6 nil))) nil))