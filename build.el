(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;;; org-export
(setq
 org-export-allow-bind-keywords t
 org-export-default-language "en"
 org-export-with-clocks t
 org-export-with-date t
 org-export-with-emphasis t
 org-export-with-footnotes t
 org-export-with-drawers t
 org-export-with-planning t
 org-export-with-properties t
 org-export-with-priorities t
 org-export-with-smart-quotes t
 org-export-with-timestamps t
 org-export-with-todo-keywords t
)

;;; org-html output
(setq
 org-html-checkbox-type 'html
 org-html-container-elment "main"
 org-html-doctype "html5"
 org-html-equation-reference-format "\\eqref{%s}"
 org-html-head-include-default-style nil
 org-html-head-include-scripts nil
 org-html-head "<link href=\"https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap\" rel=\"stylesheet\">"
 org-html-link-use-abs-url t
 org-html-self-link-headlines t
 org-html-validation-link nil
)

;;; org publish

(setq org-publish-project-alist
  '(
  ;;; website
		("website-org"
		:auto-sitemap t
		:base-directory "./content"
		:publishing-directory "./output"
		:publishing-function org-html-publish-to-html
		:makeindex t
		:recursive t
		:sitemap-filename "sitemap.org"
		:sitemap-title "Sitemap")

		("website-public"
		:base-directory "./content/public"
		:base-extension "png\\|jpg\\|webloc\\|pdf\\|svg"
		:publishing-directory "./output/public"
		:publishing-function org-publish-attachment)

		("website-src"
		:base-directory "./src"
		:base-extension "css"
		:publishing-directory "./output"
		:publishing-function org-publish-attachment)

		("website" :components("website-org" "website-public" "website-src"))
	)
)

; https://stackoverflow.com/a/25057678
(defun preamble-static (plist) (format "<embed src=\"public/logo.svg\" width=\"100%%\" height=\"50px\" />"))
(defun preamble-animated (plist) (format "<embed src=\"public/logo-animated.svg\" width=\"100%%\" height=\"50px\" />"))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")