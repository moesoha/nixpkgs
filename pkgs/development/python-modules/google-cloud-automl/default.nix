{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, google-cloud-storage
, google-cloud-testutils
, libcst
, mock
, pandas
, proto-plus
, protobuf
, pytest-asyncio
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "google-cloud-automl";
  version = "2.10.1";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-pS/fm9837vmdvh6msk69nTeo/gj1StxsfFf6DsmOQE4=";
  };

  propagatedBuildInputs = [
    google-api-core
    proto-plus
    protobuf
  ] ++ google-api-core.optional-dependencies.grpc;

  passthru.optional-dependencies = {
    libcst = [
      libcst
    ];
    pandas = [
      pandas
    ];
    storage = [
      google-cloud-storage
    ];
  };

  nativeCheckInputs = [
    google-cloud-storage
    google-cloud-testutils
    mock
    pandas
    pytest-asyncio
    pytestCheckHook
  ];

  preCheck = ''
    # do not shadow imports
    rm -r google
  '';

  disabledTestPaths = [
    # requires credentials
    "tests/system/gapic/v1beta1/test_system_tables_client_v1.py"
  ];

  disabledTests = [
    # requires credentials
    "test_prediction_client_client_info"
  ];

  pythonImportsCheck = [
    "google.cloud.automl"
    "google.cloud.automl_v1"
    "google.cloud.automl_v1beta1"
  ];

  meta = with lib; {
    description = "Cloud AutoML API client library";
    homepage = "https://github.com/googleapis/python-automl";
    changelog = "https://github.com/googleapis/python-automl/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
