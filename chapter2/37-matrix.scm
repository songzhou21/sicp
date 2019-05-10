#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car
                                     seqs))
            (accumulate-n op init (map cdr
                                       seqs)))))


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (column)
         (dot-product column v))
       m))

#|
1 2 3 4
4 5 6 6
6 7 8 9

->

1 4 6
2 5 7
3 6 8
4 6 9

|#
(define (transpose mat)
  (accumulate-n cons
                nil
                mat))

#|
1 2 3 4
4 5 6 6
6 7 8 9

*

1 4 6
2 5 7
3 6 8
4 6 9


|#
#;(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (map (lambda (col)
                  (dot-product row
                               col))
                cols))
         m)))


(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (matrix-*-vector cols row))
         m)))


; test

(define matrix (list (list 1 2 3 4)
                     (list 4 5 6 6)
                     (list 6 7 8 9)))

(dot-product (list 1 2 3) (list 4 5 6))
(matrix-*-vector matrix (list 1 2 3 4))
(transpose matrix)
(matrix-*-matrix matrix (transpose matrix)) 
