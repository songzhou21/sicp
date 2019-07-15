(load "circuits.scm")
(load-option 'format)

(define (full-adder a b c-in sum c-out)
  (let ((c1 (make-wire)) 
        (c2 (make-wire))
        (s  (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (ripple-carry-adder ak bk sk c-in)
  (if (or (null? ak) (null? bk) (null? sk))
      'done
      (let ((carry (make-wire)))
        (full-adder (car ak)
                    (car bk)
                    c-in 
                    (car sk)
                    carry)
        (ripple-carry-adder (cdr ak)
                           (cdr bk)
                           (cdr sk)
                           carry))))

;; convinience methods to test the adder
(define (build-wires input-signals)
  (if (null? input-signals)
      '()
      (let ((new-wire (make-wire)))
        (set-signal! new-wire (car input-signals))
        (cons new-wire (build-wires (cdr input-signals))))))

(define make-wires build-wires)

(define (get-signals wires)
  (map (lambda (w)
         (get-signal w)) 
       wires))

;; test

;; a
(define a (make-wires '(0 0 1 0 0 0))) ;; 4
(define b (make-wires '(1 1 0 1 0 0))) ;; 11
(define s (make-wires '(0 0 0 0 0 0)))
(define c-in (make-wire))


(get-signals s)
(ripple-carry-adder a b s c-in)
(propagate)
(get-signals s) ;; 15

(for-each (lambda (w)
            (probe 'adder w))
          s)

;; b
;n * full
;
;half = and + or + inv + and = 2*and + or + inv
;full = or + 2 * half
;     = 4*and + 3*or + 2*inv


