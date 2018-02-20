<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: hideshowvis.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="https://www.emacswiki.org/emacs?action=edit;id=hideshowvis.el" /><link type="text/css" rel="stylesheet" href="https://www.emacswiki.org/light.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="https://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: hideshowvis.el" href="https://www.emacswiki.org/emacs?action=rss;rcidonly=hideshowvis.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="https://www.emacswiki.org/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="https://www.emacswiki.org/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="https://www.emacswiki.org/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for hideshowvis.el only"
      href="https://www.emacswiki.org/emacs?action=rss;rcidonly=hideshowvis.el" /><meta content="width=device-width" name="viewport" />
<script type="text/javascript" src="/outliner.0.5.0.62-toc.js"></script>
<script type="text/javascript">

  function addOnloadEvent(fnc) {
    if ( typeof window.addEventListener != "undefined" )
      window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
      window.attachEvent( "onload", fnc );
    }
    else {
      if ( window.onload != null ) {
	var oldOnload = window.onload;
	window.onload = function ( e ) {
	  oldOnload( e );
	  window[fnc]();
	};
      }
      else
	window.onload = fnc;
    }
  }

  // https://stackoverflow.com/questions/280634/endswith-in-javascript
  if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }

  var initToc=function() {

    var outline = HTML5Outline(document.body);
    if (outline.sections.length == 1) {
      outline.sections = outline.sections[0].sections;
    }

    if (outline.sections.length > 1
	|| outline.sections.length == 1
           && outline.sections[0].sections.length > 0) {

      var toc = document.getElementById('toc');

      if (!toc) {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++) {
	  if (divs[i].getAttribute('class') == 'toc') {
	    toc = divs[i];
	    break;
	  }
	}
      }

      if (!toc) {
	var h2 = document.getElementsByTagName('h2')[0];
	if (h2) {
	  toc = document.createElement('div');
	  toc.setAttribute('class', 'toc');
	  h2.parentNode.insertBefore(toc, h2);
	}
      }

      if (toc) {
        var html = outline.asHTML(true);
        toc.innerHTML = html;

	items = toc.getElementsByTagName('a');
	for (var i = 0; i < items.length; i++) {
	  while (items[i].textContent.endsWith('✎')) {
            var text = items[i].childNodes[0].nodeValue;
	    items[i].childNodes[0].nodeValue = text.substring(0, text.length - 1);
	  }
	}
      }
    }
  }

  addOnloadEvent(initToc);
  </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="default"><div class="header"><a class="logo" href="https://www.emacswiki.org/emacs/SiteMap"><img alt="[Home]" class="logo" src="https://www.emacswiki.org/images/logo218x38.png" /></a><div class="menu"><span class="gotobar bar"><a class="local" href="https://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="https://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="https://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="https://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="https://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="https://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="https://www.emacswiki.org/emacs/News">News</a> <a class="local" href="https://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="https://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><form method="get" action="https://www.emacswiki.org/emacs" enctype="multipart/form-data" accept-charset="utf-8" class="search"><p><label for="search">Search:</label> <input type="text" name="search"  size="20" accesskey="f" id="search" /> <label for="searchlang">Language:</label> <input type="text" name="lang"  size="10" id="searchlang" /> <input type="submit" name="dosearch" value="Go!" /></p></form></div><h1><a href="https://www.emacswiki.org/emacs?search=%22hideshowvis%5c.el%22" rel="nofollow" title="Click to search for references to this page">hideshowvis.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="https://www.emacswiki.org/emacs/download/hideshowvis.el">Download</a> <a href="https://github.com/emacsmirror/emacswiki.org/blob/master/hideshowvis.el">Git</a></p><pre>;;; hideshowvis.el --- Add markers to the fringe for regions foldable by hideshow.el
;;
;; Copyright 2008-2012 Jan Rehders
;;
;; Author: Jan Rehders &lt;cmdkeen@gmx.de&gt;
;; Version: 0.5
;; Contributions and bug fixes by Bryan Waite, Michael Heerdegen, John Yates and
;; Matthew Fidler.
;;
;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;
;;
;;; Commentary:
;;
;; This minor mode will add little +/- displays to foldable regions in the
;; buffer and to folded regions. It is indented to be used in conjunction with
;; hideshow.el which is a part of GNU Emacs since version 20.
;;
;; Currently it works for me but is not tested heavily. Please report any bugs
;; to the above email address
;;
;;; Installation:
;; Add the following to your .emacs:
;;
;; (autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
;;
;; (autoload 'hideshowvis-minor-mode
;;   "hideshowvis"
;;   "Will indicate regions foldable with hideshow in the fringe."
;;   'interactive)
;;
;;
;; (dolist (hook (list 'emacs-lisp-mode-hook
;;                     'c++-mode-hook))
;;   (add-hook hook 'hideshowvis-enable))
;;
;; If enabling hideshowvis-minor-mode is slow on your machine use M-x,
;; customize-option, hideshowvis-ignore-same-line and set it to nil. This will
;; then display - icons for foldable regions of one line, too but is faster
;;
;; To enable displaying a + symbol in the fringe for folded regions,
;; use:
;;
;;    (hideshowvis-symbols)
;;
;; in your ~/.emacs
;;
;; It is not enabled by default because it might interfere with custom
;; hs-set-up-overlay functions
;;
;;; Changelog
;;
;; v0.5, 2012-09-11
;; - Made ELPA compliant and added function `hideshowvis-symbols'
;;
;; v0.4, 2012-03-13
;; - fixed bug causing transpose-words to be broken as well as causing problems
;;   when auto-fill-mode was enabled
;;
;; v0.3, 2010-08-26
;; - added autoload cookies
;; - fixed bug causing major mode menu to disappear, among other things
;;
;; v0.2, 2009-08-09
;; - '-' symbol in fringe is clickable
;; - don't show '-' in fringe if the foldable region ends on the same line
;;

(when (fboundp 'define-fringe-bitmap)
  (define-fringe-bitmap 'hideshowvis-hideable-marker [0 0 0 126 126 0 0 0]))

(defconst hideshowvis-version "v0.5" "Version of hideshowvis minor mode")

(defface hideshowvis-hidable-face
  '((t (:foreground "#ccc" :box t)))
  "Face to highlight foldable regions"
  :group 'hideshow)

(defcustom hideshowvis-ignore-same-line t
  "Do not display foldable regions in the fringe if the matching
  closing parenthesis is on the same line. Set this to nil if
  enabling the minor mode is slow on your machine"
  :group 'hideshow)

(defun hideshowvis-highlight-hs-regions-in-fringe (&amp;optional start end old-text-length)
  (when hs-minor-mode
    (save-excursion
      (save-restriction
        (when (and start end)
          (narrow-to-region start end))
        (goto-char (point-min))
        (remove-overlays (point-min) (point-max) 'hideshowvis-hs t)
        (while (search-forward-regexp hs-block-start-regexp nil t)
          (let* ((ovl (make-overlay (match-beginning 0) (match-end 0)))
                 (marker-string "*hideshowvis*")
                 (doit
                  (if hideshowvis-ignore-same-line
                      (let (begin-line)
                        (setq begin-line
                              (save-excursion
                                (goto-char (match-beginning 0))
                                (line-number-at-pos (point))))
                        (save-excursion
                          (goto-char (match-beginning 0))
                          (ignore-errors
                            (progn
                              (funcall hs-forward-sexp-func 1)
                              (&gt; (line-number-at-pos (point)) begin-line)))))
                    t)))
            (when doit
              (put-text-property 0
                                 (length marker-string)
                                 'display
                                 (list 'left-fringe
                                       'hideshowvis-hideable-marker
                                       'hideshowvis-hidable-face)
                                 marker-string)
              (overlay-put ovl 'before-string marker-string)
              (overlay-put ovl 'hideshowvis-hs t))))))))

;;;###autoload
(defun hideshowvis-click-fringe (event)
  (interactive "e")
  (mouse-set-point event)
  (end-of-line)
  (if (save-excursion
        (end-of-line 1)
        (or (hs-already-hidden-p)
            (progn
              (forward-char 1)
              (hs-already-hidden-p))))
      (hs-show-block)
    (hs-hide-block)
    (beginning-of-line)))

(defvar hideshowvis-mode-map
  (let ((hideshowvis-mode-map (make-sparse-keymap)))
    (define-key hideshowvis-mode-map [left-fringe mouse-1]
      'hideshowvis-click-fringe)
    hideshowvis-mode-map)
  "Keymap for hideshowvis mode")

;;;###autoload
(define-minor-mode hideshowvis-minor-mode ()
  "Will indicate regions foldable with hideshow in the fringe."
  :init-value nil
  :require 'hideshow
  :group 'hideshow
  :keymap hideshowvis-mode-map
  (condition-case nil
      (if hideshowvis-minor-mode
          (progn
            (hs-minor-mode 1)
            (hideshowvis-highlight-hs-regions-in-fringe (point-min) (point-max) 0)
            (add-to-list 'after-change-functions
                         'hideshowvis-highlight-hs-regions-in-fringe))
        (remove-overlays (point-min) (point-max) 'hideshowvis-hs t)
        (setq after-change-functions
              (remove 'hideshowvis-highlight-hs-regions-in-fringe
                      after-change-functions)))
    (error
     (message "Failed to toggle hideshowvis-minor-mode")
     )))

;;;###autoload
(defun hideshowvis-enable ()
  "Will enable hideshowvis minor mode"
  (interactive)
  (hideshowvis-minor-mode 1))

;;;###autoload
(defun hideshowvis-symbols ()
  "Defines the things necessary to get a + symbol in the fringe
and a yellow marker indicating the number of hidden lines at
the end of the line for hidden regions."
  (interactive)
  
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'hs-marker [0 24 24 126 126 24 24 0]))
  
  (defcustom hs-fringe-face 'hs-fringe-face
    "*Specify face used to highlight the fringe on hidden regions."
    :type 'face
    :group 'hideshow)
  
  (defface hs-fringe-face
    '((t (:foreground "#888" :box (:line-width 2 :color "grey75" :style released-button))))
    "Face used to highlight the fringe on folded regions"
    :group 'hideshow)
  
  (defcustom hs-face 'hs-face
    "*Specify the face to to use for the hidden region indicator"
    :type 'face
    :group 'hideshow)
  
  (defface hs-face
    '((t (:background "#ff8" :box t)))
    "Face to hightlight the ... area of hidden regions"
    :group 'hideshow)
  
  (defun display-code-line-counts (ov)
    (when (eq 'code (overlay-get ov 'hs))
      (let* ((marker-string "*fringe-dummy*")
             (marker-length (length marker-string))
             (display-string (format "(%d)..." (count-lines (overlay-start ov) (overlay-end ov))))
             )
        (overlay-put ov 'help-echo "Hiddent text. C-c,= to show")
        (put-text-property 0 marker-length 'display (list 'left-fringe 'hs-marker 'hs-fringe-face) marker-string)
        (overlay-put ov 'before-string marker-string)
        (put-text-property 0 (length display-string) 'face 'hs-face display-string)
        (overlay-put ov 'display display-string)
        )))
  
  (setq hs-set-up-overlay 'display-code-line-counts))

(provide 'hideshowvis)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hideshowvis.el ends here</pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="translation bar"><br />  <a class="translation new" href="https://www.emacswiki.org/emacs?action=translate;id=hideshowvis.el;missing=de_es_fr_it_ja_ko_pt_ru_se_uk_zh" rel="nofollow">Add Translation</a></span><div class="edit bar"><a accesskey="c" class="comment local" href="https://www.emacswiki.org/emacs/Comments_on_hideshowvis.el">Talk</a> <a accesskey="e" class="edit" href="https://www.emacswiki.org/emacs?action=edit;id=hideshowvis.el" rel="nofollow" title="Click to edit this page">Edit this page</a> <a class="history" href="https://www.emacswiki.org/emacs?action=history;id=hideshowvis.el" rel="nofollow">View other revisions</a> <a class="admin" href="https://www.emacswiki.org/emacs?action=admin;id=hideshowvis.el" rel="nofollow">Administration</a></div><div class="time">Last edited 2017-02-27 20:50 UTC by <a class="author" href="https://www.emacswiki.org/emacs/SeanFarley" title="72.211.92.186">SeanFarley</a> <a class="diff" href="https://www.emacswiki.org/emacs?action=browse;diff=2;id=hideshowvis.el" rel="nofollow">(diff)</a></div><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a class="licence" href="https://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="https://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="https://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="https://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="https://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="https://creativecommons.org/">CreativeCommons</a>
<a href="https://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
<p class="legal" style="padding-top: 0.5em">Please note our <a href="Privacy">Privacy Statement</a>.</p>
</div>
</body>
</html>
