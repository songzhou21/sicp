#lang sicp

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

; solution
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board `())

(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

(define (safe? k position)
  (iter-check (car position)
              (cdr position)
              1))

(define (iter-check row-of-new-queen rest-of-queens i)
  (if (null? rest-of-queens)
      #t
      (let ((row-of-current-queen (car rest-of-queens)))
        (if (or (= row-of-new-queen row-of-current-queen)
                (= row-of-new-queen (+ i row-of-current-queen))
                (= row-of-new-queen (- row-of-current-queen i)))
            #f
            (iter-check row-of-new-queen
                        (cdr rest-of-queens)
                        (+ i 1))))))
  
  

(queens 8)

#|
2.43

2.43 的解决方案
(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
	 ;; next expression changed
         (flatmap
	  (lambda (new-row)
	    (map (lambda (rest-of-queens)
		   (adjoin-position new-row k rest-of-queens))
		 (queen-cols (- k 1))))
	  (enumerate-interval 1 board-size)))))
  (queen-cols board-size))


因为现在 queen-cols 在 (enumerate-interval 1 board-size) 会被调用 board-size 遍，每次 queen-cols 调用大概执行 board-size 次，而原来 queen-cols 被调用了 board-size 次，时间为 T
 2.4.3 的时间大概为 (board-size * board-size) * T


|#