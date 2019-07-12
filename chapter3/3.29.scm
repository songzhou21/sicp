(load "circuits.scm")

(define (or-gate a1 a2 output)
  (let ((b (make-wire))
        (c (make-wire))
        (d (make-wire)))
    (inverter a1 b)
    (inverter a2 c)
    (and-gate b c d)
    (inverter d output)
    'ok))

;; delay = 3*inverter-delay + and-gate-delay

;; test
(define output (make-wire))

(or-gate input-1 input-2 output)

(propagate)

(get-signal output)
(set-signal! input-1 1)

(propagate)

(get-signal output)

