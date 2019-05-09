#lang sicp

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init ??FILL-THIS-IN??)
            (accumulate-n op init ??FILL-THIS-IN??))))

;: (accumulate-n + 0 s)