#lang sicp

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (car (cdr b)))


;; Refefinition

#|
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (cdr b))
|#

; b
(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((not (pair? mobile))
         mobile)
        (else (+ (total-weight (branch-structure (left-branch mobile)))
                 (total-weight (branch-structure (right-branch mobile))))
              )))

(define mobile1 (make-mobile (make-branch 1 2)
                             (make-branch 3 4)))

(total-weight mobile1)

; c
(define (balanced? m)
  (cond ((null? m) #t)
        ((not (pair? m)) #t)
        (else (and (= (* (branch-length (left-branch m))
                         (total-weight (branch-structure (left-branch m))))
                      (* (branch-length (right-branch m))
                         (total-weight (branch-structure (right-branch m)))))
                   (balanced? (branch-structure (left-branch m)))
                   (balanced? (branch-structure (right-branch m)))))
        ))

(define m2 (make-mobile 
             (make-branch 4 6) 
             (make-branch 2 
                          (make-mobile 
                           (make-branch 5 8) 
                           (make-branch 10 4)))))

(balanced? m2)
(balanced? mobile1)