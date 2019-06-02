(load "coercion.scm")

(define (apply-generic op . args)
  (let* ((type-tags (map type-tag args))
         (proc (get op type-tags)))
    (if proc
      (apply proc (map contents args))
      (if (> (length type-tags) 1)
        (let* ((highest-type (find-highest-type type-tags))
               (mapped-args (raise-all-to highest-type args))
               (mapped-types (map type-tag mapped-args))
               (mapped-proc (get op mapped-types)))
          (if mapped-proc
            (apply mapped-proc (map contents mapped-args))
            (error "No method for these types -- APPLY-GENERIC"
                   (list op type-tags))))))))

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


(define (find-highest-type l)

  (define (filter-type t f)
    (cond ((null? f) '())
          ((eq? (car f) t)
           (filter-type t (cdr f)))
          (else (cons (car f)
                      (filter-type t (cdr f))))))

  (define (find-highest highest remaining-tower remaining-list)
    (cond ((null? remaining-list) highest)
          ((null? remaining-tower)
           (error "Cannot find highest type from non-tower types -- FIND-HIGHEST-TYPE"
                  remaining-list))
          (else (find-highest (car remaining-tower)
                              (cdr remaining-tower)
                              (filter-type (car remaining-tower)
                                           remaining-list)))))

  (find-highest #f tower-of-types l))

(define (raise-to type value)
  (cond ((eq? type (type-tag value))
         value)
        ((memq type tower-of-types)
         (raise-to type (raise value)))
        (else (error "Cannot raise to no-tower type -- RAISE-TO"
                     (list type tower-of-types)))
        ))

(define (raise-all-to type values)
  (if (null? values)
    '()
    (cons (raise-to type (car values))
          (raise-all-to type (cdr values)))))
;; test
(raise (make-integer 2))
(raise (make-rational 3 4))
(raise (make-real 3.14159))

(find-highest-type '(integer real rational real))

(raise-to 'real (make-integer 4))
(raise-to 'complex (make-rational 3 4))
(raise-all-to 'real (list (make-integer 42) (make-real 3.14159) (make-rational 3 4)))

(addd (make-real 3.14159) (make-rational 3 4) (make-complex-from-real-imag 1 7))
(addd (make-rational 1 2) (make-rational 1 4) (make-rational 1 8))
(addd (make-integer 42) (make-real 3.14159) (make-rational 2 5))
