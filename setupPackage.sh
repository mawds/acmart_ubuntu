#!/bin/bash

# Script to prepare the package structure for the deb


wget https://www.acm.org/binaries/content/assets/publications/consolidated-tex-template/acmart.zip

pkgroot=acmart_1.33-0
TEXMF=`kpsewhich -var-value TEXMFLOCAL`
# clean up previous attempt
rm -r $pkgroot 
rm -r acmart

clsloc=${pkgroot}/${TEXMF}/tex
 
mkdir -p $clsloc
unzip acmart.zip

cd acmart

latex acmart.ins

cp *.cls *.bst ../$clsloc

cd ..

# Setup control file
mkdir $pkgroot/DEBIAN
# Dependencies may not be optional

cat << EOF > ${pkgroot}/DEBIAN/control
Package: acmart
Version: 1.33-0
Section: base
Priority: optional
Architecture: all
Depends: texlive-latex-base (>= 2013.20140215-1), texlive-fonts-extra (>=2013.20140215-2), texlive-generic-extra (>= 2013.20140215-1), texlive-science (>= 2013.20140215-1)
Maintainer: David Mawdsley <david.mawdsley@manchester.ac.uk> 
Description: ACM LaTeX style files.  
EOF

# Post install script - rebuild cache
cat <<EOF > $pkgroot/DEBIAN/postinst
#!/bin/bash
mktexlsr
EOF

chmod a+x ${pkgroot}/DEBIAN/postinst

dpkg-deb --build ${pkgroot}


