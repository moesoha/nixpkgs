{ lib
, buildPythonPackage
, fetchPypi
, cmake
, numpy
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "iminuit";
  version = "2.19.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-9NHLrM8RXNxIZpaPZJ8qN3lKXA3gGN6BVqp0VWNQpUw=";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    numpy
  ];

  dontUseCmakeConfigure = true;

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = with lib; {
    homepage = "https://github.com/scikit-hep/iminuit";
    description = "Python interface for the Minuit2 C++ library";
    license = with licenses; [ mit lgpl2Only ];
    maintainers = with maintainers; [ veprbl ];
  };
}
