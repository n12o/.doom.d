;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Droid Sans Mono" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;
;;
(after! projectile-mode projectile-register-project-type 'graphql'(".graphqlconfig")
                                  :project-file ".graphqlconfig"
                                  :compile "npm install"
                                  :test "npm test"
                                  :run "npm start"
                                  :test-suffix ".test")

(defconst my-graphql/proj-path "~/scratches/graphql")
(defconst my-graphql/config-path (concat (file-name-as-directory my-graphql/proj-path) ".graphqlconfig"))

(defun my-graphqul/copy-token ()
  "If current buffer contains token syntax. Put token into file at `my-graphql/config-path'."
  (interactive)
  (let ((token
         (string-trim
          (with-output-to-string
            (goto-char (point-min))
            (save-excursion
              (re-search-forward "\"id_token\": \\(\".*\"\\)" nil t)
                  (princ (match-string-no-properties 1)))))))
    (with-temp-file
        my-graphql/config-path
      (insert-file-contents my-graphql/config-path)
      (when
      (re-search-forward "\"Authorization\":.*" nil t)
        (replace-match (concat  "\"Authorization\":" " " token))))))

;;(add-hook! 'restclient-response-received-hook #'my-graphqul/copy-token)
