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

;; test
(addd (make-scheme-number 1)
      (make-complex-from-real-imag 2 1)
      (make-scheme-number 3))

(exp (make-scheme-number 2)
     (make-scheme-number 3))

