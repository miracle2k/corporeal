{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Michael Elsdörfer.
All Rights Reserved.

$Id$

You may retrieve the latest version of this file at the Patronus
Website, located at http://www.elsdoerfer.info/patronus

Known Issues:
-----------------------------------------------------------------------------}

{
    This is the content of VersionInfo.pas - it's included there if
    we build from the IDE.

    It contains fake version data (maybe updated once in a while),
    and does not put version information into the exe via a RC file.

    It mainly exists so we can compile & test from the IDE without a hassle.
    Real builds are going to be automised via the build process.
}

const
  APP_VERSION_MAJOR    = -1;
  APP_VERSION_MINOR    = -1;
  APP_VERSION_IDENT    = 'ide-build';
  APP_VERSION_BUILD    = -1;
  APP_VERSION_NAME     = '';
