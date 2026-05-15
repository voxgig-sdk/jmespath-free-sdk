package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewJmesPathEntityFunc func(client *JmespathFreeSDK, entopts map[string]any) JmespathFreeEntity

