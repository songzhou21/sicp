;; constructor
(define (make-deque)
  (cons '() '()))


(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (make-item item before after)
  (cons (cons item before)
        after))

(define (before-item item)
  (cdr (car item)))

(define (after-item item)
  (cdr item))

(define (value-item item)
  (car (car item)))

(define (set-before-item! item before)
  (set-cdr! (car item) before))

(define (set-after-item! item after)
  (set-cdr! item after))

;; predicate
(define (empty-deque? deque)
  (null? (front-ptr deque)))

;; selectors
(define (front-ptr deque) 
  (car deque))
(define (rear-ptr deque) 
  (cdr deque))

(define (front-deque)
 (car (car (front-ptr deque))))

(define (rear-deque)
 (car (car (rear-ptr deque))))

(define (print-deque deque)
  (define (iter remaining)
    (if (null? remaining)
        (newline)
        (begin
          (display (value-item remaining))
          (display " ")
          (iter (after-item remaining)))))

  (newline)
  (iter (front-ptr deque)))

;; mutators?
(define (front-insert-deque! deque item)
  (let ((new-item (make-item item '() '())))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-item)
               (set-rear-ptr! deque new-item))
              (else
                (set-after-item! new-item (front-ptr deque))
                (set-before-item! (front-ptr deque) new-item)
                (set-front-ptr! deque new-item)
                )))
  deque)
            

(define (rear-insert-deque! deque item)
  (let ((new-item (make-item item '() '())))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-item)
               (set-rear-ptr! deque new-item))
              (else
                (set-before-item! new-item (rear-ptr deque))
                (set-after-item! (rear-ptr deque) new-item )
                (set-rear-ptr! deque new-item)
                )))
  deque)

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE called on empty queue"))
        (else 
          (let ((new-front-item (after-item (front-ptr deque))))
            (if (not (null? new-front-item))
                (set-before-item! new-front-item '())
                (set-rear-ptr! deque '()))
            (set-front-ptr! deque new-front-item))
        ))
  deque)

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
       (error "REAR-DELETE called on empty queue"))
        (else 
          (let ((new-rear-item (before-item (rear-ptr deque))))
            (if (not (null? new-rear-item))
                (set-after-item! new-rear-item '())
                (set-front-ptr! deque '()))
            (set-rear-ptr! deque new-rear-item))
          ))
  deque)

;; test
(define q (make-deque))

(begin
  (front-insert-deque! q 'a)
  (front-insert-deque! q 'b)
  (front-insert-deque! q 'c)
  (rear-insert-deque! q '1)
  (rear-insert-deque! q '2)
  (rear-insert-deque! q '3)

  (front-delete-deque! q)
  (rear-delete-deque! q)
  'done)

(print-deque q)
