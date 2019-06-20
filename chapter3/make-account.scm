(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch test-password m)
    (if (not (eq? password test-password))
        (error "Incorrect password"))

    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))

  dispatch)

;; test
(define acc
  (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)