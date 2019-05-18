#lang sicp

;; ordered O(N)
(define (union-set set1 set2)
  (cond ((null? set2) set1)
        ((null? set1) set2)
        (else (let ((x1 (car set1))
                    (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1 (union-set (cdr set1)
                                           (cdr set2))))
                      ((> x2 x1)
                       (cons x1 (union-set (cdr set1)
                                           set2)))
                      ((< x2 x1)
                       (cons x2 (union-set set1
                                           (cdr set2)))))))))
(define (union-tree tree1 tree2)
  (list->tree
   (union-set (tree->list tree1)
              (tree->list tree2))))

;; O(N)
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

(define (intersection-tree tree1 tree2)
  (list->tree (intersection-set (tree->list tree1)
                                (tree->list tree2))))

;; BINARY TREES
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

;; O(N)
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


;; O(N)
(define (list->tree elements)
  (car (partial-tree elements (length elements))))


(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;; test
(define ut (union-tree (list->tree (list 1 2 3 5 7 9))
                       (list->tree (list 2 4 6 8 10))))
(display ut)
(tree->list ut)


(define it (intersection-tree (list->tree (list 1 2 3 4 5))
                              (list->tree (list 1 3 5))))
(display it)
(tree->list it)