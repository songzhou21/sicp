(define (f n)
  (f-iter 2 1 0 0 n)
 )


(define (f-iter a b c i n)
  (if (= i n)
      c
      (f-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (+ i 1)
              n)
      )
  )

(f 5)
