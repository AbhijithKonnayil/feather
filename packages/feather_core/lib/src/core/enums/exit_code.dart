enum ExitCode {
  success(0, 'Successful termination'),
  usage(64, 'Command line usage error'),
  data(65, 'Data format error'),
  noInput(66, 'Cannot open input'),
  noUser(67, 'Addressee unknown'),
  noHost(68, 'Host name unknown'),
  unavailable(69, 'Service unavailable'),
  software(70, 'Internal software error'),
  osError(71, 'Operating system error'),
  osFile(72, 'Critical OS file missing'),
  cantCreate(73, 'Cannot create output file'),
  ioError(74, 'Input/output error'),
  tempFail(75, 'Temporary failure'),
  protocol(76, 'Remote protocol error'),
  noPerm(77, 'Permission denied'),
  config(78, 'Configuration error');

  final int code;
  final String description;

  const ExitCode(this.code, this.description);
}
