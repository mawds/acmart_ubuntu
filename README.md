# acmart_ubuntu
Script to package the current ACM master article template for Ubuntu

This script downloads the ACM master article template from https://www.acm.org/publications/proceedings-template and packages it into a .deb file for Ubuntu (and probably Debian too)

I wrote it for myself; it contains no error checking etc. Use it at your own risk.

## To use

Clone the repository and run `./setupPackage.sh`

The script will downlaod the template file, generate the class file, move it to the local treee and run mktexlsr. 

The package can then be installed with  `sudo dpkg-i acmart_1.33-0.deb`, possibly followed by `sudo apt-get -f install` if you have unmet dependencies

