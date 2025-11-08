(import (rnrs))

(define (divisible-by? a b)
  (= (remainder a b) 0))

(define (leap-year? year)
  (and
      (divisible-by? year 4)
      (or
            (not (divisible-by? year 100))
            (divisible-by? year 400))))


