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
