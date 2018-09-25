#!/bin/bash
#    ci.sh
#    version 0.01
#
#    copyright (c) 2004, Chris Lale <chrislale@coolscience.co.uk>
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of the GNU General Public License 
#    as published by the Free Software Foundation.
#
#    This program is distributed in the hope that it will be 
#    useful' but WITHOUT ANY WARRANTY; without even the implied 
#    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
#    PURPOSE. See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
#    MA  02111-1307  USA
#
#    http://www.gnu.org/copyleft/gpl.html
#
#    On Debian systems, you can find the complete text of the GNU 
#    General Public License may be found in 
#
#    /usr/share/common-licenses/GPL.
#
#
# About this script
# -----------------
# This script uses sudo to run checkinstall on a Debian system. 
# Checkinstall is used to install software compiled from a tarball.
# It creates a .deb package file and installs it, keeping track of 
# files added to your system, and making a backup of your 
# system's original files. This script runs checkinstall and 
# passes options to it. 
#
# Before running this script
# --------------------------
# You must extract the files from the tarball, and place this 
# script in the directory immediately above the extracted files 
# (ie the same directory as the tarball itself). You must make 
# sure that this script file is executable (chmod u+x ci.sh). You
# must also configure sudo so that a particular normal user may 
# run checkinstall as the superuser.
#
# How to use this script
# ----------------------
# You must edit the options to suit your installation. You may 
# also need to edit the 'make install' statement if the software 
# you are installing uses a variation on this command. The script
# assumes that the description-pak file and the doc-pak directory
# needed by checkinstall are in the same directory as this script
# file.
#
# Place a suitably modified version of this script in the
# directory containing the working directory. Run the script, as 
# a normal user, from the working directory. The working 
# directory will be immediately below the script. Move to the 
# working directory and execute '../ci.sh' without the quotes.
#
# Detailed instructions
# ---------------------
# You can find detailed guide in the article called 'Installing 
# from tarballs using checkinstall' at 
#
#     http://newbiedoc.sourceforge.net.
#
#------------------- script starts here -------------------------
#
# Copy the description file description-pak and document directory
# doc-pak into the top of the build directory. If doc-pak or 
# description-pak exist in the build directory, remove them first.
#
if [ -f description-pak ]; then rm --force description-pak; fi
cp ../description-pak ./
if [ -d doc-pak ]; then rm --force --recursive doc-pak; fi
cp --recursive ../doc-pak ./
#
#----------------- not edit above this line ---------------------
#
# Use sudo to run checkinstall as the superuser. Change these 
# options to suit the tarball's particular COMPILE and INSTALL 
# needs.
#
checkinstall \
     --type=debian \
     --maintainer='steven' \
     --pkgname='omniorb' \
     --pkgversion='4.2.2' \
     --pkgrelease='st-1' \
     --pkglicense='Copyright 1996-2002 author. GNU General Public \
License. See COPYING' \
     --arch='amd64' \
     --pkgsource='/\
     omniORB-4.2.2.tar.bz2' \
     --pkgaltsource='https://sourceforge.net/projects/omniorb/\
     files/omniORB/omniORB-4.2.2/\
     omniORB-4.2.2.tar.bz2' \
     --bk \
     --backup='yes' \
     -D make install
#
#------------------- Do not edit below this line -----------------
# move backup file(s) to a safe location (the directory above the
# source directory). This allows the source directory to be deleted 
# safely.
#
if ! [ -f backup-* ]; 
then 
        echo Original files were not backed-up.; 
        echo ;
else
        echo Moving backup file one level up from ;
        pwd;
        echo ;
        mv ./backup-* ../;
fi
# Invalidate the user's timestamp by setting the time on it to the
# epoch. The next time sudo is run, a password will be required. 
# This makes accidental use of any permitted commands less likely.
#
#sudo -k
