{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Michael Elsd�rfer.
All Rights Reserved.

$Id$

You may retrieve the latest version of this file at the Corporeal
Website, located at http://www.elsdoerfer.info/corporeal

Known Issues:
-----------------------------------------------------------------------------}

{
    This is a template for the VersionInfoBuild.inc file, which will
    be created, based on this file, during the build process, and will
    contain the latest and up-to-date version information.

    Currently, the variables used in this file are directly
    from the FinalBuilder project. 

    See VersionInfoIDE.inc
}

const
  APP_VERSION_MAJOR    = %VersionMajor%;
  APP_VERSION_MINOR    = %VersionMinor%;
  APP_VERSION_IDENT    = '%VersionIdent%';
  APP_VERSION_BUILD    = %VersionBuild%;
  APP_VERSION_NAME     = '';

// include version info resource (also generated by build procesas)
{$R 'VersionInfo.res' 'VersionInfo.rc'}  
