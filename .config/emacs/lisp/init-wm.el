;;; -*- lexical-binding: t; -*-

;;; Section: Windows Management.

(require 'init-packaging)
;; (eval-when-compile
;;   (require 'perspective))
(eval-when-compile
  (require 'lib-keybinding))

;;; - VTerm
;; (use-package vterm
;;   :straight '(vterm :type built-in)
;;   :commands (vterm-mode)
;;   :config
;;   (add-hook
;;    'vterm-mode-hook
;;    (lambda ()
;;      (setq display-line-numbers nil)
;;      (setq show-trailing-whitespace nil))))
;; 
;; (use-package multi-vterm
;;   :commands (multi-vterm))

;; (use-package perspective-exwm
;;   :after (perspective)
;;   :defer t
;;   :commands (perspective-exwm-mode))

;;; - exwm
;; (use-package exwm
;;   :hook ((before-init . exwm-enable))
;;   :init
;;   (require 'cl-lib)
;;   (require 'lib-wm)
;;   :config
;;   (require 'exwm-randr)
;;   (exwm-randr-enable)
;;   (require 'exwm-config)
;;   (require 'exwm-xim)
;;   (exwm-xim-enable)
;; 
;;   ;; Panel
;;   (defvar efs/polybar-process nil
;;     "Holds the process of the running Polybar instance, if any")
;;   (defun efs/kill-panel ()
;;     (interactive)
;;     (when efs/polybar-process
;;       (ignore-errors
;;         (kill-process efs/polybar-process)))
;;     (setq efs/polybar-process nil))
;;   (defun efs/start-panel ()
;;     (interactive)
;;     (efs/kill-panel)
;;     (setq efs/polybar-process (start-process-shell-command "polybar" nil "polybar panel")))
;;   (defun efs/send-polybar-hook (module-name hook-index)
;;     (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))
;;   (defun efs/send-polybar-exwm-workspace ()
;;     (efs/send-polybar-hook "exwm-workspace" 1))
;;   (defun my-wm:exwm-init-hook ()
;;     ;; Reload perspectives
;;     ;;(persp-mode t)
;;     ;;(perspective-exwm-mode t)
;;     ;;(persp-state-load persp-state-default-file)
;;     ;; Start the Polybar panel
;;     ;;(efs/start-panel)
;;     )
;;   ;; Update panel indicator when workspace changes
;;   (add-hook 'exwm-workspace-switch-hook #'efs/send-polybar-exwm-workspace)
;;   (add-hook 'exwm-init-hook #'my-wm:exwm-init-hook)
;; 
;;   ;; All buffers created in EXWM mode are named "*EXWM*". You may want to
;;   ;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
;;   ;; are run when a new X window class name or title is available.  Here's
;;   ;; some advice on this topic:
;;   ;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
;;   ;; + For applications with multiple windows (e.g. GIMP), the class names of
;;                                         ;    all windows are probably the same.  Using window titles for them makes
;;   ;;   more sense.
;;   ;; In the following example, we use class names for all windows except for
;;   ;; Java applications and GIMP.
;;   (add-hook 'exwm-update-class-hook
;;             (lambda ()
;;               (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
;;                           (string= "gimp" exwm-instance-name))
;;                 (exwm-workspace-rename-buffer exwm-class-name))))
;;   (add-hook 'exwm-update-title-hook
;;             (lambda ()
;;               (exwm-workspace-rename-buffer exwm-title)))
;; 
;;   ;; Clear exwm-mode-map
;;   (setq exwm-mode-map (make-sparse-keymap))
;; 
;;   ;; To add a key binding only available in line-mode, simply define it in
;;   ;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
;;   ;; (define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
;; 
;;   ;; The following example demonstrates how to use simulation keys to mimic
;;   ;; the behavior of Emacs.  The value of `exwm-input-simulation-keys` is a
;;   ;; list of cons cells (SRC . DEST), where SRC is the key sequence you press
;;   ;; and DEST is what EXWM actually sends to application.  Note that both SRC
;;   ;; and DEST should be key sequences (vector or string).
;;   (setq exwm-input-simulation-keys '())
;;   :custom
;;   (exwm-workspace-show-all-buffers t)
;;   (exwm-layout-show-all-buffers t)
;;   (exwm-workspace-number 1)
;;   ;; (exwm-workspace-minibuffer-position 'bottom)
;;   ;; I don't want any prefix keys in line-mode for now
;;   (exwm-input-prefix-keys '())
;; 
;;   ;; Config for specific applications
;;   (exwm-manage-configurations
;;    '(((member exwm-class-name '("firefox"))
;;       line-mode t)))
;; 
;;   ;; Global keybindings can be defined with `exwm-input-global-keys'.
;;   ;; Here are a few examples:
;;   (exwm-input-global-keys
;;    `(
;;      ;; Bind "s-r" to exit char-mode and fullscreen mode.
;;      ([?\s-r] . exwm-reset)
;;      ;; Bind "s-w" to switch workspace interactively.
;;      ([?\s-w] . exwm-workspace-switch)
;;      ;;;; Bind "s-0" to "s-9" to switch to a workspace by its index.
;;      ;;,@(cl-mapcar (lambda (key idx)
;;      ;;               `(,(kbd (format "s-%s" key)) .
;;      ;;                 (lambda ()
;;      ;;                   (interactive)
;;      ;;                   (exwm-workspace-switch-create ,idx))))
;;      ;;             (append '("`") (number-sequence 1 9) '(0))
;;      ;;             (number-sequence 0 10))
;;      ;;;; Bind "s-0" to "s-9" to switch to a workspace by its index.
;;      ;;,@(cl-mapcar (lambda (key idx)
;;      ;;               `(,(kbd (format "s-%s" key)) .
;;      ;;                 (lambda ()
;;      ;;                   (interactive)
;;      ;;                   (exwm-move-window-to-workspace ,idx))))
;;      ;;             '("~" "!" "@" "#" "$" "%" "^" "&" "*" "(" ")")
;;      ;;             (number-sequence 0 10))
;;      ;; Move between windows
;;      (,(kbd "s-h") . windmove-left)
;;      ([s-left] . windmove-left)
;;      (,(kbd "s-l") . windmove-right)
;;      ([s-right] . windmove-right)
;;      (,(kbd "s-k") . windmove-up)
;;      ([s-up] . windmove-up)
;;      (,(kbd "s-j") . windmove-down)
;;      ([s-down] . windmove-down)
;;      ;; Swap windows
;;      (,(kbd "s-H") . windmove-swap-states-left)
;;      (,(kbd "s-J") . windmove-swap-states-down)
;;      (,(kbd "s-K") . windmove-swap-states-up)
;;      (,(kbd "s-L") . windmove-swap-states-right)
;;      ;; Split windows
;;      (,(kbd "s-t") . split-window-right)
;;      (,(kbd "s-v") . split-window-below)
;;      ;; Float & Full screen
;;      (,(kbd "s-f") . exwm-layout-toggle-fullscreen)
;;      (,(kbd "s-F") . exwm-floating-toggle-floating)
;;      ;; Bind "s-&" to launch applications ('M-&' also works if the output
;;      ;; buffer does not bother you).
;;      ;; ([?\s-&] . (lambda (command)
;;      ;;              (interactive (list (read-shell-command "$ ")))
;;      ;;              (start-process-shell-command command nil command)))
;;      (,(kbd "s-d") . (lambda ()
;;                        (interactive)
;;                        (let ((process-connection-type nil))  ; use a pipe
;;                          (start-process "rofi" nil "rofi" "-show-icons" "-show" "drun"))))
;;      (,(kbd "s-<return>") . multi-vterm)
;;      (,(kbd "s-q") . (lambda ()
;;                        (interactive)
;;                        (if (or (derived-mode-p 'exwm-mode)
;;                                (derived-mode-p 'vterm-mode))
;;                            (kill-buffer-and-window)
;;                          (delete-window))))
;;      (,(kbd "s-<tab>") . (lambda ()
;;                            (interactive)
;;                            (let ((process-connection-type nil))  ; use a pipe
;;                              (start-process "rofi" nil "rofi" "-show-icons" "-show" "window"))))
;;      ;; Bind "s-<f2>" to "slock", a simple X display locker.
;;      (,(kbd "s-<f2>") . (lambda ()
;;                           (interactive)
;;                           (start-process "" nil "/usr/bin/slock")))
;;      (,(kbd "C-<SPC>") . toggle-input-method)
;;      (,(kbd "s-x") . execute-extended-command)
;;      (,(kbd "s-<SPC>") . my:space-leader-command))))

(use-package posframe)

;; (use-package pyim
;;   :init
;;   :custom
;;   (default-input-method "pyim")
;;   (pyim-default-scheme 'wubi)
;;   (pyim-dicts
;;    `((:name "my-wubi" :file ,(expand-file-name "etc/my-wubi.pyim" user-emacs-directory)))))
;; 
;; (use-package pyim-basedict
;;   :config
;;   (pyim-basedict-enable))
;; 
;; (use-package pyim-wbdict
;;   :config
;;   (pyim-wbdict-v86-enable))

(use-package rime
  :general
  ("C-SPC" 'toggle-input-method)
  ;; :straight '(rime :type built-in)
  :custom
  (rime-show-candidate 'posframe)
  (rime-share-data-dir "~/.local/share/fcitx5/rime")
  (default-input-method "rime"))

;; (use-package sis
;;   :config
;;   (sis-ism-lazyman-config "1" "2" 'fcitx5)
;;   ;; enable the /cursor color/ mode
;;   (sis-global-cursor-color-mode t)
;;   ;; enable the /respect/ mode
;;   (sis-global-respect-mode t)
;;   ;; enable the /context/ mode for all buffers
;;   (sis-global-context-mode t)
;;   ;; enable the /inline english/ mode for all buffers
;;   (sis-global-inline-mode t))

;; (use-package doom-themes
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-opera-light t)
;;
;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

;; Doom emacs themes has problem showing gray fonts.
;; Try high-contrast themes.
(use-package modus-themes
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi))

(use-package doom-modeline
  :hook (emacs-startup . doom-modeline-mode)
  :config
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-github t))

(use-package all-the-icons)

;; (use-package mini-modeline
;;   :hook (emacs-startup . mini-modeline-mode))

;; (use-package desktop-environment
;;   :diminish t
;;   :hook (emacs-startup . desktop-environment-mode)
;;   :general
;;   (:keymaps 'desktop-environment-mode-map
;;    "s-l" #'windmove-right)
;;   :custom
;;   (desktop-environment-brightness-small-increment "2%+")
;;   (desktop-environment-brightness-small-decrement "2%-")
;;   (desktop-environment-brightness-normal-increment "5%+")
;;   (desktop-environment-brightness-normal-decrement "5%-"))

(use-package ranger
  :hook (emacs-startup . ranger-override-dired-mode))

(use-package solaire-mode
  :init
  (add-hook
   'emacs-startup-hook
   (lambda ()
     (solaire-global-mode +1))))

;; (use-package mini-frame
;;   :hook (emacs-startup . mini-frame-mode))

(provide 'init-wm)
