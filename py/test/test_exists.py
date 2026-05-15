# ProjectName SDK exists test

import pytest
from jmespathfree_sdk import JmespathFreeSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = JmespathFreeSDK.test(None, None)
        assert testsdk is not None
