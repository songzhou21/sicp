; constructor
(define (make-tree key value left-branch right-branch)
  (list key value left-branch right-branch))

; selector
(define (tree-key tree)
  (car tree))

(define (tree-value tree)
  (car (cdr tree)))

(define (tree-left-branch tree)
  (car (cdr (cdr tree))))

(define (tree-right-branch tree)
  (car (cdr (cdr (cdr tree)))))

(define (tree-empty? tree)
  (null? tree))

; setter
(define (tree-set-key! new-key tree)
  (set-car! tree new-key))

(define (tree-set-value! new-value tree)
  (set-car! (cdr tree) new-value))

(define (tree-set-left-branch! new-left-branch tree)
    (set-car! (cddr tree) new-left-branch))

(define (tree-set-right-branch! new-right-branch tree)
    (set-car! (cdddr tree) new-right-branch))

; operator
(define (tree-insert! tree given-key value compare)
  (if (tree-empty? tree)
      (make-tree given-key value '() '())
      (let ((compare-result (compare given-key (tree-key tree))))
        (cond ((= 0 compare-result)
               (tree-set-value! value tree)
               tree)
              ((= 1 compare-result)
               (tree-set-right-branch! 
                 (tree-insert! (tree-right-branch tree) given-key value compare)
                 tree)
               tree)
              ((= -1 compare-result)
               (tree-set-left-branch!
                 (tree-insert! (tree-left-branch tree) given-key value compare)
                 tree)
               tree)))))

(define (tree-search tree given-key compare)
  (if (tree-empty? tree)
      '()
      (let ((compare-result (compare given-key (tree-key tree))))
        (cond ((= 0 compare-result)
               tree)
              ((= 1 compare-result)
               (tree-search (tree-right-branch tree) given-key compare))
              ((= -1 compare-result)
               (tree-search (tree-left-branch tree) given-key compare))))))

; comparer
(define (compare-string x y)
  (cond ((string=? x y) 0)
        ((string>? x y) 1)
        ((string<? x y) -1)
        ))

(define (compare-symbol x y)
  (compare-string (symbol->string x)
                  (symbol->string y)))

(define (compare-number x y)
  (cond ((= x y) 0)
        ((> x y) 1)
        ((< x y) -1)
  ))

; table
(define (make-table compare)
  (let ((t '()))

    (define (empty?)
      (tree-empty? t))

    (define (insert! given-key value)
      (set! t (tree-insert! t given-key value compare))
      'ok)

    (define (lookup given-key)
      (let ((result (tree-search t given-key compare)))
        (if (null? result)
            #f
            (tree-value result))))

    (define (dispatch m)
      (cond ((eq? m 'insert!) insert!)
            ((eq? m 'lookup) lookup)
            ((eq? m 'empty?) (empty?))
            (else 
              (error "UNKNOW method" m))))
     dispatch))

;; test
(define tree (tree-insert! '() 'peter 100 compare-symbol))
tree
(define tree (tree-insert! tree 'jack 123 compare-symbol))
tree
(define tree (tree-insert! tree 'sam 137 compare-symbol))
tree

(tree-search tree 'jack compare-symbol)

(define t (make-table compare-symbol))

(t 'empty?)

((t 'insert!) 'peter 100)
((t 'lookup) 'peter)
(t 'empty?)
((t 'lookup) 'aaaa)
