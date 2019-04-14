;;; b^0 = 1
;;; b^1 = b
;;; (b^(n/2))^2 = (b^2)^n/2
;;;
;;;
;;; b8 = (b4)2
;;; b4 = (b2)2
;;; b2 = (b1)2
;;; b1 = b * 1
;;;
;;; a*b^n unchanged
;;;
;;; f(2,8,a)
;;; f(4,4,a)
;;; f(16,2,a)
;;; f(256,1,a)
;;; f(2,0,256)
;;; 256
;;;
;;; f(2,9,a)
;;; f(2,8,2)
;;; f(4,4,2)
;;; f(16,2,2)
;;; f(256,1,2)
;;; f(2,0,2*256)
;;; 2 * 256

(define (expt-iter b n a)
    (cond ((= n 0)
           a)
          ((even? n)
           (expt-iter (square b) 
                      (/ n 2)
                      a
                      ))
          ((odd? n)
           (expt-iter b
                      (- n 1)
                      (* a b)
                      ))
      )
  )

(define (fast-expt b n)
    (expt-iter b n 1)
  )
