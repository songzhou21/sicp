(load "coercion.scm")

(define (apply-generic op . args)
  (define (apply-generic-iter coercion-types)
    (if (null? coercion-types)
      (error "No method for these types, and could not coerce"
             (list op (map type-tag args)))
      (let ((coerced-args (coerce-to (car coercion-types) args '())))
        (if coerced-args
          (let ((proc (get op (map type-tag coerced-args))))
            (if proc
              (apply proc (map contents coerced-args))
              (apply-generic-iter (cdr coercion-types))))
          (apply-generic-iter (cdr coercion-types))))))

  (define (coerce-to target-type remaining-args result)
    (if (null? remaining-args)
      result
      (let* ((arg (car remaining-args))
             (original-type (type-tag arg)))
        (if (eq? original-type target-type)
          (coerce-to target-type
                     (cdr remaining-args)
                     (append result (list arg)))
          (let ((original->target (get-coercion (type-tag arg) target-type)))
            (if original->target
              (coerce-to target-type
                         (cdr remaining-args)
                         (append result (list (original->target arg))))
              #f))))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (if (> (length type-tags) 1)
            (apply-generic-iter type-tags)
            (error "No method for this type" (list op type-tags))))))
  )

;; raise
(define tower-of-types '(integer rational real complex))

(define (raise x)
  (define (apply-raise types)
    (cond ((null? types)
           (error "Type not found in the tower-of-types"
                  (list x tower-of-types)))
          ((eq? (type-tag x) (car types))
           (if (null? (cdr types))
               x
               (let ((raiser (get-coercion (type-tag x) (cadr types))))
                 (if raiser
                     (raiser (contents x))
                     (error "No coercion procedure found for types"
                            (list (type-tag x) (cadr types)))))))
          (else (apply-raise (cdr types)))))

  (apply-raise tower-of-types))


;; test
(raise (make-integer 2))
(raise (make-rational 3 4))
(raise (make-real 3.14159))
