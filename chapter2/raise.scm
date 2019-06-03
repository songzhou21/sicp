(load "coercion.scm")

(define (apply-generic op . args)
  (define (find-and-apply-op)
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
  
  (let ((result (find-and-apply-op)))
    (if (and (pair? result)
             (memq (type-tag result)
                   tower-of-types))
      (drop result)
      result)))

;; raise
(define tower-of-types '(integer rational real complex))

(define (raise x)
  (apply-raise x tower-of-types))

(define (apply-raise x types)
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
        (else (apply-raise x (cdr types)))))

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

;; drop
(define (drop x)
  (let* ((dropped (project x))
         (raised (raise dropped)))
    (if (and (not (eq? (type-tag x)
                       (type-tag dropped)))
             (equ? x raised))
      (drop dropped)
      x)))


(define (project x)
  (apply-raise x (reverse tower-of-types)))

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

(project (make-real 3.5))
(raise (project (make-real 3.5)))

(drop (make-integer 5))
(drop (make-complex-from-real-imag 42 0))
(drop (make-complex-from-real-imag 3/4 0))
(drop (make-real 2.5))

(addd (make-rational 1 3) (make-rational 2 3) (make-rational 2 2))
(addd (make-real 3.5) (make-rational 3 2) (make-complex-from-real-imag 5 0))
(add (make-real 4.25) (make-rational 5 2))
(sub (make-complex-from-real-imag 5 2) (make-complex-from-real-imag 2 2))
