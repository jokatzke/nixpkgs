{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, python
, setuptools
, numpy
, numpydoc
, psutil
, pyyaml
, sphinx
, pandas
, pysam
, six
, bedtools
, zlib
}:

buildPythonPackage rec {
  pname = "pybedtools";
  version = "0.9.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-WGpiaJWxtyFa74d+mFwD/YqQj9bGNuW5/4oaHQmh1RQ=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  buildInputs = [
    zlib
  ];

  pythonPath = [
    bedtools
  ];

  propagatedBuildInputs = [
    numpy
    pandas
    pysam
    six
  ];

  nativeCheckInputs = [
    numpydoc
    psutil
    pyyaml
    sphinx
    pytestCheckHook
    bedtools
  ];

  preCheck = ''
    mv pybedtools/test .
    rm -r pybedtools
    mkdir pybedtools
    mv test pybedtools

    substituteInPlace pybedtools/test/tfuncs.py \
      --replace \
      "testdir = os.path.dirname(__file__)" \
      "testdir = '$out/${python.sitePackages}/pybedtools/test'"
  '';

  disabledTests = [
    # this test requires an internet connection
    "test_chromsizes"
    # this test relies upon statefully accessing the user's ulimit
    "test_issue_303"
  ];

  pythonImportsCheck = [
    "pybedtools"
  ];

  meta = with lib; {
    description = "Wrapper around BEDTools for bioinformatics work";
    homepage = "https://github.com/daler/pybedtools";
    changelog = "https://github.com/daler/pybedtools/blob/v${version}/docs/source/changes.rst";
    license = licenses.mit;
    maintainers = with maintainers; [ jokatzke ];
  };
}
