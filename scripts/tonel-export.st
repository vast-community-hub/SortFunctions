| writer path |
path := (CfsPath named: 'path/to/repository').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'SortFunctions';
	addLatestConfigurationMapNamed: 'Test SortFunctions';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
