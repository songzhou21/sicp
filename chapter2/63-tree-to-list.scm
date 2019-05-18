#lang sicp

;; BINARY TREES
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

;; EXERCISE 2.63
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

; tree->list-2
#|
(f (list 1 3 5 7 9 11)
   '())
(f (list 1 3 5)
   (cons 7 (f (list 9 11) '())))

(f nil (cons 9 (f (list 11) '())))
(f nil (cons 11 (f nil '())))
(list 11)
(list 9 11)
(list 7 9 11)


(f (list 1 3 5) (list 7 9 11))

(f (list 1)
 (cons 3 (f (list 5) (list 7 9 11))))

(f nil (cons 5 (f nil (list 7 9 11))))
(list 5 7 9 11)
(list 3 5 7 9 11)
(list 1 3 5 7 9 11)

|#

;; test
(define tree1
  (make-tree 7
             (make-tree 3
                          (make-tree 1 nil nil)
                          (make-tree 5 nil nil))
             (make-tree 9
                        nil
                        (make-tree 11 nil nil))))

(define tree2
  (make-tree 3
             (make-tree 1 nil nil)
             (make-tree 7
                        (make-tree 5 nil nil)
                        (make-tree 9
                                   nil
                                   (make-tree 11 nil nil)))))

(define tree3
  (make-tree 5
             (make-tree 3
                        (make-tree 1 nil nil)
                        nil)
             (make-tree 9
                        (make-tree 7 nil nil)
                        (make-tree 11 nil nil))))

(tree->list-1 tree1)
(tree->list-2 tree1)
(tree->list-1 tree2)
(tree->list-2 tree2)
(tree->list-1 tree3)
(tree->list-2 tree3)

;; 2
;n^2

; tree->list-2
#|
(f (list 1 3 5 7 9 11)
   '())
(f (list 1 3 5)
   (cons 7 (f (list 9 11) '())))

  (f nil (cons 9 (f (list 11) '())))
      (f nil (cons 9 (list 11)))
         (cons 9 (list 11))
|#

; order is n