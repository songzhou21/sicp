(define (make-account balance password)
  (let ((count 0))

      (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance 
                         (- balance amount))
                   balance)
            "Insufficient funds"))

      (define (deposit amount)
        (set! balance (+ balance amount))
        balance)

      (define (call-the-cops)
        (error "cops are comming"))

      (define (display-wrong-password-message useless-arg)
        (newline)
        (display "Incorrect password"))

      (define (dispatch test-password m)
        (if (eq? password test-password)
            (begin
              (set! count 0)
              (cond ((eq? m 'withdraw) withdraw)
                    ((eq? m 'deposit) deposit)
                    (else (error "Unknown request: 
                                 MAKE-ACCOUNT" m))))
            (begin 
              (set! count (+ count 1))
              (if (>= count 7)
                  (call-the-cops)
                  display-wrong-password-message))))

      dispatch))

;; test
(define acc
  (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
