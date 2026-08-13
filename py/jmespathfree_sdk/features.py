# JmespathFree SDK feature factory

from jmespathfree_sdk.feature.base_feature import JmespathFreeBaseFeature
from jmespathfree_sdk.feature.test_feature import JmespathFreeTestFeature


def _make_feature(name):
    features = {
        "base": lambda: JmespathFreeBaseFeature(),
        "test": lambda: JmespathFreeTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
