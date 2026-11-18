;;; sample.el --- A buffer to showcase the theme -*- lexical-binding: t -*-

;; A small sample with enough syntax features to show off a theme:
;; comments, strings, numbers, keywords, defun, lambda, let, quote,
;; symbols, and a docstring.

(defconst sample/answer 42
  "The answer to the Ultimate Question of Life.")

(defun sample/greet (name &optional greeting)
  "Greet NAME with an optional GREETING."
  (let ((msg (format "%s, %s! (%d)" (or greeting "Hello") name sample/answer)))
    (message msg)
    msg))

;; A lambda with a closure and some arithmetic.
(defvar sample/square (lambda (x) (* x x))
  "Square a number.")

;; Quoted data, symbols, and a keyword argument.
(setq sample/config
      '(:name "flatui-dark"
        :colors ("#1abc9c" "#3498db" "#e74c3c")
        :dark t))
