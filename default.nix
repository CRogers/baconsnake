with (import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs-channels/tarball/4db8ca39cf56a3b32af9fd589b81bf487a6b43c3") {});

stdenv.mkDerivation {
    name = "nodejs-foo";
    src = null;
    buildInputs = [ nodejs-6_x ];
}
