;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |431 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
bundle s n

the algorithm have two trivialy solvable problem, first when s is an
empty list and second when the length of s is less than or equal to n.

when s is an empty list, the expected output will also be an empty list.
when the length of s is less than or equal to n, the algorithm solve it by
creating a list of s.

the algorithm generate one new problem, that create a list like s with the
first n item droped.

we combine the solution with the newly generated problem, with cons we get
the original problem solution.
;============================================================================;

quick-sort< alon

the algorithm have two trilvialy solvable problem, first when alon is empty,
and second when alon is a list of one item.

for both case the algoritm solve it by simply returning the value of alon.

the algorithm generate two new problem, one that create a list that its items
are some items from alon such that n is less than the first item of alon, and
the other that create a list that its items are some items from alon such that
n is more than the first item of alon.