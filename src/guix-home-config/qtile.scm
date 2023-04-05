(use-modules (guix packages)
             (guix build-system python)
             (guix download)
             (guix gexp)
             (guix git-download)
             (gnu packages check)
             (gnu packages glib)
             (gnu packages gtk)
             (gnu packages libffi)
             (gnu packages mpd)
             (gnu packages freedesktop)
             (gnu packages pkg-config)
             (gnu packages python)
             (gnu packages python-build)
             (gnu packages python-crypto)
             (gnu packages python-xyz)
             (gnu packages pulseaudio)
             (gnu packages time)
             (gnu packages python-xyz)
             (gnu packages pulseaudio)
             (gnu packages time)
             ((guix licenses) #:prefix license:))

(package
 (name "qtile")
 (version "0.22.1")
 (source
  (origin
   (method url-fetch)
   (uri (pypi-uri "qtile" version))
   (sha256
    (base32 "12wg8y33xgb0x0gd9xfylxss97p97dy1cy52yln64493fi6wphr7"))))
 (build-system python-build-system)
 (arguments
  `(#:tests? #f ; Tests require Xvfb and writable temp/cache space
    #:phases
    (modify-phases
     %standard-phases
     (add-after
      'unpack 'patch-paths
      (lambda*
       (#:key inputs #:allow-other-keys)
       (substitute* "libqtile/pangocffi.py"
                    (("^gobject = ffi.dlopen.*")
                     (string-append "gobject = ffi.dlopen(\""
                                    (assoc-ref inputs "glib") "/lib/libgobject-2.0.so.0\")\n"))
                    (("^pango = ffi.dlopen.*")
                     (string-append "pango = ffi.dlopen(\""
                                    (assoc-ref inputs "pango") "/lib/libpango-1.0.so.0\")\n"))
                    (("^pangocairo = ffi.dlopen.*")
                     (string-append "pangocairo = ffi.dlopen(\""
                                    (assoc-ref inputs "pango") "/lib/libpangocairo-1.0.so.0\")\n")))))
     (add-after
      'install 'install-xsession
      (lambda*
       (#:key outputs #:allow-other-keys)
       (let* ((out (assoc-ref outputs "out"))
              (xsessions (string-append out "/share/xsessions"))
              (qtile (string-append out "/bin/qtile start")))
         (mkdir-p xsessions)
         (copy-file "resources/qtile.desktop" (string-append xsessions "/qtile.desktop"))
         (substitute* (string-append xsessions "/qtile.desktop")
                      (("qtile start") qtile))))))))
 (inputs
  (list glib pango pulseaudio))
 (propagated-inputs
  (list python-cairocffi
        python-cffi
        python-dateutil
        python-dbus-next
        python-iwlib
        python-keyring
        python-mpd2
        python-pyxdg
        python-xcffib))
 (native-inputs
  (list pkg-config
        python-flake8
        python-pep8-naming
        python-psutil
        python-pytest-cov
        python-setuptools-scm))
 (home-page "http://qtile.org")
 (synopsis "Hackable tiling window manager written and configured in Python")
 (description "Qtile is simple, small, and extensible.  It's easy to write
your own layouts, widgets, and built-in commands.")
 (license license:expat))
