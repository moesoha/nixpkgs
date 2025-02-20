{ lib
, aiohttp
, buildPythonPackage
, fetchFromGitHub
, pytest-asyncio
, pytest-httpserver
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "vt-py";
  version = "0.17.4";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "VirusTotal";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-4CmSsSZqFhH3rwctCJUqU4JdDxBgIxFnUZ5FQCBZXqg=";
  };

  propagatedBuildInputs = [
    aiohttp
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytest-httpserver
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "'pytest-runner'" ""
  '';

  pythonImportsCheck = [
    "vt"
  ];

  meta = with lib; {
    description = "Python client library for VirusTotal";
    homepage = "https://virustotal.github.io/vt-py/";
    changelog = "https://github.com/VirusTotal/vt-py/releases/tag//${version}";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
