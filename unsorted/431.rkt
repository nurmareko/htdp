;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |431|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
list->chunks

the function have two trivially solvable problem,one that when the
given input is an empty list, and the other is when the given list
length are less than n

when the given input is an empty list the expected output will also
be an empty list, and when the given list length are less than n
the function solve it by creating a list of s

the function generate two new problems, one that need to take the 
first n item in s, and the other that drop the first n item in s
to be reccur

we combine the solution of take with reccursion that process the
solution of drop, using cons we get the desired answer
===================================================================

quick-sort<

the function can solve the input trivially if the input are empty
list or a list of one item

when given empty list the expected output will be an empty list,
when given list of length one the expected output will be itself
because a one item list is already sorted

the algorithm generate two more problem that is it create list of
smaller and larger item from pivot item 