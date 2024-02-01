| writer path |
path := (CfsPath named: '<insert path to root sortfunctions local repo here>').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'SortFunctions';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
