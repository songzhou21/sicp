(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (set-front-ptr! item)
      (set! front-ptr item))
    (define (set-rear-ptr! item)
      (set! rear-ptr item))

    (define (front-queue)
      front-ptr)

    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
            (cond ((empty-queue?)
                   (set-front-ptr!  new-pair)
                   (set-rear-ptr! new-pair))
                  (else
                    (set-cdr! rear-ptr new-pair)
                    (set-rear-ptr! new-pair))))
      front-ptr)

    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
              (set-front-ptr! (cdr front-ptr))
              front-ptr)))

    (define (empty-queue?)
      (null? front-ptr))

    (define (dispatch m)
      (cond ((eq? m 'insert-queue!) 
             insert-queue!)
            ((eq? m 'delete-queue!) 
             (delete-queue!))
            ((eq? m 'empty-queue?) 
             (empty-queue?))
            ((eq? m 'front-queue) 
             (front-queue))
            (else 
              (error "Undefined operation: " m))))
    dispatch))

(define q1 (make-queue))
((q1 'insert-queue!) 'a)
((q1 'insert-queue!) 'b)
(q1 'delete-queue!)
(q1 'front-queue)

