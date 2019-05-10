#lang sicp

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define fold-right accumulate)

#|
(list 1 2 3)

->

3 2 1

(cons 3 (cons 2 (cons 1 nil)))
|#
(define (reverse-right sequence)
  (fold-right (lambda (x y)
                (append y (list x)))
              nil sequence))

#|
(list 1 2 3)

(op nil 1) -> (cons 1 nil)

(op (op nil 1) 2) -> (cons 2 (cons 1 nil))

(op (op (op nil 1) 2) 3) -> (cons 3 (cons 2 (cons 1 nil)))
|#
(define (reverse-left sequence)
  (fold-left (lambda (x y)
               (cons y x)
               ) nil sequence))

; test
(define data (list 1 2 3))

(reverse-right data)
(reverse-left data)