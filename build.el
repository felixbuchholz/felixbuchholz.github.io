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
(setq org-link-file-path-type 'adaptive)

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
 org-html-head "<link href=\"https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css\" rel=\"stylesheet\">"
 org-html-html5-fancy t
 org-html-link-use-abs-url t
 org-html-postamble t
 org-html-self-link-headlines t
 org-html-validation-link nil
)

(setq my-org-preamble-static "<a id=\"nav-link-logo\" href=\"/\" target=\"_self\"><embed id=\"logo\" src=\"public/logo.svg\" width=\"100%%\" height=\"50px\" /></a><nav><ul id=\"nav-main-ul\"><li class=\"nav-li\"><a href=\"/\">Home</a>, </li><li class=\"nav-li\"><a href=\"/sitemap.html\">Sitemap</a>, </li><li class=\"nav-li\"><a href=\"/theindex.html\">Index</a></li></ul></nav>")
(setq my-org-preamble-animated "<a id=\"nav-link-logo\" href=\"/\" target=\"_self\"><embed id=\"logo\" src=\"public/logo-animated.svg\" width=\"100%%\" height=\"50px\" /></a><nav><ul id=\"nav-main-ul\"><li class=\"nav-li\"><a href=\"/\">Home</a>, </li><li class=\"nav-li\"><a href=\"/sitemap.html\">Sitemap</a>, </li><li class=\"nav-li\"><a href=\"/theindex.html\">Index</a></li></ul></nav>")

; https://stackoverflow.com/a/25057678
(defun preamble-static (plist) (format my-org-preamble-static))
(defun preamble-animated (plist) (format my-org-preamble-animated))

(setq org-html-postamble-format
      '(("en" "<div id=\"footer\"><nav id=\"nav-footer\"><ul id=\"nav-footer-ul\"><li class=\"nav-li\"><a href=\"#preamble\">Top</a>, </li><li class=\"nav-li\"><a href=\"/\">Home</a>, </li><li class=\"nav-li\"><a href=\"/sitemap\">Sitemap</a>, </li><li class=\"nav-li\"><a href=\"/theindex\">Index</a>, </li><li class=\"nav-li\"><a href=\"/imprint\">Imprint</a></li></ul></nav><div class=\"date\">Updated: %C</div></div>")))

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
			:sitemap-filename "sitemap-base.org"
			:sitemap-title "Sitemap"
			)
			("website-public"
			:base-directory "./content/"
			:base-extension "png\\|jpg\\|webloc\\|pdf\\|svg"
			:publishing-directory "./output/"
			:publishing-function org-publish-attachment
			:recursive t
			)
			("website-src"
			:base-directory "./src"
			:base-extension "css"
			:publishing-directory "./output"
			:publishing-function org-publish-attachment
			)
			("website" :components("website-org" "website-public" "website-src")
			)
	)
)


;; Generate the site output
(org-publish-all t)

(message "Build complete!")
