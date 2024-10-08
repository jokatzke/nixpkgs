{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,
}:

buildPythonPackage rec {
  pname = "aiorussound";
  version = "2.2.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "noahhusby";
    repo = "aiorussound";
    rev = version;
    hash = "sha256-X7KdIjfPNZSsSXYN1gVqTpcgM00V1YG3ihxutmYnb6Y=";
  };

  build-system = [ setuptools ];

  doCheck = false; # no tests

  pythonImportsCheck = [ "aiorussound" ];

  meta = with lib; {
    description = "Async python package for interfacing with Russound RIO hardware";
    homepage = "https://github.com/noahhusby/aiorussound";
    license = licenses.mit;
    maintainers = with maintainers; [ hexa ];
  };
}
