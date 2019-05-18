#lang sicp

;; BINARY TREES
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

;; EXERCISE 2.64

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

(define (key record)
  (car record))

(define (lookup given-key set-of-records)
  (if (null? set-of-records) false)
      (let ((entry-key (key (entry set-of-records))))
        (cond ((= given-key entry-key)
               (entry set-of-records))
              ((< given-key entry-key)
               (lookup given-key (left-branch set-of-records)))
              ((> given-key entry-key)
               (lookup given-key (right-branch set-of-records))))))

;; test
(define records (list->tree 
                 '((1 one) (2 two) (4 four))))

(lookup 2 records)