;;; init.el --- Fichier de demarrage Emacs pour 2I-0022
;;; Commentary:
;;;   Ne fonctionne que pour Emacs version 24 ou ultérieur
;;;   (c) 2016 D. Béréziat pour la licence d'Informatique de l'UPMC
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialisation de ELPA et ajout du dépôt MELPA ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Installation de 'use-package' pour une gestion
;; de paquets simplifiée
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; installations locales
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;;;;;;;;;;;;;;;;;;;;;;;;
;; Paquets essentiels ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; complétion automatique
(use-package company
  :ensure t
  :config
  (global-company-mode))

;; vérification syntaxique à la volée
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (setq flycheck-indication-mode nil))

;; dépliement/repliement des fonctions et commentaires
;; dans les modes de programmation
(use-package hideshow
  :init (add-hook 'prog-mode-hook 'hs-minor-mode))

;; affichage du symbole de dépliement/repliement dans la marge
(use-package hideshowvis
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'hideshowvis-enable)
  (hideshowvis-symbols)
  :bind (("<backtab>" . hs-toggle-hiding)))

;; touche TAB intelligente: décide entre la complétion et la
;; tabulation
(use-package smart-tab
  :init (global-smart-tab-mode)
  :ensure t)

;; speedbar dans emacs
(use-package sr-speedbar
  :ensure t
  :init
  (setq sr-speedbar-width 20
	sr-speedbar-max-width 20
	sr-speedbar-right-side nil)
  (sr-speedbar-open))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Quelques réglages essentiels  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; supprimer la page d'info d'Emacs
(setq inhibit-splash-screen t)
(setq inhibit-startup-buffer-menu t)

;; afficher l'heure et le numéro de colonne dans la ligne des modes
(display-time)
(column-number-mode)

;; supprimer la barre d'outils
(tool-bar-mode 0)

;; activer les parenthèses intelligentes
(electric-pair-mode)

;; montrer la parenthèse ouvrante
(show-paren-mode)

;; ajouter une ligne vide à la fin d'un buffer
(setq require-final-newline t)

;; utiliser python3 comme interpréteur
(setq python-shell-interpreter "python3")

;;; init.el ends here
